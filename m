From: stoecher@gmx.at
Subject: just curious: what influences a commit hash?
Date: Thu, 05 Mar 2009 07:36:32 +0100
Message-ID: <20090305063632.42880@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 05 07:38:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lf7DZ-0005dT-Tc
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 07:38:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275AbZCEGgg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2009 01:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751951AbZCEGgg
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 01:36:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:57128 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751933AbZCEGgf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 01:36:35 -0500
Received: (qmail 11769 invoked by uid 0); 5 Mar 2009 06:36:32 -0000
Received: from 163.157.254.25 by www009.gmx.net with HTTP;
 Thu, 05 Mar 2009 07:36:32 +0100 (CET)
X-Authenticated: #18025557
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
X-Provags-ID: V01U2FsdGVkX1+oW58lj6uot0VolfLr7IhtbZ7pS47e+l/Y5lTp5R
 qRT5seOo9nJCyGxWZ216r4fufRIBLjBxAQnQ== 
X-GMX-UID: yUqZAIhXQEV/GmI6enRp+yhCNzg2NcKO
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112256>

Hi,

being new to git I did some experiments with commits looking at the has=
hes. What I observed:
* The same commit (same file, same committer, same message) into differ=
ent empty repositories (git init) gives different hashes. So I assume t=
hat also the time of the commit influences the hash. Is this intended? =
=46or what reason?
* Having created two repositories exactly the same way (the history is =
the same except for the commit times and hashes) I applied the same pat=
ch (using git am) and again I got different hashes for these commits. S=
o in some way also the repository/branch influences the hash of a commi=
t!?

=46rom reading the Git user's manual, chapter 10, object storage format=
, I was not expecting this. Can someone explain or give a link to a mor=
e detailed description?

thank you,

Wolfgang

--=20
Computer Bild Tarifsieger! GMX FreeDSL - Telefonanschluss + DSL
f=FCr nur 17,95 Euro/mtl.!* http://dsl.gmx.de/?ac=3DOM.AD.PD003K11308T4=
569a
