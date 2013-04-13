From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] transport-helper: report errors properly
Date: Sat, 13 Apr 2013 01:43:26 -0500
Message-ID: <CAMP44s3gOXvHknN1yXQcDYP=OBfjm7=eJnSkh5cj5QJNOarEWQ@mail.gmail.com>
References: <20130410211311.GA24277@sigill.intra.peff.net>
	<20130410211552.GA3256@sigill.intra.peff.net>
	<CAMP44s02K5ydKLNi0umMkuAicoVTWyCdVfjs0yssCa2oyFShGQ@mail.gmail.com>
	<7vfvywj4au.fsf@alter.siamese.dyndns.org>
	<CAMP44s2QJJnSRVVJscLsTnXk5zdGbA2utefF5SO7=90+ttENew@mail.gmail.com>
	<7vd2u0hdmj.fsf@alter.siamese.dyndns.org>
	<CAMP44s1pZW6OJ2nkegKFQq6=npPSiD4dX_z37t63B9baaFW16w@mail.gmail.com>
	<20130413060031.GA22374@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 13 08:43:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQuBS-0005ZC-P7
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 08:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860Ab3DMGna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Apr 2013 02:43:30 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:45300 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126Ab3DMGn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Apr 2013 02:43:29 -0400
Received: by mail-la0-f47.google.com with SMTP id eh20so2063295lab.34
        for <git@vger.kernel.org>; Fri, 12 Apr 2013 23:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=OAQZ3U1wXeSmQdQtNpMdwW9HfsTCpBA0U2RHwoXqJ6Q=;
        b=qd5cY6WYEjVbvarIOW2ENiBsQ7N6S9bOhNXWnkUdjoV3X6o698EWVyO8AjppLu9S3s
         dhDb//F1jgp2HGZZ8gX/0FHsWDeaPyEddeoPi0q07G0nep67XvP7zbejXu66WXcU6tmh
         Sti61ykCMby3yA98SzJ5dB1gubs/v7Q8WaJfJttG5Eh6uLhpkmS6eY65K7fdxuZnY6+y
         uiqiH4iz0usv07hBH2IjvOohs0mTueEC1bhCnfgsneDCA3uLVyL6PqAWRKAVTwdOth05
         Z7mLKOEkubvlOCn5/jqThH5bpWkM1pvuMfEE1vvuX0mZE72v4MGIJ9SvNv0UOQTvDFRR
         u52w==
X-Received: by 10.112.139.226 with SMTP id rb2mr6825382lbb.12.1365835406883;
 Fri, 12 Apr 2013 23:43:26 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Fri, 12 Apr 2013 23:43:26 -0700 (PDT)
In-Reply-To: <20130413060031.GA22374@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221054>

On Sat, Apr 13, 2013 at 1:00 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Apr 13, 2013 at 12:42:29AM -0500, Felipe Contreras wrote:
>
>> To me, the reality is obvious: my patch didn't require such a big
>> commit message, the short version was fine, the only reason Jeff King
>> insisted on a longer version is because the patch came from me.
>
> Get over yourself. The reason I suggested a longer commit message for
> your commit is because after spending several hours figuring out what
> the current code did, and what it should be doing instead, I wanted to
> document that effort so that I and other readers did not have to do it
> again later. I didn't even review the other patch you mention, so I
> could not possibly have come to the same point with it.

The double standard might not come from you, perhaps you subject all
the patches you review to the same standard, it comes from the fact
that the patches you review have an unfair disadvantage.

> But hey, if you want to have paranoid fantasies that I'm persecuting you
> (by writing the longer commit messages for you!), go ahead.

You don't persecute me, you persecute my patches. I could almost
picture the moment you see a patch is coming from me, you have already
decided to rewrite the commit message, even before reading it. Antoine
is not me, so you simply didn't review that patch.

> If you don't want me to review your patches, that's fine by me, too; our
> discussions often end up frustrating, and it's clear we do not agree on
> very much with respect to process or design. But if you don't want that,
> please stop cc'ing me when you send out the patches.

This comment was directed towards Junio, I do hope he is able to see
the double standard. As for you, I think your reviews have value, but
I also think you dwelling in irrelevant details do slow things down,
which is not too bad, what is bad is that you assume that your
opinions are facts (e.g. the commit message need to be bigger), and
get angry when somebody disagrees with them.

Cheers.

-- 
Felipe Contreras
