From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: ETA for release of gjit 0.4?
Date: Tue, 16 Dec 2008 05:17:33 +0100
Message-ID: <200812160517.33975.robin.rosenberg.lists@dewire.com>
References: <49393BFC.6010606@wellfleetsoftware.com> <493D4CDB.2010100@wellfleetsoftware.com> <4946DFBB.6030300@wellfleetsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	fonseca@diku.dk
To: Farrukh Najmi <farrukh@wellfleetsoftware.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 05:19:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCROf-00023y-RA
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 05:19:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbYLPERo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Dec 2008 23:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751609AbYLPERo
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 23:17:44 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:40505 "EHLO
	pne-smtpout1-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751513AbYLPERn convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 23:17:43 -0500
Received: from sleipner.localnet (213.67.100.250) by pne-smtpout1-sn1.fre.skanova.net (7.3.129)
        id 47A97950052D1237; Tue, 16 Dec 2008 05:17:35 +0100
User-Agent: KMail/1.10.3 (Linux/2.6.27-10-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <4946DFBB.6030300@wellfleetsoftware.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103245>

Jonas, could you help us on this:

[INFO] ----------------------------------------------------------------=
--------                                                         =20
[ERROR] BUILD ERROR                                                    =
                                                                 =20
[INFO] ----------------------------------------------------------------=
--------                                                         =20
[INFO] Error deploying artifact: Failed to transfer file: http://egit.g=
ooglecode.com/svn/maven/snapshot-repository//org/spearce/jgit/0.4.0/jgi=
t-0.4.0.jar. Return code is: 401                                       =
                                                                       =
                             =20

I added this (nah, naming it release-repository didn't work either)

        <repository>
            <id>jgit-maven-release-repository</id>
            <name>JGit Maven Release Repository</name>
            <url>https://egit.googlecode.com/svn/maven/snapshot-reposit=
ory/</url>
            <uniqueVersion>true</uniqueVersion>
        </repository>

(tried all combinations of dav/not-dav, http/https). Seems I don't have=
 a dav provider,=20
but https should work, right?

and to ~/.m2/settings.xml

  <servers>
    <server>
      <id>jgit-maven-snapshot-repository</id>
      <username>tried both my project email and gmail email</username>
      <password>nah, won't show you</password>
    </server>
  </servers>

-- robin

m=E5ndag 15 december 2008 23:52:43 skrev Farrukh Najmi:
>=20
> Hi Shawn,
>=20
> I was wondering if there are any updates on my question on whether we=
=20
> can have a 0.4 release of jgit (no SNAPSHOT).
> I am ready to release my software but maven wont let me release it=20
> because its dependency jgit is a SNAPSHOT release.
>=20
> As I recall you had planned to release 0.4 and make it available on t=
he=20
> maven repo at:
>=20
> <http://egit.googlecode.com/svn/maven/snapshot-repository/org/spearce=
/jgit>
>=20
> I do not see it there yet. Any chance of getting that today? Thanks.
>=20
