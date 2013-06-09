From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sun, 9 Jun 2013 07:15:45 -0500
Message-ID: <CAMP44s3NhNUuCvW37UaMo9KbHHxZqBE8S15h845vtRi89Bu6WA@mail.gmail.com>
References: <1370643409-3431-3-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8AMMCWSFC6EUHAgZdDA7E1kSPE3ZO6qGvS+WGji-di=Rw@mail.gmail.com>
	<CAMP44s29GiGJq3wyXAzJNo0FJY+Vbgd18bpBJMYQ47h-3M6sWA@mail.gmail.com>
	<CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
	<20130608164902.GA3109@elie.Belkin>
	<CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
	<20130608173447.GA4381@elie.Belkin>
	<CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com>
	<20130609014049.GA10375@google.com>
	<CAMP44s3CGHVLnkUxo=PR_b+_dTuaz5rwems_pd9GE1_vcEaYRA@mail.gmail.com>
	<20130609052624.GB561@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 09 14:15:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UleXI-0006BF-7M
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 14:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753823Ab3FIMPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 08:15:48 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:40530 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753710Ab3FIMPr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 08:15:47 -0400
Received: by mail-lb0-f175.google.com with SMTP id r10so1308082lbi.6
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 05:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wn6d/TX0qj9rhGPbJHs/AswovhLJoFPr7JxBHLGKWnY=;
        b=T4LXAFCB3K4L3GF3K0cM1B9MVozGCqSB3HXR2OgLsOX4esnJ/dtkyctO9sTVYbAcGx
         fOEuS2P9kY3SUyMj/Dr7Z0trDFsw1LeDYozx4V6u3+NMxeVwVKfMTQuNMwEIyLiTeNRX
         eqFeYyLNcWipVHtkcJSz/d8wTpEABsKOKBWiNay7ebooBeo3nDOiKYAL96xr79C6NrJC
         mwY5gOUmK/8uOhwOxKDDbZksHaeFC9BZkT4u3ls0LNLmL0u9micnEuiwsxzSWJxGn2ib
         P3455ii0zoRugsS17ENrCVgfao/734shEgOF5iJDqD0usfuNhDebje9qv8eSSYKYnjW7
         chPQ==
X-Received: by 10.152.27.170 with SMTP id u10mr2901999lag.45.1370780145669;
 Sun, 09 Jun 2013 05:15:45 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 05:15:45 -0700 (PDT)
In-Reply-To: <20130609052624.GB561@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226956>

On Sun, Jun 9, 2013 at 12:26 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Jun 08, 2013 at 09:17:56PM -0500, Felipe Contreras wrote:
>
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
> Sorry, but I don't agree, and I want to publicly state my opinion so
> that Jonathan (and other bystanders on the list) knows that he is not
> alone in his opinions.

You don't agree that 1) a collegial work environment is overrated, 2)
that the Linux kernel doesn't put an emphasis on being collegial, or
3) that it's the most successful software project in history?

> I have consistently found your demeanor on the list to be very
> unfriendly and difficult to work with. It is one thing to have honest
> and straight talk, and another thing to be obstinate, unmindful of
> feedback (both with respect to technical details, as well as to
> communication styles), and disrespectful of other people.

Go back to my 261 commits, show me one that is "unmindful of technical details".

> It is certainly your choice about how you will communicate. But likewise
> it is the choice of readers and reviewers to choose how much of their
> time to give to your writings.

Exactly. Nobody is forcing you to read my emails. But somehow you
already know that ignoring them is not in the best interest of the
project. And by that I mean it's in the best interest of our users,
without which our project is nothing.

-- 
Felipe Contreras
