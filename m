From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: git as an sfc member project
Date: Fri, 22 Oct 2010 18:21:46 -0500
Message-ID: <S3I346LWUOykFBiCrFLgbfYptyYvHyj1Jcdo6EHe-2fWosEUh4Va3g@cipher.nrlssc.navy.mil>
References: <20101022183027.GA12124@sigill.intra.peff.net> <AANLkTi=6tvmTAfdyL-sKBsq+4OpFaQpZWT66ANESNapj@mail.gmail.com> <7vocalkf53.fsf@alter.siamese.dyndns.org> <20101022231820.GB25520@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 23 01:22:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9QwG-00016F-QM
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 01:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754475Ab0JVXWR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Oct 2010 19:22:17 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:36535 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018Ab0JVXWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 19:22:16 -0400
Received: by mail.nrlssc.navy.mil id o9MNLldR002787; Fri, 22 Oct 2010 18:21:47 -0500
In-Reply-To: <20101022231820.GB25520@sigill.intra.peff.net>
X-OriginalArrivalTime: 22 Oct 2010 23:21:47.0210 (UTC) FILETIME=[E5AE42A0:01CB723F]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159763>

On 10/22/2010 06:18 PM, Jeff King wrote:
> On Fri, Oct 22, 2010 at 03:59:36PM -0700, Junio C Hamano wrote:
>=20
>> Shawn Pearce <spearce@spearce.org> writes:
>>
>>> I think a committee of at least 3 people and at most 5, any of whom
>>> can be a benevolent SFC liasion, is fine.  As far as selection goes=
,
>>> the committee can elect or remove a member through a majority vote,
>>> and should base its decisions based on surviving contributions to t=
he
>>> code base, but shouldn't be tied to that (just in case someone
>>> contributes a lot of good code and then becomes a jerk).
>>
>> Just a datapoint from quick "blame -C -C -w" run as of 1.7.3.2, coun=
ting
>> surviving lines, 7 top from each area, excluding Documentation/RelNo=
tes.
>>
>>
>> ** Everything else **
>>
>> 77212        Junio C Hamano
>> 41388        Shawn O. Pearce
>> 32676        Linus Torvalds
>> 28618        Johannes Schindelin
>> 22120        =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> 20190        Paul Mackerras
>> 15518        Marius Storm-Olsen
>=20
> How did you calculate this? I don't see how it could be right. For
> example, =C3=86var's contribution, while being impressively large lat=
ely, is
> only 12877 lines total over all commits, let alone surviving lines:
>=20
>   $ git log --pretty=3Dformat: --numstat --author=3DBjarmason |
>     perl -ne '/^\d+/ and $total +=3D $&; END { print "$total\n"; }'
>   12877

I was just going to craft a reply too.  I think Junio's number are
all doubled.

Here are Junio's numbers for contrib/:

7180         Junio C Hamano
3960         Shawn O. Pearce
3378         Alexandre Julliard
2948         Marius Storm-Olsen
2668         Aneesh Kumar K.V
2624         Simon Hausmann
1254         Matthias Urlichs

and here's what I get for contrib/:

3590         Junio C Hamano
1980         Shawn O. Pearce
1689         Alexandre Julliard
1473         Marius Storm-Olsen
1334         Aneesh Kumar K.V
1312         Simon Hausmann
627          Matthias Urlichs

-Brandon
