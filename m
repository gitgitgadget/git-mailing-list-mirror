From: Mark Struberg <struberg@yahoo.de>
Subject: Re: [JGIT] Request for help
Date: Fri, 4 Sep 2009 07:33:06 +0000 (GMT)
Message-ID: <554991.93608.qm@web27807.mail.ukl.yahoo.com>
References: <loom.20090904T064602-511@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Gabe McArthur <gabriel.mcarthur@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 09:33:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjTIn-0002RS-Rk
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 09:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbZIDHdH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Sep 2009 03:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbZIDHdG
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 03:33:06 -0400
Received: from web27807.mail.ukl.yahoo.com ([217.146.182.12]:20327 "HELO
	web27807.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932279AbZIDHdF convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 4 Sep 2009 03:33:05 -0400
Received: (qmail 95134 invoked by uid 60001); 4 Sep 2009 07:33:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s1024; t=1252049586; bh=h3kPLy32CZ+wlnUD7MQAGEDL7sr2LahlMn3tAdWeYGI=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=UYMdA0ReYS17UNY8nHPmfIGtljN7wtBzEmzfPqqGcrTv7AU9hvlcVZd+C4e0S6gH4rVo+lKo7QCOYQGNwAFWKn/vhwHvHnrkB0SjG22kJFyKkq2RAYxUAkIptld/YaPMMOojMgvM5t+naunIzH/SahJNl8dWToM71urmQTBMLqI=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=MVheBjv5CYxrPbk8YxWnobN4cY2G/AuD/sHTR1nu/1mwhr+LG+QJvFrLtcgLgTmWq8+EIcfR6obKCz9jD5i/Vmog5RFK1EdFKpsEFdSWbj9lRfBlF/f5Nwzw2RRadQFT1SmUO9k1noEC7aiBKiE+dZSfKQWdaOmWRBbDidUV5Nc=;
X-YMail-OSG: RLb0pM0VM1kpGHDkCdK6_HoJ3tZtYYknPA8ZNBI02x7T315.QYskTx9nFacdeLmNC5xm3Xm8wAlYkL_ij_ufcf4boVgx0ZPJXSFnS7USZiC1fp8HSvid5wHDc.KzM0kw.maQVvZ6RWBE7V1p9xDaM9DqO6LKHzqBcqeHMaBttVVDTAcKpGccIIJRvJodJKcHn1wCnikcF6CuBv7wykNA5jxU_SuQJMHxcdmIl5ZKysDcBkJXpBSenzURj8ibHthSAmREhZsywOCP3tS2cx.2jhtXZMiitKLpVw--
Received: from [62.178.39.60] by web27807.mail.ukl.yahoo.com via HTTP; Fri, 04 Sep 2009 07:33:06 GMT
X-Mailer: YahooMailClassic/6.1.2 YahooMailWebService/0.7.338.2
In-Reply-To: <loom.20090904T064602-511@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127691>

Seems this speeds up lately ;)

Gabe, please allow me a few questions:

=2E) why do we need the /sources directory layer? I think /jgit and /jg=
it-pgm would be enough.

=2E) imho the docs should stay in / at least the LICENSE file

=2E) we don't need a tag.sh any more if we work with maven. Maven now h=
as the maven-scm-provider-gitexe activated by default (since early 2008=
), so=20
mvn release:prepare
mvn release:perform
should work if we set the proper <scm> section. Any feedback or bugrepo=
rting on the maven-git integration is highly welcome btw ;)


LieGrue,
strub


--- On Fri, 9/4/09, Gabe McArthur <gabriel.mcarthur@gmail.com> wrote:

> From: Gabe McArthur <gabriel.mcarthur@gmail.com>
> Subject: Re: [JGIT] Request for help
> To: git@vger.kernel.org
> Date: Friday, September 4, 2009, 7:00 AM
> =20
> Shawn O. Pearce <spearce <at> spearce.org>
> writes:
>=20
> >=20
> > Please post patches; formatted with -M.=A0 I do
> want to do this, I just
> > don't have the patience and Maven-fu to write the new
> poms myself.
> >=20
>=20
>=20
> Hey,
> I'm a build engineer with a considerable amount of
> "Maven-fu" :).=A0 I've actually=20
> generated a patch that does everything you want (and a bit
> more).=A0 I'm not that=20
> familiar with git's command line yet, so it's a bit tricky
> to get the patch=20
> thing right.=A0 However, here's a rough overview of what
> I did:
>=20
> ROOT
> =3D=3D=3D=3D
> README
> /bin
> =A0 bash.env=A0=A0=A0-- A script that you can
> source from Bash that
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
> will add the 'jgit' executable and the other
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
> scripts in this 'bin' directory to your PATH
> =A0 build.sh=A0=A0=A0-- A general build script,
> that hides some
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
> Maven complexities for initiates.
> =A0 tag.sh=A0 =A0=A0=A0-- Ok, this is the
> only thing that will have to=20
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 be
> re-written.=A0 It's too tied in with git commands for
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 me
> to fully extract what it's supposed to do.
> /docs
> =A0 LICENSE
> =A0 SUBMITTING_PATCHES
> =A0 TODO
> pom.xml=A0 =A0 =A0 -- A considerable amount of
> build logic has been
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
> centralized here.=A0 It references 3 sub-module
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
> projects, listed below.
> /sources
> =A0 /jgit-lib
> =A0 =A0 pom.xml
> =A0 =A0 /src/main/java....
> =A0 =A0 /src/test
> =A0 =A0 =A0 /java....
> =A0 =A0 =A0 /resources=20
> =A0 =A0 =A0 /exttst=A0=A0=A0-- Don't know
> exactly where this goes, as it
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0=A0=A0doesn't seem to be doing much/being run=20
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0=A0=A0currently.
> =A0 /jgit-pgm
> =A0 =A0 pom.xml=A0 =A0=A0=A0-- Does the
> work to do a 'jar-with-dependencies'=20
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0=A0=A0so that org.spearce.jgit.pgm.build can be
> removed.
> =A0 =A0 /src/main/java....
> =A0 /jgit-exec
> =A0 =A0 pom.xml=A0 =A0=A0=A0-- Actually
> generates the 'jgit' executable and
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0=A0=A0installs it in ROOT/target/bin, so that it
> will
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0=A0=A0be on your path after sourcing
> 'bin/bash.env'
> =A0 =A0 /src/main/scripts/jgit
>=20
> I'll try to submit a full patch later, using your
> conventions.
>=20
> My appreciation to Shawn for pointing out this thread....
> -Gabe
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe
> git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=A0 http://vger.kernel.org/majordomo-info.html
>=20


     =20
