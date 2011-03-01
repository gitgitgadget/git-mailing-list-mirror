From: Alexei Sholik <alcosholik@gmail.com>
Subject: Re: Consistent terminology: cached/staged/index
Date: Tue, 1 Mar 2011 11:32:00 +0200
Message-ID: <AANLkTi=sXLcVJRVH87jXvVwCth+8vGgc7Ha0=XEG0Kx4@mail.gmail.com>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
	<20110213193738.GA26868@elie>
	<7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
	<AANLkTim4UKxYwRagCk3R20e7wsRb7CxvS_ze9b8MfWjL@mail.gmail.com>
	<20110214231920.GA24814@elie>
	<AANLkTik-jc0ZX9S4bCYV8VBgPXJZsX0U08W2H+jufO8r@mail.gmail.com>
	<20110227084317.GB3356@sigill.intra.peff.net>
	<1298820840.19827.69.camel@drew-northup.unet.maine.edu>
	<20110228230311.GA7533@sigill.intra.peff.net>
	<AANLkTi=LPqu9zDiAJpxqC=ZCLig+aCv5ztXw668ERtH7@mail.gmail.com>
	<vpqaahf9p69.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David <bouncingcats@gmail.com>, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Mar 01 10:32:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuLwC-0001Eu-6N
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 10:32:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756011Ab1CAJcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 04:32:04 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:33923 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754721Ab1CAJcB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 04:32:01 -0500
Received: by wwe15 with SMTP id 15so4183753wwe.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2011 01:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Gb3p8TVlSzXxYGwp7AYgEP7g9gUBVoe5vxb0U02kz/E=;
        b=iUd00alEO9WL/NdjMZd7Vy1A5fpnPRXLgbgRp70Q1cDutISOUwQkUs6yGwvE9KaMur
         uRb7kmUzhUqAa30kYtqohuwQK8j6BUhtF470TssAUiLFdpAapb3eaTnyFA8CUYhhW8Dr
         R+3j66P/gumDPmY/AFY+DEaCXbytiti3F80p8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Rj8SkrMtCmtZplMJym1Bf0qIBvkg2GE3HIf4OCjpTq7yiKWsuLA72VfsFcI20CXU0i
         5nb2uJ0maDRIeUMInAXJonGFQOc3SmY3eei29ftPEZ+66Aw9vJn+4RRv1bxbe+g68GMR
         V5dqv+ZE/zX7PwRvra2R7AykyVt9Xi31eKgRA=
Received: by 10.216.160.84 with SMTP id t62mr5520237wek.69.1298971920237; Tue,
 01 Mar 2011 01:32:00 -0800 (PST)
Received: by 10.216.7.9 with HTTP; Tue, 1 Mar 2011 01:32:00 -0800 (PST)
In-Reply-To: <vpqaahf9p69.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168201>

On 1 March 2011 11:15, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> David <bouncingcats@gmail.com> writes:
>
>> A suggestion: could your conceptual bucket be named as "the
>> precommit".
>
> ...
>
> As a non-native speaker, I didn't know what "staging area" really meant
> in english, but the "area" part of the expression immediately made sense
> to me. Had it been called the "foobar-ing area", I would have found it
> more intuitive than cache or index ;-).

Hello everyone,
I'm not a very experienced git-user and I still remember how it felt
when I started learning git. I don't recall the exact tutorial I used
(probably it was the 'Pro Git' Book), but anyway, it used the term
"staging area" and "to stage changes" from the outset. I'm also not a
native English speaker and I hadn't even heard of the term "to stage"
before, but managed to grasp at once what "to stage changes" meant.

As of such names as "bucket" and "precommit", I don't think they will
do. There is a lot of resources for beginners on the internet already,
many of them already use "staging area" and "index". There's no need
to rename the staging area. The only source of confusion as I see it
comes from the interchangeable usage of the terms "staging area" and
"index" ("staged" and "cached" being the other confusing pair of
words).

I guess, people who are friendly with git using the word "index"
because it's easier to type. But it confuses an unprepared reader. The
solution of the problem with confusion must be relevant to these
points:
 - clarify that "index" means the same thing as the "staging area" (in
man if it isn't there already?)
 - replace "cached" with "staged" for consistency with the term
"staging area" (I guess none of you would like to replace ot with
"indexed" instead :-P)

Best regards,
Alexei Sholik
