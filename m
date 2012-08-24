From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH 1/2] Ignore trailing slash in mkdir() on platforms that can't deal with this
Date: Fri, 24 Aug 2012 20:32:57 +0200
Message-ID: <004701cd8226$e2534ad0$a6f9e070$@schmitz-digital.de>
References: <003101cd81e3$90574490$b105cdb0$@schmitz-digital.de> <7vr4qwyylv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 20:33:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4yhA-00064R-Vu
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 20:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759994Ab2HXSdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 14:33:17 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:64565 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757955Ab2HXSdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 14:33:16 -0400
Received: from DualCore (dsdf-4db5d8d2.pool.mediaWays.net [77.181.216.210])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0M3jZR-1TvIGI2W5R-00rJBu; Fri, 24 Aug 2012 20:33:07 +0200
In-Reply-To: <7vr4qwyylv.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQE1+B09hhwttQYxDz9yeQ5V5W+OSwK0XiBGmIK47/A=
Content-Language: de
X-Provags-ID: V02:K0:M/z979Rq1NaJEx0MHBoQtF9QejNHfox7V9PjVtWYQxb
 yRUIqkk1wkmp1MHjT2KRht/B0Idr30Y8AEA++SjphzhfyeIvS0
 QKDZOzPd2I4H+HDxc7aKP3tqYQ0lYgv7leXcWdWg/F/LL5cP1Z
 /DRffYivsq8sSOp6X9OtmSiQGMCf5ANcoYgXXmh7wBlaFLkQ+D
 3163h/jAupz45HdMKc4I2voxjJD4+Mkcv+F572gsltTxa/74K1
 pbRowK3XbQFVbQXi9qPRyOMD1xZpsQhKjpae18TWwfZhANX68V
 adsqSyIbZx9Lt9faIpRIP+VJIov6+VeCC42Cvl+kIrLBPELhzO
 oxE+QxGa64Z999NTkPUm3dBlH6peUgHxQQ+I4KzOjKGz1wt8QY
 xEqay+dme4gug==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204225>

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Friday, August 24, 2012 7:44 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org
> Subject: Re: [PATCH 1/2] Ignore trailing slash in mkdir() on platforms that can't deal with this
> 
> As the compat/mkdir.c file includes git-compat-util.h and expects
> the declaration of the new function to be found in it, it does not
> make any sense to have this as two patches.  I'll squash them into
> one for now, but it would have been even more complete to have an
> update to the Makefile to actually compile these files in the same
> change.  These things go together.

A changed Makefile is in the pipeline, but right now it is pretty NonStop specific, 
while I tried to keep compat/itimer.cm compat/mkdir.c and git-compat-util.h 
as NonStop independent as I possible could.
That Makefile also depends on the outcome of the discussion about my 
NonStop specific changed in git-compat.util.h
 
> The other itimer set shares the same issue.  I've queued mkdir and
> itimer series as one patch each; please check the result in 'pu'
> after I push it out.
 
Thanks. What does 'pu' stand for?

Bye, Jojo
