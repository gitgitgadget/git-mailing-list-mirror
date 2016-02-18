From: Stefan Beller <sbeller@google.com>
Subject: Re: GSoC 2016: applications open, deadline = Fri, 19/2
Date: Thu, 18 Feb 2016 10:38:28 -0800
Message-ID: <CAGZ79kbGyCTdq4P02fNb7tEuvkvqcZviWJp40Ob1ed6=JCh9Xg@mail.gmail.com>
References: <vpqoabox66p.fsf@anie.imag.fr>
	<20160217172407.GD1831@hank>
	<448280D1-3EEB-40DF-9886-C9B620E32E3C@gmail.com>
	<vpqh9h7f9kz.fsf@anie.imag.fr>
	<1CE3F5E2-DDCC-4F1B-93CF-1A4A194650BF@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 19:38:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWTTG-0006Jd-NX
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 19:38:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1426908AbcBRSia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 13:38:30 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36919 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1426906AbcBRSi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 13:38:29 -0500
Received: by mail-ig0-f172.google.com with SMTP id 5so19476384igt.0
        for <git@vger.kernel.org>; Thu, 18 Feb 2016 10:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=8umozYVccwcShaFI7H+C/ZEGFizXY/AKsU5+D94sLro=;
        b=QNjvJf+DPipvJC26+FHEkbz7Mnt4OjKOgw0urkpWxd8hNnK+L3neqZRT2ppdCVtRbT
         VuBexDMVr68N+Wh9z45FizM1MGuCM5IfaV875aMd0GVFzwx55Cn3hBjESVz7FPFXfx8f
         TyfV8YnTEJOGOHxjSJOVCGJxvukjegif97WZp1iSE444lsRJSBETu5uziO5l4WbfUhYP
         jZ7hqstbprh0MIi69tZ47VlnZS9dWMviHlCnarVqY4NtMjhe68APz4si2Pzo+k23nJts
         9syGPoagdkZScisRbUTV7Xc4TlFpONe78cGSjXMf1PxB4E22Yktr5jTmoY/5e6yNG8UC
         K/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=8umozYVccwcShaFI7H+C/ZEGFizXY/AKsU5+D94sLro=;
        b=O+7wTLPGT5Wy0giS/nDOqWIuztOocIfWGMOWS7lpAFPdKrmJyHwlPRIxFJp5VctywU
         oBMT+ecoS/YfSWxzVx45/34+G2rp9qE+T0m+MA+PneK1EbBx8df3m6jrVhCDYr4oQUb2
         faoo3ErOCX7Ck+rFvZT98Pu/WKt02Oy8msLJ97ywRo3q5Kfe52kfAXAWYerHmjYMfXpF
         e+hOaQWNurE8mtgEExLgqBQ5s4my9uWzVMba8rQi1+BPS6h3z8dvC2+quBDr/Z6qR3YB
         8uG/L+1K2A/QxGmGVrehY7EoSeJdgGiKiEH5sj3Pa26zrjs0kavyAV8K5b5NgxdFGTDD
         aZdA==
X-Gm-Message-State: AG10YOR/siGryp7T6gBdXoSK0VGfUR5mgkUcgGQBzI94KJRitYLP/Jr9ZilMqd7s+SSaTo6DlAT8xLANwHjL6o0r
X-Received: by 10.50.138.76 with SMTP id qo12mr4882372igb.85.1455820708917;
 Thu, 18 Feb 2016 10:38:28 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Thu, 18 Feb 2016 10:38:28 -0800 (PST)
In-Reply-To: <1CE3F5E2-DDCC-4F1B-93CF-1A4A194650BF@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286613>

On Thu, Feb 18, 2016 at 12:41 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>> Feel free to start writting an idea for
>> http://git.github.io/SoC-2016-Ideas/. It'd be nice to have a few more
>> ideas before Friday. We can polish them later if needed.
>
> I published my ideas here:
> https://github.com/git/git.github.io/pull/125/files

I like the idea of a beginner mode, but on the other hand that looks
inflexible to me ;)
(What if I want to use rebase, but not reset --hard?)
I am confused by the black white mode, did you switch allow and deny in there?


>
> Do you think that works as start or do we need more detailed, hands-on
> instructions?
>
> Thanks,
> Lars
