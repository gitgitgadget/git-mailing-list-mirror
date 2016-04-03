From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 6/7] correct blame for files commited with CRLF
Date: Sun, 3 Apr 2016 11:29:18 +0200
Message-ID: <5700E26E.30409@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
 <1459526911-19985-1-git-send-email-tboegi@web.de>
 <xmqq60w1gdyr.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, tboegi@web.de
X-From: git-owner@vger.kernel.org Sun Apr 03 11:29:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ameLt-00006Q-NG
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 11:29:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633AbcDCJ3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 05:29:45 -0400
Received: from mout.web.de ([212.227.17.12]:57958 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752555AbcDCJ3o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 05:29:44 -0400
Received: from macce.local ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MK20H-1ao1vZ3Iqz-001Ogk; Sun, 03 Apr 2016 11:29:37
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.7.0
In-Reply-To: <xmqq60w1gdyr.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:Og7cnasoJWgaBQHA3MqJosun90crI+z1lhgypjFhOzyLAL5Z/tx
 Yg2PmMaNRr1iIDA29eml5jRjc58e0lTK0UN0PAHwkajV7Q/JOH3XflouPt2NFvQE9NDY/n+
 nXzUEWpgxWPS43o+YxInbtYmCvnVbX9SEpwMhLvm6ya68YdkSFwolkE6QQBFwOhkx/DZhRO
 fJSRUDsnV0lxme5W1YcDQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MXP3QffkGBk=:xFaGpU2w92eA639JDZsnS1
 U1m/YZNealbsEwRF+RR1WyZHBVJ0WawaLllMI6mGs3S3bzXfrGdym57lLR0uvF9lbD4drRJX/
 IpDPlTou0iUisU6puX/WZ+ULmgPmTJ9M3SGL8PuX2uTcs2JDdJtLK5E0FuWrwsAQZcO+DsfGx
 o2OxkSJP60hQ1z/ztTYf3loCWr2eVCHTZTAlUBzxfbCe+qgOjgkwjcehdv2ODrsIeUjjyER5w
 3znCYJ6OmShqnCC54eKDEiqWTvEOEXpt0FfsFr6IrC/VxmTcSUsNilTvdfVy9DcE1BShrBL9g
 X144SengomqEDeU3VAD8nZqPE11LYmLGXTtlSrJhFsJhflVFrkEBUcy7KQaGD+jeZl91wz0T2
 ODSqzL0VUM3NRkofLlcVVrB9cljc1vyoCsOcK1AEic4zF3k/+awLyVWWM/8rEnNeGhU8PacYP
 OAuqz1uyGAo//hTlVp4UGZ3cTxcx0j7tHRF7jf7QHilj9UyyVQ2NR/CXo1Ollu8heBT7OTUCb
 B1GktqLLhUseieYUj7N8z3iHxvZVKaIPHgZxqG4aScJMOLhbFhhSz/nEYwbMFbTpJtWpjAP4c
 1nLjQyQr1m99RgF6agvMehRdXX+1GzxVMJFdS1o9BBsaYjUXLUd+2yXr3cMcXAzqbNhucN/fm
 tgy7w/NPaVWZFLgDdzZk4gKkNEXrVQN6ABS0pUC2atGekt+SNQ/uV7GT12jOvqPpxV0j2A+Wz
 dPDNCeFyh/ySDpPVh+xhBbRP1vLltJqo/D2jF7KuGyRFVNx22iqI3EoTyn7RCl6TX2VLxsiu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290637>

Thanks for all the comments.
I just reallized that t6038 is broken, which I didn't notice before :-(


Please feel free to kick out
tb/safe-crlf-output-fix from pu,

until I have looked into the breakage and found a fix.
