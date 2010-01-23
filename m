From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/7] Documentation: merge: move configuration section to end
Date: Sat, 23 Jan 2010 03:26:57 -0600
Message-ID: <20100123092657.GB7571@progeny.tock>
References: <20100123092551.GA7571@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 10:27:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYcGj-00044C-OE
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 10:27:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753687Ab0AWJ06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 04:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753664Ab0AWJ05
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 04:26:57 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:55790 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625Ab0AWJ04 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 04:26:56 -0500
Received: by iwn16 with SMTP id 16so815393iwn.33
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 01:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=0gQoSjUpE8l6I5qAwM5bC9WmwtAf3PvtH/2pR+gQwRI=;
        b=eWMVI2+9RYcWIu+vVu+EoGid0LF9JlB1QbAsXSuHHE5BsTmxoV80/gOf8qUYqOJFXJ
         vtHH0o4K9CEqg2DPkGbk0xOzJaFC80WNYO916BcNsYpFjX8tpPVTaclym/hgwVLHifbI
         OQphhSQo289eP6I9VcauzB+vWWa3pgvpp1xXs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VumfGEXbEBu/s1vjvlzZ0l9pdEb9pcB4S01HJ+4tVLd5boDFKuX7Ul3uCFq/4HC4BV
         KCxnq61Fi4asmKHAkTvqxWJJ9XFPrdu1dHTdKdXHE7ZUYL1tvmNwfBAfTIjeCBTTwaAT
         5UKboRa/ijTVMShxCRSNV1qA2k8kMT07Ltba0=
Received: by 10.231.161.143 with SMTP id r15mr362957ibx.62.1264238816150;
        Sat, 23 Jan 2010 01:26:56 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm2418856iwn.14.2010.01.23.01.26.55
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 01:26:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100123092551.GA7571@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137819>

Configuration and environment variables belong to the back matter
of a manual page.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Acked-by: Petr Baudis <pasky@suse.cz>
---
 Documentation/git-merge.txt |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index c88bebe..6aa2bf3 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -48,15 +48,6 @@ include::merge-strategies.txt[]
 If you tried a merge which resulted in complex conflicts and
 want to start over, you can recover with 'git reset'.
 
-CONFIGURATION
--------------
-include::merge-config.txt[]
-
-branch.<name>.mergeoptions::
-	Sets default options for merging into branch <name>. The syntax and
-	supported options are the same as those of 'git merge', but option
-	values containing whitespace characters are currently not supported.
-
 HOW MERGE WORKS
 ---------------
 
@@ -249,6 +240,15 @@ changes into a merge commit.  Small fixups like bumping
 release/version name would be acceptable.
 
 
+CONFIGURATION
+-------------
+include::merge-config.txt[]
+
+branch.<name>.mergeoptions::
+	Sets default options for merging into branch <name>. The syntax and
+	supported options are the same as those of 'git merge', but option
+	values containing whitespace characters are currently not supported.
+
 SEE ALSO
 --------
 linkgit:git-fmt-merge-msg[1], linkgit:git-pull[1],
-- 
1.6.6
