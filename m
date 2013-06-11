From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Tue, 11 Jun 2013 14:15:12 -0500
Message-ID: <CAMP44s3QUjs_uOEF++NfSQbNSHae8y1Nxt48CWtHi8YdEiq_zA@mail.gmail.com>
References: <1370712574-27688-1-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0mA7MXQv1k5bFpZLARDOHxU5kzKFXzcyUfb6NLZZY-=FA@mail.gmail.com>
	<CAMP44s0cozMsTo7KQAjnqkqmvMwMw9D3SZrVxg48MOXkH9UQJQ@mail.gmail.com>
	<CALkWK0=7PRndNc7XQ-PCPbVCp9vck909bA561JhQG6uXXj1n4g@mail.gmail.com>
	<20130609151235.GA22905@serenity.lan>
	<CAMP44s0L9nQxp5OeK8uT4Ls5WUerCjVpR9uONUcOwvTD6k7Jfg@mail.gmail.com>
	<51B4BBB7.8060807@lyx.org>
	<20130610214504.GG13333@sigill.intra.peff.net>
	<CAMP44s2-94LTu54oX1_m14tnE3KfwK+N=pPxgUSqGCgd51EA5A@mail.gmail.com>
	<20130610220627.GB28345@sigill.intra.peff.net>
	<7vk3m1efda.fsf@alter.siamese.dyndns.org>
	<7v8v2hedou.fsf@alter.siamese.dyndns.org>
	<CAMP44s1HM0zFvkGmaHrX2Wq2JSzDNk8uwNSz3bNo12eWxDcL8A@mail.gmail.com>
	<7v4nd5ecmy.fsf@alter.siamese.dyndns.org>
	<7vwqq1ct0g.fsf@alter.siamese.dyndns.org>
	<CAMP44s0r96ByEs3+N1Qo+O18rOmT72rHk4zAEFAyFdU_DsQ8wA@mail.gmail.com>
	<7vtxl4blht.fsf@alter.siamese.dyndns.org>
	<CAMP44s02PqGFNmrGEcJVT6xcQHx8k4NYqJ_TtOTUEY8XHPj0BA@mail.gmail.com>
	<7vppvsbkc3.fsf@alter.siamese.dyndns.org>
	<CAMP44s02KaMaMUz4618n5RqVqVSXzr_D9rPS1uesy2XEdqnq5A@mail.gmail.com>
	<CA+55aFwYAFuz5p0=8QiAFDy4e66f1pF3v=D5nnL6+3um7Z3L2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	John Keeping <john@keeping.me.uk>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 11 21:15:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmU2M-00008i-R0
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 21:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754631Ab3FKTPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 15:15:17 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:64216 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991Ab3FKTPP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 15:15:15 -0400
Received: by mail-lb0-f174.google.com with SMTP id x10so5810880lbi.19
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 12:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Y785j9N5JabPQkb/Ly88sSZYXRXRB4I5lADw9ifz4j8=;
        b=PyVTYRg5IEdvg+osw4JAWM3FB87MU4HeEPjNhRWbVqjkg8D0pN1deCHHNU8XYfd4D2
         7766AeXYpIsTNAVeBfiE0CnKAEZx2SbNPCrpcBmNMkJeys6a1kC+RCpT7jpz18cHBTlj
         ydiPmpUaJ00icrNPXMylaWo3vg8vyFAumT84C/9uMXLbOvzanC0Fi1GM7UVLckuSpn1i
         lINIQCzO+oE5vgHf6TRBk+yfv/0GUuQGdU6zmgcQQwlIAfxX3hF9VZEen+mu0n9V+mhg
         pz9/Tk2gD5ivZ6NLPgPT7RkAjAMpqV+4RW4qXSN93/8ejghOEWcewYodW9WNZI+Jw+UE
         zNJQ==
X-Received: by 10.112.219.133 with SMTP id po5mr9221376lbc.80.1370978113028;
 Tue, 11 Jun 2013 12:15:13 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Tue, 11 Jun 2013 12:15:12 -0700 (PDT)
In-Reply-To: <CA+55aFwYAFuz5p0=8QiAFDy4e66f1pF3v=D5nnL6+3um7Z3L2g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227500>

On Tue, Jun 11, 2013 at 1:14 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Jun 11, 2013 at 11:06 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>>
>> Moreover, if you are going to argue that we shouldn't be closing the
>> door [...]
>
> Felipe, you saying "if you are going to argue ..." to anybody else is
> kind of ironic.

Supposing the other side's argument is correct is a standard
discussing technique.

> Why is it every thread I see you in, you're being a dick and arguing
> for some theoretical thing that nobody else cares about?

I don't know. I've sent 800 patches in the last three months (patches,
not email comments), and you pick this one to reply to. Maybe because
you enjoy insulting people?

> This whole thread has been one long argument about totally pointless
> things that wouldn't improve anything one way or the other. It's
> bikeshedding of the worst kind. Just let it go.

Why don't you ask Junio to let it go? If it's irrelevant, than it
doesn't matter if this patch is applied or not. You say it's
bike-shedding, that implies that Junio likes red, and I like blue, and
both are equally useless. So let's go for blue then.

Presumably Junio doesn't agree with you, he does truly think it should
be red, in fact, he doesn't think it's just a color, it's something
important, and I agree, and apparently other people in the mailing
list also agree, as most of them have voiced their opinion that red is
the color.

Now, do you have something of value to say which of the two options
should be, or are you just going to engage in double standards and
personal attacks?

If you truly think this is bikeshedding, at least be fair and complain
about that to the people that argue for red, not just the ones that
argue for blue.

-- 
Felipe Contreras
