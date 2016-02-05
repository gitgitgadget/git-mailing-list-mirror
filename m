From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH 8/8] one ugly test to verify basic functionality
Date: Fri, 5 Feb 2016 14:38:14 +0100
Message-ID: <CA+EOSBn_HB8LABaN497zkr6tvCdqoQXhK=ecsLMx2c5CaJRg1A@mail.gmail.com>
References: <1454662677-15137-1-git-send-email-pclouds@gmail.com>
	<1454662677-15137-9-git-send-email-pclouds@gmail.com>
	<CA+EOSBnZVuHThXLg9+VftPVaKy5wqqxp=iQtP1ZUtxkKq32HMQ@mail.gmail.com>
	<alpine.DEB.2.20.1602051417490.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 05 14:38:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRgaf-0006zD-PS
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 14:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753729AbcBENiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 08:38:20 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:35550 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753622AbcBENiP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 08:38:15 -0500
Received: by mail-vk0-f65.google.com with SMTP id e185so2506049vkb.2
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 05:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EHo91MUDfIg2M9Gh53LFo6+NLz3EEmSj6ZZYMNYG1Ew=;
        b=Vg80+hz9OWOBomQ2dgIyb/BApmEM4J1rNe7OJjTRc7Lc8ICvI/L7FhVYxMpWxc6Dn3
         dq1LDnM2kcLVjt2xgxgiDJGsNda8ZRMpCH1r8LDQm/RIwi62Z3Pxuzb8Aw3V55cBsmAz
         Dv72Jj+qTL8Ens3h2FTdBqhRNiUVZrfqVkX7Gc6IfxZcEoSK6CtGVzWuMrxN/SgrDeO7
         zZ716NSbBCkXZVSILgJmLJo67qIlSk51MgIQ5L3R3oSIibyjluFfnwWBaRwcn0dYcelB
         FHep20r0sCBfjdkmPWXXO/GkK5jgAQl24dFx38XgXUfsQ+OJNmU6Z4acobPYZ9PajmYn
         GBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=EHo91MUDfIg2M9Gh53LFo6+NLz3EEmSj6ZZYMNYG1Ew=;
        b=ELotmW8AtoWyT2/WsX2Bw4R/urFwoGZP+EbaKb1EwGhTpaAiEYhwqPeaJlbQ/+wMaU
         QAPvkc0JL1/JmF/BIf2lAiFbM5ivnzW9vAQ3LI8hGZEpDDrIcqTpPKmzAXOYt/Oh5A03
         zYfUYJW9lgosud7IkQI0I1Ly4/LAMy79SNRQymWgPXpDM2n/nZWrMdyq15/8eF+VsY/Q
         2QgtNHlGYuGeK/PW3LSCeop1gpN0pAvmOm8zzvB3Rs/TqZLidXw6XR9tjXRBg27Okn6R
         NnpzXa8kpyQmksxf+PHTP0TnC1QR+V+BrDjj77YQhnYrFVG0WVcIIbf5EnDjFrK80qjD
         C76Q==
X-Gm-Message-State: AG10YOTzlifgJfPk7ZTQf5wcgIz3XQpJyqwahtTLq0Bj62OpekeKakJXwX7a5u3gGCwLylMwZutiohQBM5ggmA==
X-Received: by 10.31.180.85 with SMTP id d82mr8432350vkf.83.1454679494961;
 Fri, 05 Feb 2016 05:38:14 -0800 (PST)
Received: by 10.31.56.10 with HTTP; Fri, 5 Feb 2016 05:38:14 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1602051417490.2964@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285578>

2016-02-05 14:20 GMT+01:00 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi Elia,
>
> On Fri, 5 Feb 2016, Elia Pinto wrote:
>
>> From the git coding guideline : "We prefer $( ... ) for command
>> substitution; unlike ``, it properly nests.  It should have been the way
>> Bourne spelled it from day one, but unfortunately isn't."
>
> There was only one time in my life as a developer when I had to change a
> $(...) to a `...` construct. I do not really remember all the details, but
> I think it was on MacOSX, and it was inside a case ... esac and the
> closing parentheses was mistaken for a case arm (the $(...) construct
> might have been multi-line, is the only thing that would make sense in my
> mind.
>
> Did you hear of similar problems?

I not personally. The autoconf manual does not seem to me (for that i
can remember) to mention this possible incompatibility, for example.

Best

>
> Ciao,
> Dscho
