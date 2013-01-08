From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Mon, 07 Jan 2013 22:12:53 -0500
Message-ID: <50EB8EB5.6080204@gmail.com>
References: <2491041.bQ51Qu8HcA@thunderbird> <1890551.8jTmplCF6O@thunderbird> <BB541ECCD3F04E479F06CA491DDB598D@black> <50E92675.4010907@web.de> <20130106093211.GB10956@elie.Belkin> <50E946EB.1000709@web.de> <20130106095757.GC10956@elie.Belkin> <50E9647F.4090209@gmail.com> <20130106120917.GC22081@elie.Belkin> <7vfw2enl2l.fsf@alter.siamese.dyndns.org> <50E9F7C2.1000603@gmail.com> <FBDECCA565D94DF9838DD81FE2E2543A@black> <7v1udxladc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Stephen & Linda Smith <ischis2@cox.net>,
	Eric Blake <eblake@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 04:13:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsPcr-0008W0-1N
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 04:13:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019Ab3AHDM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 22:12:57 -0500
Received: from mail-qc0-f176.google.com ([209.85.216.176]:33050 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785Ab3AHDM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 22:12:56 -0500
Received: by mail-qc0-f176.google.com with SMTP id n41so13455571qco.21
        for <git@vger.kernel.org>; Mon, 07 Jan 2013 19:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=69dSrhBEm2LaSLqV1YgSiX7mFyuSyJpkTiraYtpzV9c=;
        b=yxPUNdg1e/VxTRTKk8Iu1dHTTQDB43A/gt3NG7EReN8L25YUd5cuOmv/sRpVqS+y4b
         Ea4YONuYZHdQXhwweDm/pmfvucvIuvM2I6l9W92/yjULbkI7+6VBh1RP0tpUTriF8n4Q
         E1nXyVy2o6hz7+1c+4Fu6SxhzL3l9laypwZqtkP/TyoFKUOZAzDyPcmEbc/D4rgqIybJ
         tqa3+CG/b85fh/LOk/WAKq6Uc76C7ameKkQarByihVN5MHW2dBp8qGzke+92Y/DN2Xsq
         NxlaydPx9onRFKy+rCBFg03TBf2zcD5F93FaFhDmNCl5tefWIb/1KK1eMaEbDgRKzaKW
         iyQA==
X-Received: by 10.49.29.135 with SMTP id k7mr53172024qeh.39.1357614775506;
        Mon, 07 Jan 2013 19:12:55 -0800 (PST)
Received: from mark-laptop.lan (pool-173-79-102-236.washdc.fios.verizon.net. [173.79.102.236])
        by mx.google.com with ESMTPS id e12sm21065623qad.1.2013.01.07.19.12.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 Jan 2013 19:12:54 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7v1udxladc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212932>

On 01/07/2013 02:29 AM, Junio C Hamano wrote:
>
> I do not have much stake in this personally, but IIRC, the (l)stat
> workaround was back then found to make Cygwin version from "unusably
> slow" to "slow but torelable", as our POSIX-y codebase assumes that
> lstat is fairly efficient, which Cygwin cannot satisify because it
> has call many win32 calls to collect bits that we do not even look
> at, in order to give faithful emulation.  It does place extra
> maintenance burden
The maintenance burden is the only issue here, and I just wanted to 
point out the origin. I never enable that run-time option, the small 
gain in speed cannot compensate the loss of cross-platform operations 
for my uses. Actually, my git usage is mostly on Linux, but it seems 99% 
of my maintenance time is on the cygwin side that I almost never use. Sigh.

Mark
