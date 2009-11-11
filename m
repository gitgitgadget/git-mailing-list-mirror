From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 0/2] user-manual: new "getting started" section
Date: Thu, 12 Nov 2009 01:15:11 +0200
Message-ID: <94a0d4530911111515q643e263bn3adc6b47cd968d3d@mail.gmail.com>
References: <1256377489-16719-1-git-send-email-felipe.contreras@gmail.com>
	 <7vy6n065os.fsf@alter.siamese.dyndns.org>
	 <7vr5ss64e5.fsf@alter.siamese.dyndns.org>
	 <94a0d4530910241316r3fc4136emd036d18aa45a4192@mail.gmail.com>
	 <7vy6n02mrk.fsf@alter.siamese.dyndns.org>
	 <94a0d4530910250243k4cbc3c18l5e018a05e5afdb2d@mail.gmail.com>
	 <20091025111438.GA11252@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Hannu Koivisto <azure@iki.fi>, Jeff King <peff@peff.net>,
	Wincent Colaiuta <win@wincent.com>,
	Matthias Lederhofer <matled@gmx.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 12 00:15:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8MPJ-0001jf-0n
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 00:15:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759598AbZKKXPI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Nov 2009 18:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759508AbZKKXPI
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 18:15:08 -0500
Received: from mail-iw0-f178.google.com ([209.85.223.178]:52149 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759464AbZKKXPG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Nov 2009 18:15:06 -0500
Received: by iwn8 with SMTP id 8so1342229iwn.33
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 15:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WZ7qj8gKJj35QME1zdzXwddY1u9PmBJ1UZk/VEPrBHs=;
        b=bTzAI0R9uXx6VbTyipCE8Grnm3vpBqeFZf6fyYQZ4vQaO8Xw0ac20qUyQhbx6UGCXF
         dH2vGJ0G3PgXyStYPckg2qLKw9xHLT1emT3ZNaxL0f4qkcJKpd28DGXK4I6EuELdG+I8
         VpAgdywWXOWqrxtgfLiAOsn30ECDLP+MnTqDA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PbWOhlU/Nm5Rx2yjeD3J9Rh+KB6ZTR+aZwhjT54bCY79HXA3gn4ErgG+S+MEh2siWo
         27AoqyRoHY3zagHiKHQCbFgw6yP50HOA87OANyouVMFmEN7cbzHyLqogH0ScGDKlNVxU
         zSzlHNKcHDTXm6/28ruqBLMDrqwQLzgZ37iVc=
Received: by 10.231.170.201 with SMTP id e9mr598246ibz.15.1257981311497; Wed, 
	11 Nov 2009 15:15:11 -0800 (PST)
In-Reply-To: <20091025111438.GA11252@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132718>

On Sun, Oct 25, 2009 at 1:14 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Felipe Contreras wrote:
>> Supposing that color.ui is 'auto' by default,
>
> Should it be? =C2=A0I think it would not be too hard to detect a colo=
r
> terminal by checking $TERM. =C2=A0Are many people bothered by color? =
=C2=A0Do we
> need some way to make it more obvious how to turn color _off_?

I think it should be.

>> No, but "improving" needs "changing", and the discussion I see is
>> biased towards "not changing".
> [...]
>> I don't think the user manual is achieving that purpose. I don't kno=
w
>> if it's the user manual's fault, or git's UI. Both areas need a lot =
of
>> improvement (as the git user survey suggests), and I've tried to
>> improve both with a lot resistance in both. So I'm not very hopeful
>> anymore.
>
> I hope you have not misunderstood. =C2=A0I cannot speak for everyone =
else
> here, but I know I am happier when (1) fixes match problems to be
> solved in a documented way and (2) fixes do not unnecessarily break
> unrelated habits. =C2=A0One way to bring this about is to justify eac=
h
> change by explaining what real problem it will solve and how it avoid=
s
> collateral damage. =C2=A0Without that justification, a change is inde=
ed
> dangerous and might be worth resisting until it gets clarified. =C2=A0=
But
> this is not meant to prevent fixes from occuring at all.

Well. I've sent many patches, and gone through several iterations.
After fixing all outstanding issues, addressing all the comments, and
getting several "I like this" votes, Junio suddenly decides he doesn't
like the initial changes at all and doesn't provide any way forward.

I don't see how that's an environment that fosters changes.

> Could you list some UI patches that were overlooked or not properly
> addressed? =C2=A0Maybe people just forgot about them or were waiting =
for an
> updated version, or maybe the problems some solve weren=E2=80=99t art=
iculated
> clearly yet. =C2=A0I would be glad to help out in any way I can.

=46or example there have been many attempts to bring the 'git stage' to
foreground of the UI; right now it's kind of hidden and many people
don't even realize it's there. Even simplistic attempts as
standardizing --index, --cache and so on into --stage have failed
miserably.

Again, there doesn't seem to be a path forward. Perhaps the git's
stage will remain an obscure feature of git forever. (all the input
from git user's survey points out that people are not really using it)

>> Judging from the luck I've had pushing even the simplest
>> changes I don't think it will improve much more, unfortunately.
>
> Even the simplest changes can be hard. =C2=A0But I hope they do not a=
mount
> to nothing. =C2=A0I hope at the very least the git-config manual page=
 will
> improve...

What I mean is: if the simplest changes are *impossible*, then there's
barely any hope of progress.

Cheers.

--=20
=46elipe Contreras
