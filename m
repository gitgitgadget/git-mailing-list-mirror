From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2010, #02; Wed, 16)
Date: Thu, 17 Jun 2010 18:16:43 +0000
Message-ID: <AANLkTik2dXByyRLnGojWLY9pl3oZ0ZJH_reONi7AuSAb@mail.gmail.com>
References: <7viq5ict4p.fsf@alter.siamese.dyndns.org>
	<7vocf939vu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Andrew Sayers <andrew-git@pileofstuff.org>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	Brian Downing <bdowning@lavos.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?UTF-8?Q?Cl=C3=A9ment_Poulain?= <clement.poulain@ensimag.imag.fr>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Ian Ward Comfort <icomfort@stanford.edu>,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johan Herland <johan@herland.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Philippe Bruhat <book@cpan.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Simo Melenius <simo.melenius@iki.fi>,
	Stephen Boyd <bebarino@gmail.com>,
	Thomas Rast <trast@student.e
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 17 20:16:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPJe0-0002s8-W1
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 20:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760620Ab0FQSQq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jun 2010 14:16:46 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42205 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756976Ab0FQSQp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jun 2010 14:16:45 -0400
Received: by iwn9 with SMTP id 9so132247iwn.19
        for <git@vger.kernel.org>; Thu, 17 Jun 2010 11:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CSfOIQxpliRFoEl6KGHOxq7It1CSpiZS/l55PA9aYUo=;
        b=GPGQCiS/0ydcJl1c+I4UU9+BqSyx+2C6Wc4ERmuhWcs+NeVEnLbNThi8rkHLQIO82c
         2UrxaEbf1BH/TDRPBgpoM32YHRQRCmOdkQf81KNNFSMMBeuUshELjtucCsusfwcB9a+H
         /OPvKsKT1yz6zxwZq4H+ydgD+x20HxAgnz1nw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TRYBi7Qg0Pjxxx3L6mR/m95AolqBTNHDv0POXldqgAHdhtjxphPdYcG9IpG7921bVV
         6872c1QV15kdbUx7l+yTTsu5T1sCbvqnMvFD1WOj47Qvtv7zdM38BUM8eBolqNGsMsoZ
         00BxmPvWDkqkj8XM1V1dYL5IBO02oy1pAie3s=
Received: by 10.231.169.131 with SMTP id z3mr11819453iby.48.1276798603446; 
	Thu, 17 Jun 2010 11:16:43 -0700 (PDT)
Received: by 10.231.155.144 with HTTP; Thu, 17 Jun 2010 11:16:43 -0700 (PDT)
In-Reply-To: <7vocf939vu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149321>

2010/6/17 Junio C Hamano <gitster@pobox.com>:

>> * ab/i18n (2010-06-15) 3 commits
>> =C2=A0. Add initial C, Shell and Perl gettext translations
>> =C2=A0. fixup! Add infrastructure
>> =C2=A0. Add infrastructure for translating Git with gettext
>
> I haven't got around to fix conflicts merging this with various other
> topics yet.

If you need some help with that I could produce a series which merged
those commits with various topics. What should they be merged against?

>> * ab/tap (2010-06-09) 4 commits
>> =C2=A0- We use TAP so the Perl test can run without scaffolding
>> =C2=A0- Skip tests in a way that makes sense under TAP
>> =C2=A0- Merge branch 'jc/t9129-any-utf8' into ab/tap
>> =C2=A0- Make test-lib.sh emit valid TAP format
>> =C2=A0(this branch uses jc/t9129-any-utf8.)
>
> I was not sure why TAP is worth the trouble, and I still am not sure.

One way of looking at it is this: If we were writing the test-lib
today, why would we pick this form:

    *   ok 1: sigchain works

Over this:

    ok 1 - sigchain works

When the latter automatically gives us interoperability with a huge
library of existing tools at no cost, and the former gains us nothing.

That's all the TAP series does, change test output so that it conforms
to a standard format, instead of our own ad-hoc format.

It gains us a lot in machine readable test output, and costs us
nothing. Actually less than nothing because some ad-hoc code in the
test-lib is replaced by test-lib<->Perl interop via TAP.

That interop will come in handy down the line with more Perl tests
(e.g. from the gettext series), and more so when things like Gitweb
(hopefully) get tests of their own now that they're being modularized.
