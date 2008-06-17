From: Mirko Stocker <mirko.stocker@hsr.ch>
Subject: git-cvsserver: Index already exists in git repo
Date: Tue, 17 Jun 2008 14:09:25 +0200
Organization: HSR
Message-ID: <200806171409.25572.mirko.stocker@hsr.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 17 14:11:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8a1g-00041f-Cx
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 14:11:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754611AbYFQMKE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Jun 2008 08:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755105AbYFQMKE
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 08:10:04 -0400
Received: from luc80-74-131-252.ch-meta.net ([80.74.131.252]:35347 "EHLO
	lucius.metanet.ch" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754382AbYFQMKD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jun 2008 08:10:03 -0400
Received: (qmail 16462 invoked from network); 17 Jun 2008 14:09:34 +0200
Received: from unknown (HELO pin6108034.hsr.ch) (152.96.200.175)
  by luc80-74-131-153.ch-meta.net with (DHE-RSA-AES256-SHA encrypted) SMTP; 17 Jun 2008 14:09:34 +0200
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85294>

Hi

I'm using git-cvsimport (with -i) to import an existing repository, whi=
ch I=20
then clone for development. Now, we have some guys here that'd rather=20
continue to use the Eclipse CVS plug-in than working directly with Git,=
 so I=20
thought I could tell them to try git-cvsserver.

Now, git-cvsserver complains about an existing index file in the server=
=20
repository. If I just remove the index file on the server, everything s=
eems=20
to work just fine. But 'rm .git/index'  just doesn't feel right... what=
 I=20
understand so far: the index file seems to contain information about th=
e=20
files in the tree, but it doesn't exist in a bare repository. So, is th=
ere a=20
way to 'convert' a repository to a bare repository so that git-cvsimpor=
t and=20
git-cvsserver still work on it? Or, how would you do it?

Thanks!

Mirko

--=20
Mirko Stocker
Institut f=FCr Software - http://ifs.hsr.ch - +41 55 222 4713
HSR Hochschule f=FCr Technik Rapperswil
Oberseestr 10, Postfach 1475, CH-8640 Rapperswil
