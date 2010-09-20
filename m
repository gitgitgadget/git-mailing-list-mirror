From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/3] tests: Prepare --textconv tests for correctly-failing conversion program
Date: Mon, 20 Sep 2010 23:03:35 +0200
Message-ID: <vpq1v8o9lg8.fsf@bauges.imag.fr>
References: <7ab60e32582447ad792602ff405dcee464ef1414.1284830388.git.kirr@landau.phys.spbu.ru>
	<vpqmxrevppb.fsf@bauges.imag.fr>
	<cover.1284830388.git.kirr@landau.phys.spbu.ru>
	<cover.1284830388.git.kirr@landau.phys.spbu.ru>
	<000c991c7a0673e26ee3ecc19ea3c8a7b437fecf.1284830388.git.kirr@landau.phys.spbu.ru>
	<vpq8w2yvonu.fsf@bauges.imag.fr>
	<cover.1284830388.git.kirr@landau.phys.spbu.ru>
	<cover.1284830388.git.kirr@landau.phys.spbu.ru>
	<26d0544dac2515e76bee0608881cfd8c23bf1ebf.1284830388.git.kirr@landau.phys.spbu.ru>
	<vpqiq22vp72.fsf@bauges.imag.fr>
	<20100920203501.GB23533@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Mon Sep 20 23:08:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxnan-00081X-Vd
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 23:08:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199Ab0ITVIC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 17:08:02 -0400
Received: from imag.imag.fr ([129.88.30.1]:63234 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932179Ab0ITVIA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 17:08:00 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o8KL3ZX7016698
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 20 Sep 2010 23:03:35 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OxnWR-0008Kf-RA; Mon, 20 Sep 2010 23:03:35 +0200
In-Reply-To: <20100920203501.GB23533@landau.phys.spbu.ru> (Kirill Smelkov's message of "Tue\, 21 Sep 2010 00\:35\:01 +0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 20 Sep 2010 23:03:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156669>

Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:

> Matthieu, Jeff, Junio, thanks for your review and input.
>
> Comments below inline...

You've replied to several messages in one. That's OK here since the
content of your message is essentially uncontroversial, but I'd
suggest keeping separate threads for separate patches for next time.
(for example, my reply below looks strange since I'm commenting on
PATCH 2/3 in a message titled PATCH 1/3 ...). No big deal.

>> > Subject: Re: [PATCH 2/3] blame,cat-file: Demonstrate --textconv is wrongly running converter on symlinks
>>
>> We try to keep the subject lines short (<80 chars, and as much as
>> possible less so that "git log --oneline" be pretty).
>>
>> How about
>>
>> blame,cat-file: add failing tests for --textconv on symlinks
>
> I'd like to shorten it, but "add failing tests" is not as descriptive as
> "Demonstrate --textconv misbehaves in such-and-such way",

Right, but your "such-and-such way" is not really precise either. One
cannot know whether it's running, but the wrong way, whether it's
running and should not, etc. The subject line is here to be a summary,
you don't need details. And I actually find "add failing tests" more
precise than "demonstrate that ... is behaving wrongly".

> and I can't come up with a shorter subject without making it more
> cryptic. And btw, I've looked at log --oneline output, and
> (surprise, surprise)
>
> 479a56 4fccc04 etc ...

I don't understand what you mean. After applying your patches, I get:

6998f9a RFC: blame,cat-file --textconv: Don't assume mode is ``S_IFREF | 0664''
025aaac blame,cat-file: Demonstrate --textconv is wrongly running converter on symlinks
3646401 tests: Prepare --textconv tests for correctly-failing conversion program

which do not fit on a 80-columns terminal.

> So if that's not a major obstacle, I'd leave it as is.

I don't consider it "major" (but other may have different opinions)
though.

>> These days, it's recommanded to put this kind of code within the
>> test_expect_success/test_expect_failure.
>
> I see, thanks.
>
> I've moved other >expected preparation inside test_expect_*, but this
> expect is special in that it is used in subsequent two tests. So I'd
> leave this one outside.
>
> And btw, I've originally copied in-style what was already there in t8006
> and t8007 which date to Jun 2010.

Yes, the guideline is new, and not widely applied (yet).

> Ah, yes, thanks. I forgot ':/text' means `commit which log is text' -

A patch to update the comment above follows.

> Thanks again to everyone.

That "everyone" includes you ;-). Thanks for the patch, good job both
for testing and for the actual fix!

--
Matthieu Moy
http://www-verimag.imag.fr/~moy/
