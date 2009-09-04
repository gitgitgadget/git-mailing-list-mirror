From: Mark Struberg <struberg@yahoo.de>
Subject: Re: [JGIT] Request for help
Date: Fri, 4 Sep 2009 07:12:15 +0000 (GMT)
Message-ID: <64897.80194.qm@web27807.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nasser Grainawi <nasser@codeaurora.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jonas Fonseca <jonas.fonseca@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Sep 04 09:12:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjSyQ-00021u-UY
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 09:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755376AbZIDHMR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Sep 2009 03:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755446AbZIDHMR
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 03:12:17 -0400
Received: from web27807.mail.ukl.yahoo.com ([217.146.182.12]:32564 "HELO
	web27807.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751585AbZIDHMP convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 4 Sep 2009 03:12:15 -0400
Received: (qmail 81027 invoked by uid 60001); 4 Sep 2009 07:12:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s1024; t=1252048336; bh=Ghww6iLx2j5k98hbiOLDsfbdP254mlstUMIQhSSQ93U=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=FZvh9nEyIUwuiN0Rce/M59/blLSo8rDVtB4Do6m0NeD6oUMc8u9hh1wAjRyOlUCSTd1ie28DZBAvWEWEE8wd9KA5CKOtF42DCMMaH0CN5L1dztzjwM7II0q63fjZr54I2RMIesqA+uz/2gtylV2EpXu6WRS0IA+8bOT+SZWCAVw=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=kiaug2NEgEcAzBOhVjTQ6Wzbc6iTFRaf6iQ2eWYdqoHzpHO58B8f8RAKgEezYHraxd/Lp/MhJCYJ3/RIAEp9N5bjbemTEfQIlDRbpHbrDh/DNpbCOtBsZfgnM7ibwxoULOh3w6ab8dEhHIDceZ3Irk3may9g4tPWg9AJ5Hp1sEU=;
X-YMail-OSG: ji6yTqkVM1ntBSnaZEc0nm.K3R4CkErTwHnY8D_pyHtKs3O4SgMQgL3mQ6bFE9tPpZ0RdNTHKQmq8AUR9kDWSOrNjpbxkNbrVKiiQajT9e8b_nGLNBeMSg2SnXCoAjmAN9XMRuAqYKM1RN_hTkxbhyIWsJkJgYuZ5sHzvS4HNDsWiFIgchD25JXDplOorE5ianUSB.ygnnwi2pKJQMlbQ0IitDzkYohIn5DQj0sRsfHDtwX0ypQII2F7xgQqBMESW8RcAIwQrAd9r3xPJlvS1.g1sEn3tVfg4TUvMGY6R7CfeMxMMug-
Received: from [62.178.39.60] by web27807.mail.ukl.yahoo.com via HTTP; Fri, 04 Sep 2009 07:12:15 GMT
X-Mailer: YahooMailClassic/6.1.2 YahooMailWebService/0.7.338.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127689>

Hi!

Since I work on the sonatype repo and also being a maven guy, I'd be ha=
ppy to help!

There are a few patches from the work we've done to come the next weeks=
 anyway, starting with IgnoreRules and stuff. I think we still have to =
improve the code quality of SimpleRepository but I'd be happy to hear y=
our opinion on this too, so I maybe send a RFC.

If you like to go with maven for JGIT, we have 2 options:

1.) Use the current directory structure and use the configuration you c=
an see in the sonatype poms Jason did. E.g all paths have to be set in =
pom.sml


2.) Do a complete rework and move over to the standard maven layout [1]=
 . This may include moving org.spearce.jgit.test/ to org.spearce.jgit/s=
rc/test/java resp org.spearce.jgit/src/test/resources.=20
In the meantime Eclipse is really fine with handling separate target fo=
lders for production code and test classes (target/classes vs target/te=
st-classes) so this is not a showstopper any more.


LieGrue,
strub

[1] http://maven.apache.org/guides/introduction/introduction-to-the-sta=
ndard-directory-layout.html


--- On Thu, 9/3/09, Shawn O. Pearce <spearce@spearce.org> wrote:

> From: Shawn O. Pearce <spearce@spearce.org>
> Subject: Re: [JGIT] Request for help
> To: "Jonas Fonseca" <jonas.fonseca@gmail.com>
> Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>, "Nasser Grain=
awi" <nasser@codeaurora.org>, "Git Mailing List" <git@vger.kernel.org>
> Date: Thursday, September 3, 2009, 5:52 PM
> Jonas Fonseca <jonas.fonseca@gmail.com>
> wrote:
> > On Thu, Sep 3, 2009 at 10:42, Shawn O. Pearce<spearce@spearce.org>
> wrote:
> > > Actually, now that we have forked out of the
> egit.git repository,
> > > I want to refactor the layout of the JGit project
> to be more maven
> > > like, and have a proper top-level pom to build
> things.
> >=20
> > What kind of module structure do you have in mind? Do
> you want to move
> > some of the modules/subdirectories?
> > Some refactoring of the maven setup for JGit back was
> done back in
> > April in sonatype's (a maven company) JGit clone. It
> is not
> > signed-off, but can serve as a reference.
>=20
> Yea, I was hoping they would contribute this back as
> patches,
> but thus far they haven't.
>=A0=20
> > The Maven layout in the sonatype clone simply uses the
> Eclipse project layout.
> >=20
> > pom.xml: JGit :: Parent
> >=A0 |- org.spearce.jgit/pom.xml: JGit :: Core
> >=A0 |- org.spearce.jgit.pgm/pom.xml: JGit ::
> Programs
> >=A0 `- org.spearce.jgit.test/pom.xml: JGit :: Test
> >=20
> > However, having tests in a separate module can be both
> good/bad. For
> > example, they will not automatically get run when you
> only build the
> > Core module.
>=20
> Yea, I know.=A0 This is one area where Maven is just
> whack, by putting
> the tests in the same project the Maven plugin for Eclipse
> puts
> them into the same classpath, which means you can see test
> code
> from project code.=A0 Wrong.=A0 They should be
> different projects so
> the test classpath is isolated.
>=20
> However.=A0 This is a bug in the Eclipse plugin I think,
> not
> necessarily with Maven's approach of trying to keep tests
> alongside
> the code they test.=A0 Thus we probably want:
>=20
> =A0 pom.xml: JGit :: Parent
> =A0=A0=A0|- jgit-lib/pom.xml: JGit
> =A0=A0=A0|=A0
> =A0=A0=A0src/main/java=A0 <-- from
> org.spearce.jgit/src
> =A0=A0=A0|=A0
> =A0=A0=A0src/test/java=A0 <-- from
> org.spearce.jgit.test/src
> =A0=A0=A0|
> =A0=A0=A0`- jgit-pgm/pom.xml: JGit pgm
> =A0 =A0 =A0 =A0=A0=A0src/main/java=A0
> <-- from org.spearce.jgit.pgm/src
>=20
> IIRC there is Maven support to create proper MANIFEST.MF
> files for
> OSGI bundles, which is what we need for the Eclipse plugin
> support.
> That should be able to replace the META-INF/MANIFEST.MF in
> the top
> of each of the current directories.
>=20
> > Anyway, I would like to help.
>=20
> Please post patches; formatted with -M.=A0 I do want to
> do this, I just
> don't have the patience and Maven-fu to write the new poms
> myself.
>=20
> --=20
> Shawn.
> --
> To unsubscribe from this list: send the line "unsubscribe
> git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=A0 http://vger.kernel.org/majordomo-info.html
>




     =20
