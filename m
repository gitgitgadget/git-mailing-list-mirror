From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH V3] git-send-email: Add auto-cc to all body signatures
Date: Wed, 02 Dec 2015 10:20:50 -0800
Message-ID: <1449080450.3716.44.camel@perches.com>
References: <b2937bc06d1bff456b84e51d6edee0bb1afc5f31.1311902983.git.joe@perches.com>
	 <1311903782.20837.42.camel@jtkirshe-mobl>
	 <1323313119.1762.58.camel@joe2Laptop>
	 <7v8vmmj1ng.fsf@alter.siamese.dyndns.org>
	 <1323377486.1762.71.camel@joe2Laptop> <87mvtti2ul.fsf@rasmusvillemoes.dk>
	 <1449075602.3716.27.camel@perches.com>
	 <xmqq8u5c68by.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rasmus Villemoes <rv@rasmusvillemoes.dk>, git@vger.kernel.org,
	jeffrey.t.kirsher@intel.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 19:20:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4C1S-0000D0-HL
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 19:20:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758941AbbLBSUy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Dec 2015 13:20:54 -0500
Received: from smtprelay0165.hostedemail.com ([216.40.44.165]:58961 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758209AbbLBSUx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Dec 2015 13:20:53 -0500
Received: from filter.hostedemail.com (unknown [216.40.38.60])
	by smtprelay08.hostedemail.com (Postfix) with ESMTP id 8E7D229DD78;
	Wed,  2 Dec 2015 18:20:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 40,2.5,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1431:1437:1515:1516:1518:1535:1544:1593:1594:1605:1711:1730:1747:1777:1792:2197:2198:2199:2200:2393:2553:2559:2562:2687:2689:2691:2693:2828:2895:3138:3139:3140:3141:3142:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:6261:6299:7903:7904:7974:8660:10011:10848:11026:11232:11658:11783:11914:12109:12517:12519:12740:13095:13141:13148:13158:13161:13228:13229:13230:13894:14659:21063:21080:21221:21222:30003:30012:30021:30022:30026:30029:30030:30051:30054:30056:30064:30069:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:none,Custom_rules:0:1:0,LFtime:8,
 LUA_SUMMARY:none
X-HE-Tag: skin05_41ae0797ec54a
X-Filterd-Recvd-Size: 5554
Received: from joe-X200MA.home (pool-173-51-221-2.lsanca.fios.verizon.net [173.51.221.2])
	(Authenticated sender: joe@perches.com)
	by omf11.hostedemail.com (Postfix) with ESMTPA;
	Wed,  2 Dec 2015 18:20:51 +0000 (UTC)
In-Reply-To: <xmqq8u5c68by.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.18.2-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281898>

On Wed, 2015-12-02 at 09:58 -0800, Junio C Hamano wrote:
> Joe Perches <joe@perches.com> writes:
>=20
> > Many types of signatures are used by various projects.
> >=20
> > The most common type is formatted:
> > 	"[some_signature_type]-by: First Last <email <at> domain.tld>"
> > e.g:
> > 	"Reported-by: First Last <email <at> domain.tld>" (no quotes are u=
sed)
> >=20
> > Make git-send-email use these signatures as "CC:" entries.
> >=20
> > Add command line option --suppress-cc=3Dsignatures to avoid
> > adding these entries to the cc.
> >=20
> > Signed-off-by: Joe Perches  perches.com>
> > Acked-by: Jeff Kirsher  intel.com>
>=20
> I wonder what send-email with this patch does to the above two lines
> with "" not "@" ;-)=A0=A0How was this patch sent?

gnome evolution v3.18.2 email client.

And it seems all newer versions of evolution beyond 3.12
are really, really poor at sending inline patches. <grumble>

I'll update and resend using git-send-email eventually

> In any case, did you mean "Helped-by:" not "Acked-by:"?=A0=A0"git
> shortlog git-send-email.perl" does not show that name as one of the
> major stakeholders who would be capable of giving an Ack on it.

At least for linux-kernel, "Acked-by:" doesn't mean a maintainer
or a contributor to a particular module/file, just someone that
has looked at the patch, tried it, and approved of the concept.

I don't know what process git uses for approval/signatures.

> > ---
> > > It's been four years, but I recently ran into this. I mistakenly =
thought
> > > that git would actually pick up cc addresses also from Reported-b=
y, so
> > > the reporter ended up not being cc'ed. Is there any chance this c=
ould be
> > > revisited,
> >=20
> > Here's a refresh if desired.=A0=A0I still think it's sensible.
>=20
> What the patch tries to achieve may make a lot of sense.=A0=A0I howev=
er
> do not necessarily think this particular implementation does,
> unfortunately.
>=20
> These "Random-by:", especially the ones that the author adds on his
> own initiative like "Reported-by:", are often followed by just a
> name but not an addresses.=A0=A0A "Signed-off-by:" and "Cc:" that is =
not
> followed by a valid e-mail address may deserve to get an error (or
> perhaps an end-user interaction "This is not a valid address. What
> do you want to do about it?") so "/^(Signed-off-by|Cc): (.*)$/i"
> does not need its own sanity check on $2, because a later call to
> extract-valid-address or extract-valid-address-or-die will take care
> of it.

> It would however be wrong to cause the program to error out or even
> bother the user upon seeing such random trailer lines that the
> author did not mean to have an e-mail address on it in the first
> place.=A0=A0If you have a trailer line
>=20
> =A0=A0=A0=A0Random-by: Joe Perches
>=20
> without an address, I suspect you will end up adding "Joe" and
> "Perches" as two addresses on the Cc: line, which is most likely not
> what the user intended [*1*].

At least with new versions of git-send-email.perl
that's true so the patch will need to validate that
there is an email address following.

> As to the lingo, these are still not signatures, but during the past
> years, it seems that we settled on using the term "trailers" for
> these e-mail header-like things at the end of the log message.
> "Trailers" are not limited to "*-by:" so this patch is not about
> adding auto-cc to all trailers--a retitle would be
>=20
> =A0=A0=A0=A0send-email: add auto-cc to addresses that appear on *-by:=
 trailers
>=20
> or something (and the option and variable names may need to be
> updated to match).
>=20
>=20
> [Footnote]
>=20
> *1* I further suspect that the existing code shares a similar issue.
> Don't Cc: and Signed-off-by: expect a single address on each line in
> the usual fashion?=A0=A0Perhaps a two-patch series whose first part d=
oes
>=20
> -		if (/^(Signed-off-by|Cc): (.*)$/i) {
> +		if (/^(Signed-off-by|Cc): (.*<[^>]*>)\s*$/i) {
>=20
> to tighten it (so that "Cc: Joe Perches" would not result in two
> pieces of mail sent to Joe and Perches), with your patch as a follow
> up, may be a good way forward.
>=20
> I dunno.

I believe the old git-send-email code required addresses
and validated the form after Signed-off-by:'s.

I haven't looked at the code for several years and just
refreshed it without much thinking or testing.

I'll do a bit more and resend.
