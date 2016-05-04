From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (May 2016, #01; Tue, 3)
Date: Wed, 4 May 2016 08:09:54 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605040808340.9313@virtualbox>
References: <xmqqshxykb9k.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 08:10:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axq0h-00083c-24
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 08:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757277AbcEDGKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 02:10:04 -0400
Received: from mout.gmx.net ([212.227.15.19]:49838 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757205AbcEDGKB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 02:10:01 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MEWkb-1aqzRC0CT3-00Fihm; Wed, 04 May 2016 08:09:55
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqshxykb9k.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:5vP92yvSiysN2i6q8cnEwQOktStWCMCoaN/InprqtpItGui7QwF
 6mqWRxTGhvDYTi5rKWxac3Xe4wAmNDFciNYJiEdxyPmVx3wrNbAYsBVYOvYsN7kH5Voj3pS
 M5Kgu31dtlHB168+FL//c77axwFrQNSj9FKKuCE9KMk+kMYsqZKM6xBE79H+68Q6gn8d0CF
 Vm+SvdC3+jgDBxMVhKuog==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eXBzF/C5i/s=:bxCo/ds0J+F8BZS08FcJWU
 VH53DOAUKRj84Lynqrrcq6UdCNZDtYLIPS8uUz5TP+tF9eg8SzVXJhymoI7LNiNmZT4adSJub
 O6O85GlReRV2mH2LpTqkc4TuQfBmal9di+metoHL2VIWmDBc0AbV/CLwKmOpN+0sqUC0iB+Qh
 F8F1C+udOZiH9xU/VLzaOVXjZ0mv/qwJeuj55xQnly6uA1d0pEEmod2mPYuOeNtmFelQvx3Tl
 gpOaFqlnXVUNOAt21zF3HYe8zDIELYmLz6wyaup7B+wDATxgnsK+CpcTIlq8TR7Dkuh0z9IEB
 pcBTIsYFC/hJ2/g246YL8/vvQu30ATQAF70fK5eT7qs+ygJ1SsjD9VqeDI8+wwDpThmQ7hgFK
 Ju2ofI+QXnzmdC/fNnv/0fkV5sGkzgQjXaw6L6Ap2EVZTmRO7AW7WYPAxDxdxbtlSPO9mHfhI
 SqzI4rkNhQJ3tO4bkOBleaRPzJ+deiQl4FeT4V/hlpvlB2iqbf5q6lxRRqp6rpU2yOriFaNgl
 Lt5yyCpF8bX3NMnT5+GYSly8MbpfQJG1WLlBZgS5A1ieonize27WXAGzmq/vO4Wqff4GBog7i
 jTq0CZZNZ8oq7oz2JVYesVSmHmCL1xIvmyRnFGbAUS3eg7j0RWQ5HvsX/BBNS1d4JLkWdbR4w
 KuS9NgdBePGuwREVwPRgm1Qp+F1/4yjRsl2OvVf7brc3v2FtGEBMSyRphtYAhD5xrfOjNqc7c
 2dJf4y4wfHYaU7ai2+vR+6u3gsFYOJhPDgsbluW8W2+4Qj5BJbdvt2ueYSSpbjeUIRYe+IQM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293495>

Hi Junio,

On Tue, 3 May 2016, Junio C Hamano wrote:

> * js/http-custom-headers (2016-04-27) 1 commit
>   (merged to 'next' on 2016-04-27 at 0c97a50)
>  + http: support sending custom HTTP headers
> 
>  HTTP transport clients learned to throw extra HTTP headers at the
>  server, specified via http.extraHeader configuration variable.
> 
>  Will merge to 'master'.

This misses the rather crucial support for `git -c ... submodule ...` that
I sent out earlier. I will send out another iteration with the indentation
as per your wishes. Please let me know whether you want the second patch
as a separate "patch series" instead.

Ciao,
Dscho
