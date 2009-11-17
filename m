From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 0/2] user-manual: new "getting started" section
Date: Wed, 18 Nov 2009 01:06:17 +0200
Message-ID: <94a0d4530911171506o2b08954bw4acba8ea9193e65d@mail.gmail.com>
References: <7vr5ss64e5.fsf@alter.siamese.dyndns.org>
	 <94a0d4530911111515q643e263bn3adc6b47cd968d3d@mail.gmail.com>
	 <4AFBF18E.7070906@drmicha.warpmail.net>
	 <20091114060600.6117@nanako3.lavabit.com>
	 <94a0d4530911161452xe82858el322a1985341bf13c@mail.gmail.com>
	 <20091117210625.6117@nanako3.lavabit.com>
	 <20091117172815.GH31767@fieldses.org>
	 <7vocn1dn5d.fsf@alter.siamese.dyndns.org>
	 <94a0d4530911171400ub3b093ai668fd2404b12272f@mail.gmail.com>
	 <7v4ooseqvb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Hannu Koivisto <azure@iki.fi>, Jeff King <peff@peff.net>,
	Wincent Colaiuta <win@wincent.com>,
	Matthias Lederhofer <matled@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 00:07:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAX8Z-0001y1-76
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 00:07:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756603AbZKQXGO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Nov 2009 18:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756288AbZKQXGO
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 18:06:14 -0500
Received: from mail-iw0-f178.google.com ([209.85.223.178]:64433 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756327AbZKQXGM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Nov 2009 18:06:12 -0500
Received: by iwn8 with SMTP id 8so443350iwn.33
        for <git@vger.kernel.org>; Tue, 17 Nov 2009 15:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lHmjFKVb72+M7NZRqQR8q9FKniudHJ2j/SD/mFVZUrE=;
        b=PEOrkyq111fzhqHGiWTC2r0ak4Rnrts3pU8gYc1sltGkUBrvOiXqdMGhCg+UEDAnmi
         Zl5kbWGJpuFgebvi8CJfFmdC/bZCrPp+soSQNr475+Mmv/Kglw8tLVelDRg4AEy8yFbn
         v2mbbh35+n0DoTDS/n6We+xY4GEAtf1/pVwlM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=i1OGmaPnGalVQsjjd1U4aHJLPbJUJs/MKmlTBmKnzLS37pV2onkJ+hHqxLuXSGJDUQ
         PcrjPiYGubf0z0XZTZnTH7IcXCdkvER4+imyciwPceEtx0ImkwNe/BMPiWKjeTOd7hOG
         07LS0uczsq1YsaYoRUq3zZ1oxD+2ui9iNMvUM=
Received: by 10.231.170.201 with SMTP id e9mr542276ibz.16.1258499177892; Tue, 
	17 Nov 2009 15:06:17 -0800 (PST)
In-Reply-To: <7v4ooseqvb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133109>

On Wed, Nov 18, 2009 at 12:19 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> That could be easily fixed by making explicit in the syntax that the=
se
>> are not typical refs: i.e. @stage and @work.
>
> The message I get from that suggestion is that the most sensible appr=
oach,
> if we are going to add something from this discussion to "git diff", =
is to
> do what you did _not_ quote from my message, which is:
>
> =C2=A0 =C2=A0As to --tree-vs-index counterproposal (was it a counterp=
roposal?),
> =C2=A0 =C2=A0except for that I think they are too long to type in pra=
ctice and need
> =C2=A0 =C2=A0to be shortened to be useful, I do not have a fundamenta=
l objection
> =C2=A0 =C2=A0against it.
>
> IOW, this is about options, and should not be done as syntax sugar th=
at
> does a half-baked job of pretending to be refs.

Sorry, I thought your only objection to STAGE and WORKTREE was that
they were not clearly differentiated, and my proposal gets rid of that
issue. Now I fail to see what's the problem since you didn't explain
what's wrong with adding syntactic sugar.

If the goal of the change is to make things more user-friendly, then
I'd say "git diff HEAD @stage" is better than "git diff
--tree-vs-staged HEAD".

--=20
=46elipe Contreras
