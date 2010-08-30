From: Knut Franke <k.franke@science-computing.de>
Subject: Re: [PATCHv2 3/3] Extend documentation of core.askpass and GIT_ASKPASS.
Date: Mon, 30 Aug 2010 15:40:29 +0200
Organization: science + computing ag
Message-ID: <201008301540.30323.k.franke@science-computing.de>
References: <201008301536.20414.k.franke@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 30 15:40:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq4bI-0007y4-2l
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 15:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843Ab0H3Nkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 09:40:33 -0400
Received: from smtp2.belwue.de ([129.143.2.15]:47096 "EHLO smtp2.belwue.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753742Ab0H3Nkd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Aug 2010 09:40:33 -0400
Received: from mx4.science-computing.de (mx4.science-computing.de [193.197.16.30])
	by smtp2.belwue.de with ESMTP id o7UDeVHs013323
	for <git@vger.kernel.org>; Mon, 30 Aug 2010 15:40:31 +0200 (MEST)
	env-from (prvs=851ee50e4=k.franke@science-computing.de)
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id 738DEAC00A;
	Mon, 30 Aug 2010 15:40:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (guinesstest.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1cBJBnpVy9we; Mon, 30 Aug 2010 15:40:30 +0200 (CEST)
Received: from sirmione.science-computing.de (sirmione.science-computing.de [10.10.24.2])
	by scmail.science-computing.de (Postfix) with ESMTP id DA706AC001;
	Mon, 30 Aug 2010 15:40:30 +0200 (CEST)
Received: from sirmione.localnet (localhost [127.0.0.1])
	by sirmione.science-computing.de (Postfix) with ESMTP id CB72AAE3C9;
	Mon, 30 Aug 2010 15:40:30 +0200 (CEST)
User-Agent: KMail/1.10.3 (Linux/2.6.27.29-0.1-pae; KDE/4.1.3; i686; ; )
In-Reply-To: <201008301536.20414.k.franke@science-computing.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154800>

Signed-off-by: Knut Franke <k.franke@science-computing.de>
---
 Documentation/config.txt |    7 +++++--
 Documentation/git.txt    |    7 +++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 38678db..80bc815 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -453,8 +453,11 @@ core.excludesfile::
 core.askpass::
 	Some commands (e.g. svn and http interfaces) that interactively
 	ask for a password can be told to use an external program given
-	via the value of this variable when it is set, and the
-	environment variable `GIT_ASKPASS` is not set.
+	via the value of this variable. Can be overridden by the 'GIT_ASKPASS'
+	environment variable. If not set, fall back to the value of the
+	'SSH_ASKPASS' environment variable or, failing that, a simple password
+	prompt. The external program shall be given a suitable prompt as
+	command line argument and write the password on its STDOUT.
 
 core.editor::
 	Commands such as `commit` and `tag` that lets you edit
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 5317893..1879746 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -638,6 +638,13 @@ Usually it is easier to configure any desired options through your
 personal `.ssh/config` file.  Please consult your ssh documentation
 for further details.
 
+'GIT_ASKPASS'::
+	If this environment variable is set, then git commands which need to
+	acquire passwords or passphrases (e.g. for HTTP or IMAP authentication)
+	will call this program with a suitable prompt as command line argument
+	and read the password from its STDOUT. See also the 'core.askpass'
+	option in linkgit:git-config[1].
+
 'GIT_FLUSH'::
 	If this environment variable is set to "1", then commands such
 	as 'git blame' (in incremental mode), 'git rev-list', 'git log',
-- 
1.7.2.1

-- 
Vorstand/Board of Management:
Dr. Bernd Finkbeiner, Dr. Roland Niemeier, 
Dr. Arno Steitz, Dr. Ingrid Zech
Vorsitzender des Aufsichtsrats/
Chairman of the Supervisory Board:
Michel Lepert
Sitz/Registered Office: Tuebingen
Registergericht/Registration Court: Stuttgart
Registernummer/Commercial Register No.: HRB 382196 
