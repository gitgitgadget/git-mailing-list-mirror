From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] Improve --patch option documentation in git-add
Date: Sun, 13 Sep 2009 17:09:11 +0300
Organization: Private
Message-ID: <87vdjnlywo.fsf@jondo.cante.net>
References: <87ocpxb46g.fsf@jondo.cante.net>
	<7vab1hdppb.fsf@alter.siamese.dyndns.org>
	<87tyzp9da4.fsf@jondo.cante.net>
	<7vskf954sr.fsf@alter.siamese.dyndns.org>
	<87ab1gaol2.fsf@jondo.cante.net>
	<7vbplw28js.fsf@alter.siamese.dyndns.org>
	<87y6p08lz5.fsf@jondo.cante.net>
	<7vmy5fy2hz.fsf@alter.siamese.dyndns.org>
	<87ab0zny27.fsf_-_@jondo.cante.net>
	<237967ef0909130648l36b592aft9c50ccff5d03d1b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: git@vger.kernel.org
To: Mikael Magnusson <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 16:09:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmplZ-0001NS-Mv
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 16:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187AbZIMOJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 10:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754161AbZIMOJN
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 10:09:13 -0400
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:43390 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754158AbZIMOJM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 10:09:12 -0400
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id 8F9EEC7B57;
	Sun, 13 Sep 2009 17:09:14 +0300 (EEST)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A07A778A11B; Sun, 13 Sep 2009 17:09:14 +0300
Received: from jondo.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id 1E3BA27D85;
	Sun, 13 Sep 2009 17:09:11 +0300 (EEST)
In-Reply-To: <237967ef0909130648l36b592aft9c50ccff5d03d1b1@mail.gmail.com>
	(Mikael Magnusson's message of "Sun, 13 Sep 2009 15:48:40 +0200")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128363>

--=-=-=

Mikael Magnusson <mikachu@gmail.com> writes:
>> +       Interactively choose hunks of patch between the index and the
> diff probably makes more sense than patch here
>
>> +       work tree and add them to the index. This gives a change to
> a chance
>
>> +       review the difference before adding modified contents to the
> differences? Not sure which I prefer on this one.
>
>> +       index.
>> +
>> +       This effectively runs ``add --interactive``, but bypass the
> bypasses
>
>> +       initial command menu and directly jump to `patch` subcommand.
> jumps

An update. Thanks,
Jari


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline;
 filename=0001-Improve-patch-option-documentation-in-git-add.patch

>From beca0d3dcd668e1b578588378149320cd3aed9d9 Mon Sep 17 00:00:00 2001
From: Jari Aalto <jari.aalto@cante.net>
Date: Sun, 13 Sep 2009 17:08:51 +0300
Subject: [PATCH] Improve --patch option documentation in git-add

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-add.txt |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index e67b7e8..0b2a2a6 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -72,9 +72,14 @@ OPTIONS
 
 -p::
 --patch::
-	Similar to Interactive mode but the initial command loop is
-	bypassed and the 'patch' subcommand is invoked using each of
-	the specified filepatterns before exiting.
+	Interactively choose hunks of diff between the index and the
+	work tree and add them to the index. This gives a change to
+	review the differences before adding modified contents to the
+	index.
+
+	This effectively runs ``add --interactive``, but bypass the
+	initial command menu and directly jumps to `patch` subcommand.
+	See ``Interactive mode'' for details.
 
 -e, \--edit::
 	Open the diff vs. the index in an editor and let the user
-- 
1.6.3.3


--=-=-=--
