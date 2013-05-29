From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What's cooking in git.git (May 2013, #08; Tue, 28)
Date: Wed, 29 May 2013 23:45:32 +0530
Message-ID: <CALkWK0kwdm+CP=_EsWgEsBPACnMWpy9-hV5wjdWDXYggCntFpA@mail.gmail.com>
References: <7vli6yydmv.fsf@alter.siamese.dyndns.org> <CALkWK0m+t9DPrUbGBnaJ7jTqTVHohGgiiR-bjcTTRNmbT-Oq8A@mail.gmail.com>
 <7vvc61u1cc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 29 20:16:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhkvF-00057a-Lh
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 20:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965416Ab3E2SQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 14:16:16 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:49334 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965312Ab3E2SQN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 14:16:13 -0400
Received: by mail-ie0-f179.google.com with SMTP id c13so25090921ieb.24
        for <git@vger.kernel.org>; Wed, 29 May 2013 11:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=UDOPqsrSrvz8GMGCiJIDZRrsqESg31cxYUtbmju4gl0=;
        b=zkDk4/D+ryV6ronLhqpkHhHqK33Sgs6JUTXgwiWWfdaId+vrrX7c7iXAyCTg1+cvLD
         gmC6yRy4QVsBvH57UDHyK3qNWZrCefZl8slP14+WbOKiJTYFxcQweNbEGHpGp4vY5kIZ
         rp1O1+hod51279swYQJ6mrK9s3C5VdTjWSXchqb8Ivw4Otj7HUN3r75bIn1rUAHRcCkO
         4yElecm95uuNFER2GDg+oi8M0WXnMDKku+GR1jnX1hg6d3ORyRazuiv6X3UyJJxm0J7O
         8nVndiJ775ACNRlyuCwyzDlhQ0dA2CYxreApdeF9aeT7aXc2ddh1S4pS3B2mwrJgHVtS
         VGTw==
X-Received: by 10.50.41.99 with SMTP id e3mr9937102igl.104.1369851372774; Wed,
 29 May 2013 11:16:12 -0700 (PDT)
Received: by 10.64.226.135 with HTTP; Wed, 29 May 2013 11:15:32 -0700 (PDT)
In-Reply-To: <7vvc61u1cc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225859>

Junio C Hamano wrote:
>> Is there something you're not happy with?
>
> By the way, you probably should stop thinking in terms of "me" being
> (un)happy.  I am just trying to help by preventing (collectively) us
> making silly mistakes.

As a general principle, okay.

IIRC, nobody else had comments on this one.

>> * publish-rev: the @{push} thing is still in the early poc stages.
>
> I presume this is the one that may someday lay foundations for Tytso's
> "do not rebase beyond this point, as I have published it already"?

Yep.  More importantly, I'll get something I've been wanting badly:
the tracking info in the prompt.

>> * for-each-ref-pretty: not ready; working with Duy.
>
> I haven't been paying too much attention to it, but my impression
> was a "superset" syntax is coming?  That would be going in the right
> direction.

Yes, a superset with coming with one caveat: %ae will be interpreted
as hex.  I hope to send a large'ish series that also strips out the
-v, -vv code.  Duy basically did most of the work by coming up with a
brilliant way to inject into the pretty-formats machinery.

>> * pickaxe-doc: you had some more comments in latest iteration, but the
>> returns from a re-roll are diminishing.  Frankly, the work is too
>> boring: the first few iterations were interesting, because I was
>> learning;...
>
> Yeah, some parts of the project is boring and that is not a news.
> Think of documentation updates as helping others to learn.

See, the problem is that I might drop the ball on patches like this
(I've done it before, when I thought the change wasn't important
enough for me to bore myself).  This is definitely important, and I
will see it to completion.  But I'm echoing a more general problem:

If people don't feel like working on it, how will the documentation
improve?  And if the pickaxe-doc was in such bad shape, how could
anyone have been using it?  Do an internet search and see for
yourself.  This feature is _extremely_ useful, and it's a real shame
that it has been so poorly documented for this long.

I'm not advocating a lax review that checks in technically incorrect
documentation; that will confuse users and turn it into a huge
maintenance burden.  But we can maybe go down a notch on style?
