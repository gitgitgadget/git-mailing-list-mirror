From: =?ISO-8859-1?Q?S=E9bastien_Barth=E9lemy?= <barthelemy@crans.org>
Subject: Re: rebase converts merge commits
Date: Tue, 12 Oct 2010 17:23:18 +0200
Message-ID: <AANLkTinZzBGtC9q7J=xD1e7c80O4THdP00+mp==8hbQA@mail.gmail.com>
References: <AANLkTikz0yUv9+EcT-kVwniUf9xnRe=_y96euNb=stzP@mail.gmail.com>
	<20101012145824.GF22067@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 12 17:23:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5ghJ-0007RC-Jz
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 17:23:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309Ab0JLPXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 11:23:20 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36624 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757347Ab0JLPXT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 11:23:19 -0400
Received: by iwn7 with SMTP id 7so875030iwn.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 08:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=rstIwRCXVQfjfD4O28S5UheFwEY/iDJm+ABijAHv73k=;
        b=DOT9+CaBZES+nto7uTFYVPaeI5Z3H0JUTLof1gkzXATIdYmRZSAlLPNpZ5724AiMTK
         CL9QypCUD/LLLds52Nbizwphj7h1+3Rk514KqH40uQC7tW45O7Fu+jgbNahwSySzwmvZ
         1mbUPv47YOLTHYMHj3iuM5Iyw1Dn4YgzrlZHM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        b=UWpeaU3tQ9ADU3/+pDiYxZKUoRt06J4t9TnqzrwE0Jnz3idjrSuB5oXwPNmv55muss
         a+6b/Fmt9QvfhIfHpix38XI283zF6sp6bsgCeRb9eyaSxcPTXDRkabuSiJRzV3m0PVgk
         MMcvcEuBfrU+Qdw+0ORUHoj27lR54TgQxSTkA=
Received: by 10.231.35.77 with SMTP id o13mr5830414ibd.92.1286896998463; Tue,
 12 Oct 2010 08:23:18 -0700 (PDT)
Received: by 10.231.168.8 with HTTP; Tue, 12 Oct 2010 08:23:18 -0700 (PDT)
In-Reply-To: <20101012145824.GF22067@login.drsnuggles.stderr.nl>
X-Google-Sender-Auth: m3LsylTrKXBv_-rMfShkdM2WK7o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158854>

Hi Matthijs,

2010/10/12 Matthijs Kooijman <matthijs@stdin.nl>:
> Have you tried the --preserve-merges option to rebase?

No, I didn't know about this option. Thank you for the tip.

I just tried, and it does not work either. The merge commit is
preserved, but the commit I'm push back in time is lost.

There is a warning against this kind behaviour when using both
--interactive and rebase.

Thanks,
-- 
Sebastian
