From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: ETA for release of gjit 0.4?
Date: Tue, 16 Dec 2008 04:56:42 +0100
Message-ID: <200812160456.43222.robin.rosenberg.lists@dewire.com>
References: <49393BFC.6010606@wellfleetsoftware.com> <493D4CDB.2010100@wellfleetsoftware.com> <4946DFBB.6030300@wellfleetsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Farrukh Najmi <farrukh@wellfleetsoftware.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 04:58:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCR4X-0006jh-LY
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 04:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbYLPD4z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Dec 2008 22:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbYLPD4z
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 22:56:55 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:34579 "EHLO
	pne-smtpout1-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750998AbYLPD4z convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 22:56:55 -0500
Received: from sleipner.localnet (213.67.100.250) by pne-smtpout1-sn1.fre.skanova.net (7.3.129)
        id 47A97950052D0C66; Tue, 16 Dec 2008 04:56:45 +0100
User-Agent: KMail/1.10.3 (Linux/2.6.27-10-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <4946DFBB.6030300@wellfleetsoftware.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103242>

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

I cannot deploy it seems (I get a 401 or dav not supported), but since =
we have a
tagged v0.4.0 commit you have a handle to make your own local deploymen=
t. It=20
is at least defined what commit the v0.4.0 is. You'll need to modify th=
e pom.xml
to make it name the jars properly,=20

diff --git a/jgit-maven/jgit/pom.xml b/jgit-maven/jgit/pom.xml
index c370783..467e620 100644
--- a/jgit-maven/jgit/pom.xml
+++ b/jgit-maven/jgit/pom.xml
@@ -39,7 +39,7 @@ ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
     <groupId>org.spearce</groupId>
     <artifactId>jgit</artifactId>
     <packaging>jar</packaging>
-    <version>0.4-SNAPSHOT</version>
+    <version>0.4.0</version>
     <name>jgit</name>
     <url>http://repo.or.cz/w/egit.git</url>
     <mailingLists>

-- robin
