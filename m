From: stoecher@gmx.at
Subject: parallel dev. with email
Date: Tue, 03 Mar 2009 16:31:41 +0100
Message-ID: <20090303153141.246620@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 16:33:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeWcM-0007mN-UM
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 16:33:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753609AbZCCPbq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 10:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753051AbZCCPbq
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 10:31:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:50034 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752858AbZCCPbp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 10:31:45 -0500
Received: (qmail 32436 invoked by uid 0); 3 Mar 2009 15:31:42 -0000
Received: from 163.157.254.25 by www179.gmx.net with HTTP;
 Tue, 03 Mar 2009 16:31:41 +0100 (CET)
X-Authenticated: #18025557
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
X-Provags-ID: V01U2FsdGVkX1/FUa10oCbFST98qa0vz5MYyAaTLdaUER39EmbUDU
 gyIz+xaOdZQghL/DQMwMn9/hZ8FeqzWVOmdg== 
X-GMX-UID: b3SVfGoTbmwoeid+ezZLfhVPUzc4ctFP
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112086>

Hi,

I am new to git and I am wondering what git commands to use for this sz=
enario: two developers without the possibility of sharing a server comm=
unicate their changes via email.

This is how far I have come reading the online docu:
* Each developer can create the diff-info of his commits with
  git format-patch
* and the other developer can incorporate these changes with
  git am

After creating the patches with format-patch one could set a tag:
  git tag -f patchesDone
so next time one wants to create patches, this tag can be used as the s=
tarting point:
  git format-patch patchesDone..

But what if in the meantime one has incorporated the other developer's =
changes with git am? Then these changes will also be among the patches =
created with format-patch. What will happen, if these patches are sent =
to the other developer, who does not need his own changes again. Will h=
is own changes be silently ignored by git am? Or how else to effectivel=
y coordinate the work of two developers with git via email?

thank you,

Wolfgang
--=20
Computer Bild Tarifsieger! GMX FreeDSL - Telefonanschluss + DSL
f=FCr nur 17,95 =BF/mtl.!* http://dsl.gmx.de/?ac=3DOM.AD.PD003K11308T45=
69a
