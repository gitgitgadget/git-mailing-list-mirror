From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/4] Documentation/notes: adjust description to use
 configuration section
Date: Mon, 3 May 2010 18:42:09 -0500
Message-ID: <20100503234209.GB27483@progeny.tock>
References: <20100503233604.GA27451@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Johan Herland <johan@herland.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 04 01:42:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O95HS-000405-QL
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 01:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759980Ab0ECXmB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 19:42:01 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:48530 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759972Ab0ECXl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 19:41:59 -0400
Received: by mail-yw0-f198.google.com with SMTP id 36so1477280ywh.4
        for <git@vger.kernel.org>; Mon, 03 May 2010 16:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=y8UPAzvksMyC7ufE3fH09W8uez0bCtXxpggNw1RsxeY=;
        b=IxAOuDrGcbUki4Whg+DaHEOnL79oXwvnv8LEOPl6EB+d058cu43xIr+zt8vFLdCkoc
         cPVYWZidRCF5h5uuPRKXrdOIRMP0k7WK2xRgAomxQTwaC4WBEbCsiEOr2klKJCiqZqh6
         ygmG+cbIMfbfvooFB7UmbWlSoYtRrd1w1bHew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=E1e98IYaivGG+nZ40HxiIxG01fXd6wqKOxDZ8pv9Y1IPotqldcsiBwgXlj6EoBWJ+Q
         H0Bq/nPxetnyJWK/chC4h6oquDE5Tnnodoaul6JvguRcAcE01G5KRJd3/7SL5qdTPKc3
         uUlkDHtlw8WQ7TLWWfngloMXRA6t+Ave6FyZE=
Received: by 10.151.24.5 with SMTP id b5mr9146485ybj.79.1272930116233;
        Mon, 03 May 2010 16:41:56 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm4733539iwn.2.2010.05.03.16.41.54
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 03 May 2010 16:41:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100503233604.GA27451@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146272>

Introduce the default notes ref early on to give the reader a frame of
reference for understanding the rest of the description.

Cc: Johan Herland <johan@herland.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-notes.txt |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index b26598e..0594776 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -23,6 +23,10 @@ DESCRIPTION
 This command allows you to add/remove notes to/from objects, without
 changing the objects themselves.
 
+By default, notes are saved to and read from `refs/notes/commits`, but
+this default can be overridden.  See the CONFIGURATION and ENVIRONMENT
+sections below.
+
 A typical use of notes is to extend a commit message without having
 to change the commit itself. Such commit notes can be shown by `git log`
 along with the original commit message. To discern these notes from the
@@ -30,14 +34,8 @@ message stored in the commit object, the notes are indented like the
 message, after an unindented line saying "Notes (<refname>):" (or
 "Notes:" for the default setting).
 
-This command always manipulates the notes specified in "core.notesRef"
-(see linkgit:git-config[1]), which can be overridden by GIT_NOTES_REF.
-To change which notes are shown by 'git-log', see the
-"notes.displayRef" configuration.
-
-See the description of "notes.rewrite.<command>" in
-linkgit:git-config[1] for a way of carrying your notes across commands
-that rewrite commits.
+See the "notes.rewrite.<command>" configuration for a way of carrying
+notes across commands that rewrite commits.
 
 
 SUBCOMMANDS
-- 
1.7.1
