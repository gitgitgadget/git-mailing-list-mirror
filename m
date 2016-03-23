From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 4/4] mingw: skip some tests in t9115 due to file name
 issues
Date: Wed, 23 Mar 2016 23:44:08 +0100
Message-ID: <56F31C38.8010809@web.de>
References: <cover.1458668543.git.johannes.schindelin@gmx.de>
 <7b4eca83305ec05af6434ff80269ba563f2d581d.1458668543.git.johannes.schindelin@gmx.de>
 <56F18F5E.9090301@web.de> <xmqqbn66gs4k.fsf@gitster.mtv.corp.google.com>
 <56F1CACA.5040709@web.de> <xmqqtwjydsub.fsf@gitster.mtv.corp.google.com>
 <56F22F85.3010507@web.de> <alpine.DEB.2.20.1603231148510.4690@virtualbox>
 <xmqq37rhdw77.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 23 23:44:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1airW1-0005Db-Dm
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 23:44:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422AbcCWWoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 18:44:34 -0400
Received: from mout.web.de ([212.227.15.4]:55056 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751466AbcCWWod (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 18:44:33 -0400
Received: from macce.local ([93.222.33.14]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0Mb8xf-1aShXX1YFf-00KiaO; Wed, 23 Mar 2016 23:44:16
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.7.0
In-Reply-To: <xmqq37rhdw77.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:qapDxJ0Yv5AzgK/mRwB64XkCjJ9bv6bgEG5LGHEitXMukNMmC/d
 wWnZuDoAxRM2Vn1FvLFRqbX4ZAI2qKHbWgKkoRuDbA4wGP5Lc/WEsOxYQi6DpQrCU5yGpK+
 3Pr2OfGMiY/LB7zprnH6b3z+XP8SjkKFJEEg6fktXZs9azRyhFavi1vbSw++NQc5gnyEFps
 0UekO9duj4KHQ5E+6iULg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5GVrjzoXMM4=:IaQfV9HqIdeEFbH8Hnan7x
 UHJsuQCixCk+ClCGkSBhVQOKR9/rkHvHCfCV5fF/C4naecPqlfRhPCYwD8APdhuQ0wooC2lnn
 Uo3ilF03f4CEflg6+nk5vSUoX85IR7mWge551C+tnEhqsgUtO2NCry2i9/5ZyXoo3Lef6AE2u
 /BfEXXd+XryxwIMXAPAxLEDzlkf/2hCsB9vfb6ZPoMWMvR4Fiw2KYSHsoVxAcyNx7Q7ArXG4N
 wbxdab5vIQOPMyhCx9+/0XA34pcBtHi96s3wQVTCf9KVUv2pohxeGV33lpapLOphc7JoTP5aJ
 0tx9r22Lugn/m6Tt+yw4eDuotm6qy2KFy97L6OUeJoPSdv2WxKR/JTCFm5z6J7JjQ3dyVqOFu
 5H/0ylZvh8rKXVXZRL0lFXHu8qIeDeDlP5UySi3AOF+g4BhvVZKzFiGMU1bMPuEjKRxmVHanM
 +BruB1QFDZlihyatSjG5puwhDAOG43nH0UZ2Ae6r3PQzqk1O+dhuWKGQi6VcbO7tGLJ43vmfi
 5i3eYpJ31WBxHzQ59ebI1fyMdpjQY2ukwjUMJsbgakjaVZjcUXbQMOSOYHvuFs3HZabQ+Ubjt
 HwZPnsJW/uaJI3BccZgf9s20p41VjnXc4MdOAqpOJb12x/wAfNWv7p0ZzDAC8Wd+e6bhj8UVM
 n2gO/pBp00x52HirZPO4mySVZuOt6xL7BNMppExDk/FhqYrikFzpJoTqTAXPHzHw2D04q0pXA
 MJYG8o1wprNByaw4FURn0iDZY3D5KhgWQabh2xVKoxCSTQcL+uW7tDjPwJmT9PsbgEYOmTXD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289689>

> 
> Thanks; Torsten, sorry but could you do another round of check, please?
Thanks, v2 tested OK under Mac OS and Linux
