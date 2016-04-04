From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] doc: Clarify which objects notes can be attached to
Date: Mon, 4 Apr 2016 10:37:46 +0200
Message-ID: <570227DA.6040808@gmail.com>
References: <56FE48C6.9050306@gmail.com>
 <xmqqy48xjqg5.fsf@gitster.mtv.corp.google.com>
 <xmqq8u0xjmxh.fsf@gitster.mtv.corp.google.com>
 <CAHGBnuP71qpOoNAAwXE-nbPbVyK56Up0YpmhhjC5430VwW73kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 10:37:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1an01B-0004zX-Pq
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 10:37:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753786AbcDDIhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 04:37:50 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:36480 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbcDDIht (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 04:37:49 -0400
Received: by mail-lb0-f179.google.com with SMTP id qe11so149410962lbc.3
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 01:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=/Fbqe4Nlez4MMB2hxTLuVhWS2luilIg3unOxojX0U1U=;
        b=pNKdep2OlSNSIx19fYihsqcO6pPvVHAGHivkmntXyhRanaInv2R37RFJtVLMBInwvP
         eoapR9UNNU5XGJZrFZl59OEIznJWH7nICbeiv63NYSb8LR4qqohpIWZL/r2tH+KQkMwT
         oh33PMBuW1IvSiSTJ8DPB2cpBDMGjTHX1HNsJY6xMuFw7vW0LZLukIl9fYyGGMLwE4v8
         eGGl6Hfq5dL7WqOOwGCoYJW50q4P+L3yNGh+7xNYnFlvuvD6ZoyfPMdwqEKUt4uGqrRx
         60ClBCLqZOgobVeJeudidF8r5CTviwFOImogzoasqe+9ADwAt1OvowBXm+ZKYbESz/yO
         WS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=/Fbqe4Nlez4MMB2hxTLuVhWS2luilIg3unOxojX0U1U=;
        b=GEF1U9yFVFfqwRd58x7JFpV3lzZvbk/Q0aPDJwfLM1X1XRfLw9lJASWTvjUZrnge0r
         n1V/g9yt/ND809KybRRfAHoiSZ+rSzPlT8SOAL6MMJdwhDBiDQzDwMsJz2hIGUMwafn/
         idBYbdXbaasXBpJaXYQ+5hWPF0YxLTRUGmeYMBXTyUoSZ43S9EKYjZMnZ4YPyJqqcizK
         s2QMgZJt8YDQTA53vasv/xZCO4lZGQHinEZ0mUTpCsAEovDVNiAY+15WL2Uc9ZrIxEJc
         7eFjIxc0ee4j1p+jRLDwWG5ukLDgLlgdHfmsiMvfie4W+UU+vxLP5w0rpSda1psHjCEO
         dqzg==
X-Gm-Message-State: AD7BkJJ4CexuwF8j114D7QH++PgqjGVGceMB61FR+N3mSF6yqfS74dg+XUlLS4QEuCoEbQ==
X-Received: by 10.28.130.67 with SMTP id e64mr10747128wmd.6.1459759067922;
        Mon, 04 Apr 2016 01:37:47 -0700 (PDT)
Received: from [10.223.62.205] ([131.228.216.133])
        by smtp.googlemail.com with ESMTPSA id w8sm27800607wjf.19.2016.04.04.01.37.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 04 Apr 2016 01:37:47 -0700 (PDT)
Newsgroups: gmane.comp.version-control.git
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <CAHGBnuP71qpOoNAAwXE-nbPbVyK56Up0YpmhhjC5430VwW73kQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290686>

Explicitly name the supported object types, and ensure patches cannot be
misinterpreted as non-objects that can have notes attached.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 Documentation/git-notes.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 8de3499..101e6ba 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -25,7 +25,8 @@ SYNOPSIS
 DESCRIPTION
 -----------
 Adds, removes, or reads notes attached to objects, without touching
-the objects themselves.
+the objects themselves.  Supported objects are commits, blobs, trees
+and annotated tags.
 
 By default, notes are saved to and read from `refs/notes/commits`, but
 this default can be overridden.  See the OPTIONS, CONFIGURATION, and
@@ -39,9 +40,9 @@ message stored in the commit object, the notes are indented like the
 message, after an unindented line saying "Notes (<refname>):" (or
 "Notes:" for `refs/notes/commits`).
 
-Notes can also be added to patches prepared with `git format-patch` by
-using the `--notes` option. Such notes are added as a patch commentary
-after a three dash separator line.
+Notes contents can also be included in patches prepared with
+`git format-patch` by using the `--notes` option. Such notes are added
+as a patch commentary after a three dash separator line.
 
 To change which notes are shown by 'git log', see the
 "notes.displayRef" configuration in linkgit:git-log[1].
-- 
2.8.0.windows.1
