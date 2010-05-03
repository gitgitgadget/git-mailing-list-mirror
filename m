From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/4] Documentation/notes: describe content of notes
Date: Mon, 3 May 2010 18:42:29 -0500
Message-ID: <20100503234229.GC27483@progeny.tock>
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
	id 1O95HT-000405-S3
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 01:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208Ab0ECXmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 19:42:20 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:49790 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932192Ab0ECXmR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 19:42:17 -0400
Received: by gwj19 with SMTP id 19so1467168gwj.19
        for <git@vger.kernel.org>; Mon, 03 May 2010 16:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=XzpBq5KlB26zQm1cRpFVxKkqlgnmgIgFpxXWINTqPOc=;
        b=Ezfd+11kaVYmbYzznycyciREJgxpz9HDE3euSrDHmFyX9jPdG4p3iLhOhYT3bidnFR
         eH7uFpG4Vl6JizIj0EfQ8ueivqgadcocf+sONsQ2Rmdr15pUf0YlH1usAu1c+STcxgG/
         vyMmW/RQEvxBSxZJa4cLpA/mKNUI8+Sdwjvvw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EL0n4I7njkaDOpQrfJCIH4Km2o9RSg6D7xB5gvGlAwo6YuCRIwaIwa7IaIGC2E45s4
         oAnizL3pjqox9cW80/rLNvlA+NHg39DVawG7jmBgZoqmu8itCn5Cd8mtlUrTnSpUC4Ft
         jNwfz7fq5b7efvFAkvqKkl2s/dX0xXpDs9vPk=
Received: by 10.90.5.34 with SMTP id 34mr2439740age.65.1272930136497;
        Mon, 03 May 2010 16:42:16 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm4711431iwn.11.2010.05.03.16.42.15
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 03 May 2010 16:42:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100503233604.GA27451@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146271>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-notes.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 0594776..273264b 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -27,6 +27,10 @@ By default, notes are saved to and read from `refs/notes/commits`, but
 this default can be overridden.  See the CONFIGURATION and ENVIRONMENT
 sections below.
 
+Notes can contain any sequence of non-null bytes.  Since they are
+sanitized with linkgit:git-stripspace[1], empty lines other than a
+single line separating paragraphs are not significant.
+
 A typical use of notes is to extend a commit message without having
 to change the commit itself. Such commit notes can be shown by `git log`
 along with the original commit message. To discern these notes from the
-- 
1.7.1
