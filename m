From: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Thu, 6 Sep 2007 17:21:37 -0700
Message-ID: <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com>
References: <46DDC500.5000606@etek.chalmers.se>
	 <1189004090.20311.12.camel@hinata.boston.redhat.com>
	 <vpq642pkoln.fsf@bauges.imag.fr>
	 <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
	 <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Matthieu Moy" <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 02:21:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITRbW-0004SO-Hi
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 02:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbXIGAVj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 20:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932695AbXIGAVj
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 20:21:39 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:57873 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932680AbXIGAVi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 20:21:38 -0400
Received: by rv-out-0910.google.com with SMTP id k20so281568rvb
        for <git@vger.kernel.org>; Thu, 06 Sep 2007 17:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=E69ke3L4hZ59egMhsez5eA3ntO5KssXSy/vDsWXaRdw=;
        b=OPoc9a1HWCakHAtqiHtcN8l9Ly7qzlmLPbGihdTD6zLEXZNWKoJZBdUANWAhya3FlorqI5U6eef1Mc8OLK9o0xvoRgePyXOaYeoEMj9r0MTqnyoP+fgg8Y/stNf9YzExj6kFNJwrv+ygK46v5nH+k2T9Uu1I9w2lcVdgagGwt2U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZxI4mKB+KdQSb63vekuT7BP5vMgoox0gt4GdJuPZbiGlJFNgVh7v+jeaKv678PC1/gS5ZyuSdwHrPZmwdeR8nmhD4HYohXu9PzrIn2XFhYUeyLqTayoRTy/KjSKaTISCXtyIsu8T4b6y+HhzHPe/03t/DYnvtHQAm0Qyp1jaFbU=
Received: by 10.140.192.9 with SMTP id p9mr497778rvf.1189124497792;
        Thu, 06 Sep 2007 17:21:37 -0700 (PDT)
Received: by 10.141.204.17 with HTTP; Thu, 6 Sep 2007 17:21:37 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57953>

On 9/6/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Wed, 5 Sep 2007, Dmitry Kakurin wrote:
> >
> > When I first looked at Git source code two things struck me as odd:
> > 1. Pure C as opposed to C++. No idea why. Please don't talk about portability,
> > it's BS.
>
> *YOU* are full of bullshit.

nice

> C++ is a horrible language. It's made more horrible by the fact that a lot
> of substandard programmers use it, to the point where it's much much
> easier to generate total and utter crap with it. Quite frankly, even if
> the choice of C were to do *nothing* but keep the C++ programmers out,
> that in itself would be a huge reason to use C.
>
> In other words: the choice of C is the only sane choice. I know Miles
> Bader jokingly said "to piss you off", but it's actually true. I've come
> to the conclusion that any programmer that would prefer the project to be
> in C++ over C is likely a programmer that I really *would* prefer to piss
> off, so that he doesn't come and screw up any project I'm involved with.

As dinosaurs (who code exclusively in C) are becoming extinct, you
will soon find yourself alone with attitude like this.

Measuring number of people who contributed to Git is incorrect metric.
Obviously C++ developers can contribute C code. But assuming that they
prefer it that way is wrong.

I was coding in Assembly when there was no C.
Then in C before C++ was created.
Now days it's C++ and C#, and I have never looked back.
Bad developers will write bad code in any language. But penalizing
good developers for this illusive reason of repealing bad contributors
is nonsense.

Anyway I don't mean to start a religious C vs. C++ war. It's a matter
of beliefs and as such pointless.
I just wanted to get a sense of how many people share this "Git should
be in pure C" doctrine.
-- 
- Dmitry
