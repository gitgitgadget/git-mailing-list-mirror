From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Mon, 10 Jun 2013 16:43:11 -0500
Message-ID: <CAMP44s2mu4Q4Gb0f+hsifaDP8CnT2VNHZO7e6dYvYhiyH30PQQ@mail.gmail.com>
References: <20130608164902.GA3109@elie.Belkin>
	<CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
	<20130608173447.GA4381@elie.Belkin>
	<CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com>
	<20130609014049.GA10375@google.com>
	<CAMP44s3CGHVLnkUxo=PR_b+_dTuaz5rwems_pd9GE1_vcEaYRA@mail.gmail.com>
	<20130609052624.GB561@sigill.intra.peff.net>
	<CALkWK0mu2_9M5aTczcEkv37eLaAg5_mGDZ_W9nqQFoesB4wc3g@mail.gmail.com>
	<20130609180437.GB810@sigill.intra.peff.net>
	<CALkWK0kkhDOSSdF=E4PvO24hg++_FpP3YFaGRD3yq80XG0TRJA@mail.gmail.com>
	<20130609184553.GG810@sigill.intra.peff.net>
	<7vppvvnetw.fsf@alter.siamese.dyndns.org>
	<CAMP44s3p1atFz52-mKaKpZkLGp+Uoehc1ovTUQAN-raxWzWd8Q@mail.gmail.com>
	<7v8v2il62c.fsf@alter.siamese.dyndns.org>
	<CAMP44s1x4Dm2KwyuN=oisSFdoCPxYzu+ZjZjHN45_=i7b=z0_Q@mail.gmail.com>
	<vpq7gi1eupf.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Brandon Casey <drafnel@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 10 23:43:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um9sA-0005bU-Ec
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 23:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814Ab3FJVnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 17:43:14 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:54768 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997Ab3FJVnN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 17:43:13 -0400
Received: by mail-lb0-f179.google.com with SMTP id w20so6690452lbh.24
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 14:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DM5bsQf79XZbm4bBuzEdGFtCGnOas+Sx/ZNZ8QMJjQA=;
        b=L7iMdi0anNC6+f9SqNUROIT8yg2rc3ab5B2pKakMDoR6cNh7IvP79dU/5acjQ/rrMY
         TCjJ6Fe53PEURYcwRmnYoWUxjyr4l9uIexcV/XtSAfAYXJbBAakvI0pqBG7PRhZ2icDN
         Xk/Vl07SAhEGveanT9ztjPaNu75lCX71DiaTtlSYjm0V3+go5EtoUt/kNxYrC/+ftSxd
         8UsRnlAUcYithn/5ymwAQwOnfG/EYxc1uFa9QRK+epvc3ei7SJ5cfenNSNs6z7TZHjZ7
         rfPOEncgwDRAnwdXjw64kh+XJw8L5Eh6y6s3pIO6mFLHootudpg7k8BSlgvFS7kKLfGg
         pWNg==
X-Received: by 10.152.22.130 with SMTP id d2mr5427130laf.33.1370900592083;
 Mon, 10 Jun 2013 14:43:12 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Mon, 10 Jun 2013 14:43:11 -0700 (PDT)
In-Reply-To: <vpq7gi1eupf.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227387>

On Mon, Jun 10, 2013 at 12:34 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> It is not bad behavior. It is bad behavior *in your opinion*,
>
> And in essentially everyone else on this list, it seems.

So? An opinion shared by a billion people is still an opinion, not a
fact. To think otherwise is to fall in the argumentum ad populum
fallacy.

>> an opinion that wouldn't be shared by other projects, like the Linux
>> kernel.
>
> Googling your name and LKML gives me this in the first page (addressed
> to you):
>
> https://lkml.org/lkml/2012/4/12/434
> "I'm stupider for just reading your email. Go away."
>
> https://lkml.org/lkml/2012/4/15/112
> "I'll make one more try at explaining to you, but then I'll just set my
> mail reader to ignore you, because judging by past performance (not
> just in this thread) you will just continue to argue."
>
> I don't follow the lkml so maybe I've just been unlucky and Google
> didn't show me an accurate sample, but arguing that your behavior is
> welcome on the LKML seems weird.

Now you are committing two fallacies at the same time; argument from
authority and hasty generalization.

Yes, Linus Torvalds lost his temper with me, he has done so with so
many people that's hardly surprising. I still think he is wrong, but
to prove it I need information that is not readily available, and it's
not that important anyway.

That doesn't mean that Linus' opinion is shared by the list (or any
other Linux mailing list); if you think so you are committing the
hasty generalization fallacy.

And if you think Linus' opinion means something is a fact you commit
the argument from authority fallacy.

None of this mean that my patches are not welcome in LKML, or any
other Linux mailing list.

I repeat what Linus said:

Talk is cheap, show me the code.

-- 
Felipe Contreras
