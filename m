From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [Resend PATCH] t3903 (stash): add failing test for ref of form ^{/message}
Date: Wed, 17 Apr 2013 01:23:38 +0530
Message-ID: <CALkWK0mdNWxTVf9rhRO7Z8qnGT9J4R3UicGUNKdBkZuOctoBRQ@mail.gmail.com>
References: <1366135765-18437-1-git-send-email-artagnon@gmail.com>
 <CA+sFfMfkoBcoPvJSYBGUe46EbMfiC7q6tVZs6db2NHrEb2gb7Q@mail.gmail.com> <7veheal28i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Brandon Casey <drafnel@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 21:54:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USBxQ-00021J-SG
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 21:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935844Ab3DPTyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 15:54:21 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:45419 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935589Ab3DPTyU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 15:54:20 -0400
Received: by mail-ie0-f170.google.com with SMTP id c11so1044365ieb.1
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 12:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Q4VdOZCnd78V8zWhohqmhyB5NK9L5IZuYoUwya3z8NI=;
        b=ItMb83YivZx3yw7x3Q3cSOsVlLrT+06s6PCQeMtIhBv1ghc7H2mY9m5kx7YCAFpjag
         HoAlBmk/bs68aouYSVTAeK3I8PVTG3b4d6yT/mybNm0CrHUawEBR3I9dhVweflNTcIYP
         ee5AMWhl7UpkyNmafxkAky85MjTvq5MCuVzGM1j4xYAd0Mn0dxfYa1Lp90RMIZJ6petr
         ZVFEaet9u/4oTwbdz6GWsr+vUi/zeeUFLoKHDQpyK94LVQcEg1NRmiPSzbKQ42o9LtLZ
         Dg3AJmfkDmtYGNxpY+t73PVLt/sJQPowQcO0SSgNvWNEhwKT4+jDxdCYY67f9uXvu0mu
         1g/g==
X-Received: by 10.50.119.102 with SMTP id kt6mr2370193igb.12.1366142059999;
 Tue, 16 Apr 2013 12:54:19 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Tue, 16 Apr 2013 12:53:38 -0700 (PDT)
In-Reply-To: <7veheal28i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221462>

Junio C Hamano wrote:
> Brandon Casey writes:
>> Just a bit of advice, maybe you should think about softening your tone
>> a bit hmm?  I find this last sentence to be somewhat repelling and
>> tend to refrain from responding to such.
>
> Oh, so it wasn't just me.  I was about to say something similar,
> along the lines of "people whom you just called myopic, because you
> did not understand the rationale behind their past work, are less
> likely to be inclined to help you. you would have more luck if you
> ask them nicely.", but I've long given up on helping him be a better
> community member and deleted that part.

I'm truly sorry.

I've only had a cursory look at git-stash.sh, and was merely saying
what came to my mind first after a cursory glance: it wasn't an
opinion of any sort.  A lot of things I say are stupid in retrospect:
I'm not ashamed to admit it; I'm an inexperienced kid, and I make lots
of mistakes.  And please don't interpret my comments as attacking the
people who wrote the code: in a community like ours, I don't believe
in associating blame to any one person; I believe that all of us are
equally responsible for all parts of the code as a collective; if
something doesn't match what I expect, why didn't I participate in the
discussion of the patch that led up to it?

I complain very loudly about little things that annoy me, and I think
this is a good attribute.  People who are generally happy with the
current state of affairs cannot make a big difference.  This does not
mean that I go on a stubborn rampage breaking backward compatibility
everywhere, but rather that I raise the kind of questions that other
people normally don't.

I do not blame people for who they are: they are just a product of
their histories; a sum of absorbed influences.  It is, therefore,
irrational to be rude to someone.  If someone is not behaving as I
expect them to, I send them a polite off-list email pointing out what
I think their negative attributes  are, and attempt to nudge them in
the desired direction.

I'll try to be a better community member in the future.
