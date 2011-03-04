From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Consistent terminology: cached/staged/index
Date: Fri, 4 Mar 2011 19:18:51 +0200
Message-ID: <AANLkTinAUsY-d3Ec6HpKbjzC+eUjGcq1LK5ODjxRC-yz@mail.gmail.com>
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
	<op.vrnq8gk856e9f9@xman.eng.oslo.osa>
	<1298997963.5247.30.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexey Feldgendler <alexeyf@opera.com>, git@vger.kernel.org,
	David <bouncingcats@gmail.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>,
	Miles Bader <miles@gnu.org>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Fri Mar 04 18:19:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvYeb-0002a9-DW
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 18:19:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759948Ab1CDRSz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Mar 2011 12:18:55 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48113 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723Ab1CDRSy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Mar 2011 12:18:54 -0500
Received: by bwz15 with SMTP id 15so2235984bwz.19
        for <git@vger.kernel.org>; Fri, 04 Mar 2011 09:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DcVNq99sV+MnQWCRyAB0NOjR/gkdxwikaqxoV70CoIM=;
        b=j+KKLmfw+eWD1sta6OR3gYRHfVk2saqUShiH8S8h4R01IavKkBpxpiN4bgS3/1r6lU
         K2vMHeeCbRrKMsYIDOW17L2zbtDvqKzR8FfzAm6uO/ZJTs5Od4AQEQTaT9VunCOo8qJc
         GE0rPYZ6ki+Sb6GZnoQ1rdUmGHJ61wgNzMG7E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pJmSAiogWkrPEWKZC75u8fkE8KsT+tiXBQHNcwuJcQ/wWoJmeUOQdlsm3AGI4mNaVe
         cxu0cmk+jNKWUUqYIhb2XFlKT0oCLwPj6myAh2p9+U0LBfZZ5Sotne+ukjPL9KLTDgbe
         P/jNwO6Xmyn38/t/BXUA79A52TqLma+tuVSiQ=
Received: by 10.204.1.136 with SMTP id 8mr799005bkf.107.1299259132862; Fri, 04
 Mar 2011 09:18:52 -0800 (PST)
Received: by 10.204.67.141 with HTTP; Fri, 4 Mar 2011 09:18:51 -0800 (PST)
In-Reply-To: <1298997963.5247.30.camel@drew-northup.unet.maine.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168449>

On Tue, Mar 1, 2011 at 6:46 PM, Drew Northup <drew.northup@maine.edu> w=
rote:
>
> On Tue, 2011-03-01 at 10:27 +0100, Alexey Feldgendler wrote:
>> On Tue, 01 Mar 2011 10:11:11 +0100, David <bouncingcats@gmail.com> w=
rote:
>>
>> > A suggestion: could your conceptual bucket be named as "the precom=
mit".
>> >
>> > Motives for this suggestion are:
>> > 1) =C2=A0I imagine this word will be readily translatable;
>>
>> Less so than =E2=80=9Cstaging area=E2=80=9D, at least into Russian.
>>
>> Just my two cents.
>
> I was starting to think about "commit preparation area" this morning,
> but it sounds horribly long. Would "Prep area" work provided that the
> longer version has already been introduced into the discussion? This
> provides a similar language metaphor to "staging area" hopefully with=
out
> the translation problem.
>
> Also, I still think that it is important to note somewhere that the w=
ay
> that git handles commits is not the way that most users are likely to
> imagine (the Index doesn't contain the blob objects itself; a finaliz=
ed
> commit is not just a bundled collection of everything as somebody mig=
ht
> expect; etc) so this "Prep area" is a logical space not completely
> analogous to stuff found in the ".git" directory. Pretending that
> complexity does not exist will not help; letting the users know that
> they don't need to grok all of the details to get started is, on the
> other hand, quite important.

=46irst I liked this proposal, but then I thought about 'git diff
--preped' (doesn't really sound right). I think the term should:

 1) Have a nice noun version; staging area, preparation area
 2) Have a nice verb version; to stage, to prep
 3) Have a nice past-participle; staged, cached

Casting? Forging? I don't know, staging always seems right.

Cheers.

--=20
=46elipe Contreras
