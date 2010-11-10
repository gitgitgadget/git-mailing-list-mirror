From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] Documentation: split gitignore page into sections
Date: Wed, 10 Nov 2010 12:57:39 -0600
Message-ID: <20101110185739.GB12365@burratino>
References: <1289387440-8509-1-git-send-email-sitaram@atc.tcs.com>
 <20101110185555.GA12365@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sitaram Chamarty <sitaram@atc.tcs.com>
X-From: git-owner@vger.kernel.org Wed Nov 10 19:58:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGFrz-0004xF-S0
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 19:58:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755758Ab0KJS6B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 13:58:01 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:64926 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753608Ab0KJS6A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 13:58:00 -0500
Received: by pxi15 with SMTP id 15so235267pxi.19
        for <git@vger.kernel.org>; Wed, 10 Nov 2010 10:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=pnGLJlNUVu7Wy5wqOXWFWUw0DulgsxQ/QfotDkAamXw=;
        b=x5P9iL87sKEKlJEQGHNLnghO/Jt2yB+Rztak0ZrI7A0sFmocJhVVm88oXR6bafoz3o
         jhP5pUGXHaDJGuuvtkYROkPzUT0f4Pty+CfALpVvV0zkp9CC3nYf3XG/oLs+ASFr/G5e
         I4gUh9XNzwV0tsTvj7tw3k1BXTPgZ5EqPdIso=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=K+nNE3i1l2Tm1yukex+7yMJWzgXORaab7yeuE45WuqSSxrrdiEdmWVCS3YsjUcvqX9
         Kz/DcrvOOvD9k5U6D/vTOB8mNhAyovz9J9DpcnrR1NXF/MpVFZPtZbmPg8bhp0NWiDn2
         9sGr6JPngQHEdo0Std6hrTxjWAHUiU5SXkk+w=
Received: by 10.142.237.17 with SMTP id k17mr7307800wfh.416.1289415479865;
        Wed, 10 Nov 2010 10:57:59 -0800 (PST)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id y14sm284927vch.28.2010.11.10.10.57.58
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 10 Nov 2010 10:57:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101110185555.GA12365@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161171>

A learner-by-example might want to look at the examples section first.
Help her out by supplying some section headings: PATTERN FORMAT for
the format of lines in an excludes file and EXAMPLES for the two
examples.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/gitignore.txt |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 7dc2e8b..254bc1a 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -62,7 +62,8 @@ files specified by command-line options.  Higher-level git
 tools, such as 'git status' and 'git add',
 use patterns from the sources specified above.
 
-Patterns have the following format:
+PATTERN FORMAT
+--------------
 
  - A blank line matches no files, so it can serve as a separator
    for readability.
@@ -98,7 +99,8 @@ Patterns have the following format:
    For example, "/{asterisk}.c" matches "cat-file.c" but not
    "mozilla-sha1/sha1.c".
 
-An example:
+EXAMPLES
+--------
 
 --------------------------------------------------------------
     $ git status
-- 
1.7.2.3.557.gab647.dirty
