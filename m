From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 0/2] Re: user-manual: general improvements
Date: Thu, 21 May 2009 10:17:45 +0300
Message-ID: <94a0d4530905210017x1ce3e32bk3b1fbf9044377763@mail.gmail.com>
References: <1241650416-12224-1-git-send-email-felipe.contreras@gmail.com>
	 <20090507072326.GA13123@vidovic>
	 <7veiv0cvdt.fsf@alter.siamese.dyndns.org>
	 <20090508042814.GA30031@vidovic>
	 <94a0d4530905131430q2250a43ei692265c3f32b5715@mail.gmail.com>
	 <20090514160609.GA12910@vidovic>
	 <7vvdnvtf2n.fsf@alter.siamese.dyndns.org>
	 <20090521041529.GD8091@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 21 09:17:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M72XN-0004sW-AC
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 09:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbZEUHRr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2009 03:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbZEUHRq
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 03:17:46 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:43213 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbZEUHRp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 May 2009 03:17:45 -0400
Received: by fxm2 with SMTP id 2so854486fxm.37
        for <git@vger.kernel.org>; Thu, 21 May 2009 00:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=W56C+4iSuIzZ9xV0pLU5vsOP15CRltI9PafpK8ZoJOQ=;
        b=wCh18bgBp9nqyMQCRlEf7FtkdTc+Ao0RaQRslwdeSDbbBiamgSoR45eL0aE6kRb4HA
         gqU1/WYto/8IVJOQuARynHIcrY7A4fVumrHm+gmg5Tvv1S2jEODLPbeIzgrPtLqE16Q6
         lET6MW0GMc9Bvt1MaN+hQyEo7tlk/1cKSshdg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=h8+GGtJ3FFGkCEk8dX/WjklPZETpjgSH7C2sUa79DhP7sW9RWzgJD7/nSEk0n1F+HD
         cB5D2ekx3FYocLAa+SP9+7guxwOON6ZyMXQ7Z3Ti6G7hvOuP3DSSsXgon2B05GoP7e/u
         E5M4ZsojCjCNI3ZVmPKCJO6U40RwZnb7WXY7s=
Received: by 10.86.83.15 with SMTP id g15mr1065954fgb.64.1242890265674; Thu, 
	21 May 2009 00:17:45 -0700 (PDT)
In-Reply-To: <20090521041529.GD8091@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119658>

On Thu, May 21, 2009 at 7:15 AM, Jeff King <peff@peff.net> wrote:
> On Wed, May 20, 2009 at 06:33:36PM -0700, Junio C Hamano wrote:
>
>> >> http://people.freedesktop.org/~felipec/git/user-manual-general-im=
provements/
>> >
>> > Thank you very much Felipe to take the time to upload the patches =
there.
>> > I already have a copy there and I'll look at it soon.
>>
>> Has anybody looked at this? =C2=A0It's a bit large-ish and touches a=
ll over the
>> place, so I am finding it a bit hard to concentrate on it myself rea=
lly
>> nitpicking, but from the cursory look after formatting the result lo=
oked
>> Ok.
>
> I started to, but the first commit message is lacking something that =
I
> think would make reviewing much simpler: what are the general classes=
 of
> changes that are being made?
>
> I see some doublequotes becoming backticks, and some becoming single
> quotes. And some becoming tex-quotes (``...''), and even some becomin=
g
> doublequotes _with_ single quotes. It would be easier to verify that
> they are doing the right thing if the commit message briefly describe=
d
> the rules it followed for changing each one. I think they are somethi=
ng
> like:
>
> =C2=A0- tex-quotes if it was really a prose-style quotation
>
> =C2=A0- backticks (causing monospace) for branch names, commands, etc=
 in
> =C2=A0 =C2=A0prose
>
> but that leaves me confused. Some things which I thought should be in
> monospace backticks are in single-quotes (causing emphasis). Like
> 'master' or 'linux-2.6'. And some things are emphasized and in double
> quotes in the prose, like '"o"' or '"branch A"'. What is the rule to
> decide which text should have visible doublequotes but also be
> emphasized, as opposed to just having double-quotes or just being
> emphasized?
>
> Maybe this was even discussed earlier in the thread (I didn't go back=
 to
> look), but it should definitely be part of the commit message.

The rule I followed is: change it to whatever looks best.

I followed some guidelines such as: make common text monospace, such
as gitk and master. And emphasize whatever needs emphasizing, such as
fb47ddb2db. Examples are both monospace *and* emphasized.

Sometimes the end result still didn't look good so I just used
whatever looked best.

Have you actually looked at the end result?

--=20
=46elipe Contreras
