From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: git as an sfc member project
Date: Sat, 23 Oct 2010 11:52:26 +0000
Message-ID: <AANLkTikxMtdvppLur4kuXffRn0G29NFv6ameTpaeY46G@mail.gmail.com>
References: <20101022183027.GA12124@sigill.intra.peff.net>
	<AANLkTi=6tvmTAfdyL-sKBsq+4OpFaQpZWT66ANESNapj@mail.gmail.com>
	<7vocalkf53.fsf@alter.siamese.dyndns.org>
	<20101022231820.GB25520@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 23 13:52:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9ceH-0007eS-Iw
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 13:52:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756449Ab0JWLw2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Oct 2010 07:52:28 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34555 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756269Ab0JWLw1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Oct 2010 07:52:27 -0400
Received: by fxm16 with SMTP id 16so1439735fxm.19
        for <git@vger.kernel.org>; Sat, 23 Oct 2010 04:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wTYzaTWLIhKYkYWiCRv2Mv+eBakWpjuAGnKP0tQyTp8=;
        b=SMUNDRxi1Yyif0KT2diLo83/vXPFgLqe/wzb/U07omsmN9EkZ3JeF27UqAaqItxoXb
         Cb5BreAM391eG/7dnsCQZLGeyPNVh6gLcgt5NRLnP7VjWb6Me7yFS40m3rxO1XxhRZKt
         ZZ4OKlQ1Fik/ije7w+DZCGMWPoQ4fjTAHIB8s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SO4t3nZLvePAp0LCGYTQqSw1rrpPwWbHDR9IqezGBR+oKkbkJwuRx+O6WUSk1nvhz9
         SLt9e/BgipROQtjNergJNlD4CP+ei3nxfn0qjyrfdGQcQkunnIAvLIfcP74ndRD2kTZO
         ulfArBwy+yYe53/mYxmiD/u1EQ31JAK1Op2E0=
Received: by 10.103.191.17 with SMTP id t17mr5009579mup.54.1287834746296; Sat,
 23 Oct 2010 04:52:26 -0700 (PDT)
Received: by 10.223.115.5 with HTTP; Sat, 23 Oct 2010 04:52:26 -0700 (PDT)
In-Reply-To: <20101022231820.GB25520@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159779>

On Fri, Oct 22, 2010 at 23:18, Jeff King <peff@peff.net> wrote:
> On Fri, Oct 22, 2010 at 03:59:36PM -0700, Junio C Hamano wrote:
>
>> Shawn Pearce <spearce@spearce.org> writes:
>>
>> > I think a committee of at least 3 people and at most 5, any of who=
m
>> > can be a benevolent SFC liasion, is fine. =C2=A0As far as selectio=
n goes,
>> > the committee can elect or remove a member through a majority vote=
,
>> > and should base its decisions based on surviving contributions to =
the
>> > code base, but shouldn't be tied to that (just in case someone
>> > contributes a lot of good code and then becomes a jerk).
>>
>> Just a datapoint from quick "blame -C -C -w" run as of 1.7.3.2, coun=
ting
>> surviving lines, 7 top from each area, excluding Documentation/RelNo=
tes.
>>
>>
>> ** Everything else **
>>
>> 77212 =C2=A0 =C2=A0 =C2=A0 =C2=A0Junio C Hamano
>> 41388 =C2=A0 =C2=A0 =C2=A0 =C2=A0Shawn O. Pearce
>> 32676 =C2=A0 =C2=A0 =C2=A0 =C2=A0Linus Torvalds
>> 28618 =C2=A0 =C2=A0 =C2=A0 =C2=A0Johannes Schindelin
>> 22120 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son
>> 20190 =C2=A0 =C2=A0 =C2=A0 =C2=A0Paul Mackerras
>> 15518 =C2=A0 =C2=A0 =C2=A0 =C2=A0Marius Storm-Olsen
>
> How did you calculate this? I don't see how it could be right. For
> example, =C3=86var's contribution, while being impressively large lat=
ely, is
> only 12877 lines total over all commits, let alone surviving lines:
>
> =C2=A0$ git log --pretty=3Dformat: --numstat --author=3DBjarmason |
> =C2=A0 =C2=A0perl -ne '/^\d+/ and $total +=3D $&; END { print "$total=
\n"; }'
> =C2=A012877

Either way it doesn't matter, since I'm not interested in being a SFC
liasion. I just want to hack, not deal with issues like these (but
more power to people who want to).

But I think picking people for anything based on the number of lines
that git-blame thinks people "own" is a bad criteria. My contributions
to Git are relatively small, but I've happened to pick projects (the
test suit, gettext) that have touched a lot of lines of code.

But other people who've done 10x more work than I have (both in time &
importance) probably have 10x less lines of code assigned to them.

If I keep it up I'll probably "own" more lines of code than Linus, but
I think any criteria that brings me within an order of magnitute of
importance of him and Junio is pretty much broken by defintion :)
