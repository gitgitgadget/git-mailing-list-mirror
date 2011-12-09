From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/5] revert: make commit subjects in insn sheet optional
Date: Fri, 9 Dec 2011 13:50:42 -0600
Message-ID: <20111209195042.GG20913@elie.hsd1.il.comcast.net>
References: <1323239877-24101-1-git-send-email-artagnon@gmail.com>
 <1323239877-24101-3-git-send-email-artagnon@gmail.com>
 <20111207070223.GC11737@elie.hsd1.il.comcast.net>
 <CALkWK0nkPB5WptJ9nSkSOif5_0R_f39Dg_HR3Rmg02hG_4Q1Tg@mail.gmail.com>
 <20111209193527.GD20913@elie.hsd1.il.comcast.net>
 <CALkWK0ki1r5AqYb8qyGHUNupTAhCa2TKwVgkrCpLr+zo_pCy9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 20:50:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ6T5-0005BP-5q
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 20:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754626Ab1LITur convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Dec 2011 14:50:47 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47184 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753267Ab1LITuq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Dec 2011 14:50:46 -0500
Received: by yenm11 with SMTP id m11so2374392yen.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 11:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QiEaiyIrTSxL4uzJ3g8D9iT3EO/WmhVbfGQ4T5y+rC8=;
        b=j/kFgwuf7OzKUOFBj0lTqfpPluNpfE6yMpW9zoDHRumdF04JoPWOxLmQbWwTXYvWSz
         xrNc1aIICfTVk9BoWzj7MBadCpkBwsDPC19v2jjdMfZRdC2CHmg9/nXKJg7imjtaYt8t
         Q074WY9tnoYRJhdD8cVXY7IrwAFZdlWx86Ih0=
Received: by 10.236.22.136 with SMTP id t8mr14510631yht.30.1323460246008;
        Fri, 09 Dec 2011 11:50:46 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id o9sm4747593yhk.20.2011.12.09.11.50.45
        (version=SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 11:50:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0ki1r5AqYb8qyGHUNupTAhCa2TKwVgkrCpLr+zo_pCy9g@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186675>

Ramkumar Ramachandra wrote:
> Jonathan Nieder wrote:

>> Not sure what you're talking about. =C2=A0I was saying that any comm=
it that
>> goes from "git can segfault in such-and-such circumstance" to "git n=
o
>> longer segfaults in that circumstance" should loudly proclaim so!
>
> That's what I'm confused about: how can I make git misbehave (let
> alone segfault) after applying this commit?

You can make git misbehave before applying the commit.  Applying the
patch fixes it.  Unfortunately the patch description does not actually
say so, and at least my small mind is not able to read between the
lines in a hurry to deduce it.

Sorry for the lack of clarity,
Jonathan
