From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: history damage in linux.git
Date: Thu, 21 Apr 2016 12:43:53 -0700
Message-ID: <CA+55aFxESRnvr76n601X8dJhZT4qTpiF3GphNhvK2hh4O_GChg@mail.gmail.com>
References: <20160421113004.GA3140@aepfle.de>
	<87lh473xic.fsf@linux-m68k.org>
	<CA+55aFx8hPKKcuwe-HHoO7LHVYLmJ6khndd-OtQotMs3EJzZ0w@mail.gmail.com>
	<CA+55aFzk4rZFdhOjkPDqFC3_tk4BUvx4-STsY2L_tKMH2FxCCA@mail.gmail.com>
	<xmqqvb3aswp0.fsf@gitster.mtv.corp.google.com>
	<CA+55aFwOtyW7zLHdJND=FGBWKBfhQV95RPVRG5gcoRUrtGCrAQ@mail.gmail.com>
	<xmqqmvomsqwx.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Olaf Hering <olaf@aepfle.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 21:44:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atKW7-0001dW-Sk
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 21:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187AbcDUTnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 15:43:55 -0400
Received: from mail-ig0-f194.google.com ([209.85.213.194]:35190 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752781AbcDUTny (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 15:43:54 -0400
Received: by mail-ig0-f194.google.com with SMTP id fn8so11510159igb.2
        for <git@vger.kernel.org>; Thu, 21 Apr 2016 12:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=uSap8C8jZPXjLRprws2t/Nyl7tD0JHhLn4zIPbJzQ2g=;
        b=VauC3NjGd2nxXa5rmjx7cb/okK6fqQIgJizeNR0B2I2FvOrfMuF5ahpLuTjoReBoSg
         C1a4QfXwrJAt03BPTXdM5b4BdzoVP/lg0SHegxcdZzrrUT8LTWXpnyJ8lBqvNzYy71vX
         Byhh+2DJzPY1Xu09+uqm0A3yvyTikck56UBgYkUOUAxZFtXf0eTchqhK7J3G+6lLQOIm
         O8sjCLTPA9n4VXDoBWtmBojxbxmKe1gqdwJpMEo0dGvNGOgeWET1kIax/ZaLuVey1sUp
         iQaQBk2Ev03NjmxesG2r6O6LCcYGoeSU/pVmrpYahfGfuR8MfrXbChf7l7nOqKreZWIs
         eicA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=uSap8C8jZPXjLRprws2t/Nyl7tD0JHhLn4zIPbJzQ2g=;
        b=JdfF4CzuH6EpilJgUv1qXbNN2r8jiDNBmLigxbHEWkqbCTb8NlYUt7rwO/jHK/37EF
         4FxM7Xe40+ZGs7zKvNv7Cv2BV/c60dmDcrRC1aEs9fYeaTaT0QlyR48w90GD7QrTUqNo
         cOZnKbc4gMqsuINrHj+HNEGAN2s+jl9QfbgAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=uSap8C8jZPXjLRprws2t/Nyl7tD0JHhLn4zIPbJzQ2g=;
        b=YKi5/ywdv3mm6X43ztv1l2wOlpMyq0r3fHjAqlobE1rSw5lROFmQQvcQCUSeDFBOAV
         Fjoc6ODZaRZtVzu7fXBsTpx4r2ofFLT1p+NqUuC0AYVG6euZzd49LPJwPpnu9zLMmf1V
         Xnrr3y6uCxyS2Sar2DVE+y2sGFNPg9/B26xjTSWXRvkJ/FY59FNu/WBOw2AACa13tRXG
         CDBqhoVI2RUWLVwMG3qcwj9Pm8+oa2LbA+UaM41Vg/f7WDTjVf+aApSRwhdESX2AyGrU
         2BXrh3rXZWvyID8hgDBc+m80H/lAPXl+cfd6laxkzIwq0MC+8zGeBc+zKEHDG3h41gY+
         sJFQ==
X-Gm-Message-State: AOPr4FU3yUiksEq39TvTfTMIlbDCrRBcUEVveYU85cOPL6MXuY/kStzaB5pF46IrSCjubpzWRqAyuwBFErF95w==
X-Received: by 10.50.36.195 with SMTP id s3mr5881294igj.25.1461267833648; Thu,
 21 Apr 2016 12:43:53 -0700 (PDT)
Received: by 10.36.2.9 with HTTP; Thu, 21 Apr 2016 12:43:53 -0700 (PDT)
In-Reply-To: <xmqqmvomsqwx.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: iOInJXpzpDNwpHJFhepjXRTL1qo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292151>

On Thu, Apr 21, 2016 at 12:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> But this patch is small and simple, and has some excuses for its
>> behavior. What do people think?
>
> I like it that you call it "excuse" not "rationale", as I couldn't
> form a logical connection between your "4 (2) letters" and "10000
> (100)" at all ;-)

Think of the distance number as a "order of magnitude in complexity",
and it actually makes a certain amount of sense.

It's not the same as the length of the string, but the "log()" of the
distance number really does give a kind of complexity value.

Think of it this way: if things are entirely linear (all just first
parenthood), there will be just a single simple number, and the
relationship between the simple distance number (that just increments
by one for each parent traversed) and the length of the string that
describes it will really be "log10(distance)". That's literally how
many characters you need to describe the linear distance number.

So a simple linear distance of 'n' commits will need on the order of
'log10(n)' digits to describe it (ie a number around a thousand will
need around three digits).

The "100" and "10000" are just extending that notion of distance to
the more complex cases., and expresses their complexity in the same
logarithmic units. The same way you need four digits to express a
_linear_ distance of 10000, you need four characters to express that
"~n^p" case of "merge parent p, n generations back".

And if you don't have the generation thing, you only need two
characters to express parent #'p': "^p".

So two characters really *are* equivalent to ~100 linear steps, and
four characters really *are* equivalent to ~10000 linear steps.

So it's not _just_ an excuse. There's an actual rationale for picking
those numbers, and why they are equivalent in a complexity measure.

             Linus
