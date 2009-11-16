From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 0/2] user-manual: new "getting started" section
Date: Tue, 17 Nov 2009 00:52:37 +0200
Message-ID: <94a0d4530911161452xe82858el322a1985341bf13c@mail.gmail.com>
References: <1256377489-16719-1-git-send-email-felipe.contreras@gmail.com>
	 <7vy6n065os.fsf@alter.siamese.dyndns.org>
	 <7vr5ss64e5.fsf@alter.siamese.dyndns.org>
	 <94a0d4530910241316r3fc4136emd036d18aa45a4192@mail.gmail.com>
	 <7vy6n02mrk.fsf@alter.siamese.dyndns.org>
	 <94a0d4530910250243k4cbc3c18l5e018a05e5afdb2d@mail.gmail.com>
	 <20091025111438.GA11252@progeny.tock>
	 <94a0d4530911111515q643e263bn3adc6b47cd968d3d@mail.gmail.com>
	 <4AFBF18E.7070906@drmicha.warpmail.net>
	 <20091114060600.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Hannu Koivisto <azure@iki.fi>, Jeff King <peff@peff.net>,
	Wincent Colaiuta <win@wincent.com>,
	Matthias Lederhofer <matled@gmx.net>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 23:53:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAARv-0003S7-Hp
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 23:53:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754652AbZKPWwh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Nov 2009 17:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754640AbZKPWwf
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 17:52:35 -0500
Received: from mail-iw0-f178.google.com ([209.85.223.178]:43106 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754579AbZKPWwb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Nov 2009 17:52:31 -0500
Received: by iwn8 with SMTP id 8so4620278iwn.33
        for <git@vger.kernel.org>; Mon, 16 Nov 2009 14:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9WEkE/nGjtWwUe7e9tgAs08RmuaCzeYcTUYUXehF8kI=;
        b=GNpZPuQS1iJb+TmwEcK+HgwaL0OHfCc77ze3yE7ZdUld4m6B44FTIxdiM5RInRk3I5
         YPlkstvMO5xcSgjr7/zwBCb4K7VYx1XpZqk6rb2JHJOAy/qADy1Z8pgaBGMyPLPZ7wWS
         C58aLK/+dBVB2ZOu++YTnLCg/kWlnDTy9LfQA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DoSmzEphT9TDTLEC+EfiRSk7Tcr/KQLT7s3j0w7DItEfLQVEHG2757DPoXqty8+hFX
         wEwswL4N2uP0fx8YncgD/BkITpk1qhtIK5XuEqgZH4+lAUXuK+wgJsIiwc/kylaeUzcn
         YN7xO71TouwJHu/W/seJP0+X8CErRm8E2oqtg=
Received: by 10.231.161.138 with SMTP id r10mr713735ibx.34.1258411957228; Mon, 
	16 Nov 2009 14:52:37 -0800 (PST)
In-Reply-To: <20091114060600.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133033>

On Fri, Nov 13, 2009 at 11:06 PM, Nanako Shiraishi <nanako3@lavabit.com=
> wrote:
> Quoting Michael J Gruber <git@drmicha.warpmail.net>
>> If you care to go back to that discussion you see that there is good
>> reason for having both --cached and --index. They are different. "gi=
t
>> help cli" explains this nicely.
>
> The need to support both options in the same command (eg. apply) mean=
s
> that anybody who says "I don't like 'index' nor 'cache'; why don't we
> change them all to 'stage'" doesn't understand the issue.
>
> But that doesn't mean "apply --cached" vs "apply --index" is the best
> way to let the users specify which operation is requested. I don't
> think Felipe seriously wants to change them to --gogo vs --dance, but
> if he made a more constructive proposal, instead of making such a
> comment whose intended effect is only to annoy people, we may see
> an improved UI at the end. =C2=A0Proposing "--index-only" vs "--index=
-too"
> or even "--stage-only" vs "--stage-too" would have helped him appear
> to be more serious and constructive and I think your expression
> "mismatching participants" was a great way to say this.

Right, your explanation is more clear: the fact that we need both
doesn't mean we cannot use the term "stage". As to "constructive
proposal" I deliberately tried to avoid them in case somebody tried to
disregard it as bike-shedding, and move on. What I'm trying to do is
bring up the issue that the stage is not user friendly.

> There was a similar discussion about "diff --cached". The command
> compares two things and the current syntax relies on counting the
> number of treeish on the command line to specify what these two thing=
s
> are, and sometimes people are confused which way the comparison occur=
s.
>
> =C2=A0* If you have two treeish, it compares the two treeish. Specifi=
cally,
> =C2=A0 it shows the change to make one treeish into the other treeish=
=2E
>
> =C2=A0* If you have one treeish, it compares the treeish with working=
 tree
> =C2=A0 or the index (it shows the change to make the treeish into wor=
king
> =C2=A0 tree or the index). You need --cached to choose the "index", a=
nd
> =C2=A0 this can safely be aliased to --staged.
>
> =C2=A0* If you have zero treeish, it compares the index with working =
tree
> =C2=A0 (it shows the change to make the index into working tree).
>
> But it is also possible to have an alternate syntax to explicitly say
> what you are comparing with what. Perhaps these may make it unnecessa=
ry
> to remember which way the comparison occurs:
>
> =C2=A0git diff --tree-vs-staged HEAD
> =C2=A0 =C2=A0 =C2=A0 =C2=A0same as "git diff --cached HEAD"
> =C2=A0git diff --staged-vs-tree HEAD
> =C2=A0 =C2=A0 =C2=A0 =C2=A0same as "git diff -R --cached HEAD"
>
> =C2=A0git diff --staged-vs-working
> =C2=A0 =C2=A0 =C2=A0 =C2=A0same as "git diff"
> =C2=A0git diff --working-vs-staged
> =C2=A0 =C2=A0 =C2=A0 =C2=A0same as "git diff -R"
>
> =C2=A0git diff --tree-vs-working HEAD
> =C2=A0 =C2=A0 =C2=A0 =C2=A0same as "git diff HEAD"
> =C2=A0git diff --working-vs-tree HEAD
> =C2=A0 =C2=A0 =C2=A0 =C2=A0same as "git diff -R HEAD"

I like David K=C3=A5gedal's suggestion more:
http://kerneltrap.org/mailarchive/git/2008/10/29/3857134

Cheers.

--=20
=46elipe Contreras
