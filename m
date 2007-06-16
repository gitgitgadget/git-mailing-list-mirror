From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 03/11] Document git log --abbrev-commit, as a kind of pretty option
Date: Sat, 16 Jun 2007 21:03:39 +0200
Message-ID: <11820206321696-git-send-email-jnareb@gmail.com>
References: <11820206272990-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 16 20:58:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzdU1-0007JN-Iy
	for gcvg-git@gmane.org; Sat, 16 Jun 2007 20:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367AbXFPS6R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 14:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753967AbXFPS6Q
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 14:58:16 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:13023 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863AbXFPS6M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 14:58:12 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1608082mue
        for <git@vger.kernel.org>; Sat, 16 Jun 2007 11:58:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=m7amihZq7Rcauiqoflq/lgKGmAB8ZZKrBzwG4HccAtcPFZTL892orPiAByIJ9lim80a62KzKeH1AFpLS3TLp6uvJRXl5VloZkG3KDUx7E/vbyS+MqEjvXvo2EEKYd9n8wtYWHcBxucqU6g5tW52nNL+WAcDke1BCwgg4Ig0mxZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KdGiayR6PD45Hh8w/C+MKy8tM/DJO78WNZNFna5YJvP30/lhb4w9Ga/I61B7CPooRGBHr+pdjjd1LWdaYsnJ5wVyQFAISTMNhBK2IkPujl6mWy5Qj4NjWb2DyxIvyazbM4KGlf92OHpvgRjLd8ovpMeOlbiLCSNE3rc01oLL9UE=
Received: by 10.82.112.16 with SMTP id k16mr8151033buc.1182020291395;
        Sat, 16 Jun 2007 11:58:11 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id h6sm1875634nfh.2007.06.16.11.58.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Jun 2007 11:58:10 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l5GJ3qt6004234;
	Sat, 16 Jun 2007 21:03:53 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l5GJ3q7L004233;
	Sat, 16 Jun 2007 21:03:52 +0200
X-Mailer: git-send-email 1.5.2
In-Reply-To: <11820206272990-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50295>

Documentation taken from paraphrased description of "--abbrev[=<n>]"
diff option, and from description of commit 5c51c985 introducing
this option.

Note that to change number of digits one must use "--abbrev=<n>",
which affects [also] diff output.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 Documentation/pretty-options.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 6338def..746bc5b 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -5,6 +5,15 @@
 	'full', 'fuller', 'email', 'raw' and 'format:<string>'.
 	When left out the format default to 'medium'.
 
+--abbrev-commit::
+	Instead of showing the full 40-byte hexadecimal commit object
+	name, show only handful hexdigits prefix.  Non default number of
+	digits can be specified with "--abbrev=<n>" (which also modifies
+	diff output, if it is displayed).
++
+This should make "--pretty=oneline" a whole lot more readable for
+people using 80-column terminals.
+
 --encoding[=<encoding>]::
 	The commit objects record the encoding used for the log message
 	in their encoding header; this option can be used to tell the
-- 
1.5.2
