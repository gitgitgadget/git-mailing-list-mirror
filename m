From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sun, 9 Jun 2013 18:18:51 +0530
Message-ID: <CALkWK0mu2_9M5aTczcEkv37eLaAg5_mGDZ_W9nqQFoesB4wc3g@mail.gmail.com>
References: <1370643409-3431-3-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8AMMCWSFC6EUHAgZdDA7E1kSPE3ZO6qGvS+WGji-di=Rw@mail.gmail.com>
 <CAMP44s29GiGJq3wyXAzJNo0FJY+Vbgd18bpBJMYQ47h-3M6sWA@mail.gmail.com>
 <CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
 <20130608164902.GA3109@elie.Belkin> <CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
 <20130608173447.GA4381@elie.Belkin> <CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com>
 <20130609014049.GA10375@google.com> <CAMP44s3CGHVLnkUxo=PR_b+_dTuaz5rwems_pd9GE1_vcEaYRA@mail.gmail.com>
 <20130609052624.GB561@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 09 14:49:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulf3w-0008Td-Uw
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 14:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647Ab3FIMtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 08:49:33 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:49619 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906Ab3FIMtc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 08:49:32 -0400
Received: by mail-ie0-f171.google.com with SMTP id s9so14380049iec.2
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 05:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0yG/qfH99+CEC0Cf4k0y/JU6ZsOLV6VUs1qEQCRyUjk=;
        b=wZGeQrHjkWOUCixdwUERa93r3nZ6ok2SmvJFIETTueZ+X29TbEk0bNsVvKzV+Zx0D0
         0UtgUGe6DqYwpEKFPHdpk2/zIU9N+cZF5PXUXm0A2KqaLaRKt9m6HiK7G7Fk/55cpoQE
         wwrKJQKJfP7lpZEsQoVEsmriWvcqXF8eOJkiMkPy/Z7hJzN1pt4cwp8syhs1LijCdCsk
         OOhvaO7eaCmbG87CqoJXFzAfo3eXyEFQiwH15VdIEw8+hoEMQBMxAn0I2g+6JkE/MqcC
         m3szrS4JzxUJSGTxG/DG5xmiA6GFR7n3RWBlrN9bFKwOx4AFBc3Gny88OsAxSuf2sENW
         MEBg==
X-Received: by 10.43.88.70 with SMTP id az6mr2340320icc.10.1370782171770; Sun,
 09 Jun 2013 05:49:31 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sun, 9 Jun 2013 05:48:51 -0700 (PDT)
In-Reply-To: <20130609052624.GB561@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226960>

Jeff King wrote:
>> > Definitely, yes.  Even if you look at the impact on code alone and
>> > don't care about the people, destroying a collegial work environment
>> > is harmful enough to the code to outweigh the (admittedly often
>> > useful) patches.
>>
>> A collegial work environment is overrated, and proof of that the Linux
>> kernel, where honest and straight talk is the bread and butter of the
>> mailing list. And the Linux kernel is the most successful software
>> project in history by far. It's code that speaks.
>
> I have consistently found your demeanor on the list to be very
> unfriendly and difficult to work with. It is one thing to have honest
> and straight talk, and another thing to be obstinate, unmindful of
> feedback (both with respect to technical details, as well as to
> communication styles), and disrespectful of other people.

While I agree that being rude and obstinate is definitely undesirable,
and that a healthy on-list environment is important, I have something
to add:

Being super-tactful comes at a cost.  Regulars on the mailing list
have to spend 3~4x the amount of time to compose an email (reading and
re-reading their drafts to see how to express them in a more friendly
way); this leads to a lot of inefficiency and creates a suffocating
environment in which people don't have freedom of expression.  I would
much rather prefer straight talk where nobody reads into what is
written and takes offense.  In this case, jrn took offense and talked
about how he would ban fc from the list if he were managing it: while
I'm not defending fc's tone, I'm not defending jrn's comment either.
jrn has been around since mid-2008, and fc has been around since
early-2009.  It's mid-2013, and they still haven't learnt to work with
each other.

Disagreement is healthy, and is the foundation of progress.  When it
comes to sensitive issues, stern disagreement is often mis-interpreted
as disrespect (or worse).  If we keep beating up disagreements on the
basis of tone and demeanor, git.git would go nowhere.  Sure, it would
be more ideal if fc's tone were friendlier [*1*], but it isn't: let's
deal with the issue instead of constantly whining about it.

[Footnotes]

*1* Oh, and mine too.  I've been told several times off-list that my
tone is unfriendly.  I'm working on fixing the issue, but I don't
enjoy the constant suffocation: I should be able to say what I want
without too much effort.
