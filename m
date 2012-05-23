From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Question about submodules and absolute paths
Date: Wed, 23 May 2012 09:24:50 +0200
Message-ID: <4FBC90C2.6050203@web.de>
References: <CAOmKuSoYP9fYORDy5twLpFh7SQ7rc6x2A=F8XjfKMqo-ErCauQ@mail.gmail.com> <CAOmKuSpqFrC7G4DbZu=uYDwvU6QqrJUi2aNBnSjy7_PXMMJpjQ@mail.gmail.com> <7vk4043wc5.fsf@alter.siamese.dyndns.org> <CAOmKuSrmxnHKaip2X87Y0Cp=XtLAtpAwUp71QhZ5od3gbDF2sg@mail.gmail.com> <70952A932255A2489522275A628B97C31348C70D@xmb-sjc-233.amer.cisco.com> <CAOmKuSqRHMS+hvCXL4Ok6ReTPW-3xT9SunGeibjCCCgVk9SU6Q@mail.gmail.com> <70952A932255A2489522275A628B97C31348C71F@xmb-sjc-233.amer.cisco.com> <CAOmKuSoxf_mRJRyjXj99NQLoa+fD-HU_oUYPrJYPNTPmvhs46g@mail.gmail.com> <7vpq9w2ae2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alexey Pelykh <alexey.pelykh@gmail.com>,
	"Matt Seitz (matseitz)" <matseitz@cisco.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 23 09:25:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SX5wV-00026J-Kn
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 09:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737Ab2EWHZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 03:25:04 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:42989 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134Ab2EWHZC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 03:25:02 -0400
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate02.web.de (Postfix) with ESMTP id EEBDB1C4D0D62
	for <git@vger.kernel.org>; Wed, 23 May 2012 09:25:00 +0200 (CEST)
Received: from [192.168.178.48] ([91.3.153.206]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0M4Zlk-1S7irf2w04-00yla1; Wed, 23 May 2012 09:24:59
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <7vpq9w2ae2.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:fbQ3emXZDXisdVxkBY3JVJPN+IO3mF8CmjnmcEI3uuJ
 yt3+M191UHIGfaz2kkJnq95tohC2J9jeNW57IOJSSYyBsNOVWg
 lvqEx3DVVVsggvKXKlrV0M8R/qD5CfyZZ1XCT4IG8WMoG6wWhM
 ir/Vwnt/4NUGlhIGRMSPozEv245bKXowLqRwqb2ls3Z6Re8d4C
 KB9bdTt83WW9bEklVF7qg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198274>

Am 22.05.2012 23:06, schrieb Junio C Hamano:
> Didn't the submodule folks worked on the related area recently, and
> doesn't the result of their work already in v1.7.10?
> 
> I am thinking specifically about the series around d75219b (submodules:
> always use a relative path from gitdir to work tree, 2012-03-04).  Jens?

Yes, these changes should fix the problem described by Alexey.
