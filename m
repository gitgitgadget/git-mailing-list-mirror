From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: 'git replace' and pushing
Date: Fri, 26 Nov 2010 21:29:30 +0100 (CET)
Message-ID: <alpine.DEB.1.10.1011262114410.17721@debian>
References: <AANLkTinzPCeCJ486cysmk981HE61=dv9MS7E8Ap4rQ5r@mail.gmail.com> <4CEE2060.4020507@drmicha.warpmail.net> <AANLkTimQ3fjPb+YVJ5i8EAgui+gd5rfnXMvdQPJPeUtA@mail.gmail.com> <20101126214325.GC23462@burratino> <7vvd3jptch.fsf@alter.siamese.dyndns.org>
 <AANLkTi=FjSFLsbXf2Rp_Onm26yyxX+xSPrh2pB=_f5RU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Cory Fields <FOSS@atlastechnologiesinc.com>
X-From: git-owner@vger.kernel.org Sat Nov 27 03:29:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMAXR-0000AT-5Y
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 03:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753725Ab0K0C3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 21:29:15 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55621 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753565Ab0K0C3P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 21:29:15 -0500
Received: by vws3 with SMTP id 3so552038vws.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 18:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type;
        bh=PijT14kAO5yLG3resClGF0k4fNK3uLdEKwr1cI9ikBo=;
        b=HL/CldWMP+DOoNhDII5yjur9b0ylwsaczoPSovuuClZA9+7acMA5EMb15JZ6I1NoWv
         IG0wV+pvrEj7ZzsZqdAlKjlQYUQIqW57gRO0oQ8k4Sd97DYq6bT5cfmlBlo8s2dMAplX
         GvByxCZyTqCVaPh1J9HLkjOU/RGg3scSsXFiI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=gCqvoWzl4JGEcRPM0x26RVmDRTMoZuLpiuIND3JzWEY4w+Nectz3g1fLOZwxFLFkvk
         jGO4LZzSmZkP1+tX3a67ZQUkCT+F+XgSksYstvpofu/d7S1ZVWIOXxurYNk0ZbvTTiY9
         uPK4TdkwROjPmFe79lXLhXZaPmAejcLqiYMuc=
Received: by 10.220.186.10 with SMTP id cq10mr739821vcb.111.1290824954284;
        Fri, 26 Nov 2010 18:29:14 -0800 (PST)
Received: from [192.168.1.103] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id p22sm351395vcf.44.2010.11.26.18.29.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 18:29:13 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <AANLkTi=FjSFLsbXf2Rp_Onm26yyxX+xSPrh2pB=_f5RU@mail.gmail.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162296>

On Fri, 26 Nov 2010, Cory Fields wrote:

> A shallow clone does not fit for us, because we want the default clone
> to only pull half.
> Having a public 1gb repository that will be cloned quite often is
> bound to make our host
> unhappy, so we're doing everything we can to get the size down.

At the GitTogether last month, my colleague brought up the subject of
how to cope with repositories growing over time. The conclusion from
the discussions was that shallow clones would proabably be the best
option in general. FYI, even though it may not help you right now,
having a default shallow clone depth configured in the repository on
the server was also discussed.

/Martin
