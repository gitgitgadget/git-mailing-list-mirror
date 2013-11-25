From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/9] mark perl test scripts executable
Date: Mon, 25 Nov 2013 12:53:54 -0800
Message-ID: <20131125205354.GS4212@google.com>
References: <20131125205119.GQ4212@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael G. Schwern" <schwern@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>,
	Marc Branchaud <marcnarc@xiplink.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 21:54:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl3AR-0008O9-D6
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 21:54:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203Ab3KYUx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 15:53:58 -0500
Received: from mail-yh0-f47.google.com ([209.85.213.47]:53742 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199Ab3KYUx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 15:53:57 -0500
Received: by mail-yh0-f47.google.com with SMTP id 29so3329933yhl.34
        for <git@vger.kernel.org>; Mon, 25 Nov 2013 12:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+2gvdmZ0670GYchFkCLbcZ7Wg3rQ9gKtcSj9bBkq88c=;
        b=lcXcKeH1XYwQSJagsSUBRR5o57ZM1pQuv0TuUnaM84/1b5LClK8oAz5u4v/M9gHFku
         ao76zhBuSZ+4/r+uLYGQvKiBpVr0WNI79udfNt0s4Pv5Oo7uI7y/7rAVSL9lRBqY2KIF
         ARDXCPkEpWkNyRVegTbQa1GP7q9Lu4ZUWfnLUsn/JU5gjhofYDRbi6u/bm4PfHs3LgSS
         JLsmZD7ymBkPdx7VpbNVNxkOshxAUwLkupRR9yBhraA1IFzGzbgYpxtrde9szdtN/32I
         I+bEnEw1mhDJTARUn7N2+sQgVS1GzyK1Uuz8vQ8ijWbjF0kO1xMtU+3HPjHGhc+AIo+W
         BF2A==
X-Received: by 10.236.207.73 with SMTP id m49mr29441675yho.5.1385412837230;
        Mon, 25 Nov 2013 12:53:57 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id h66sm20488422yhb.7.2013.11.25.12.53.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 Nov 2013 12:53:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131125205119.GQ4212@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238349>

These scripts are not run directly as part of a normal build, so no
one noticed that they did not have the +x bit.  Mark them executable
to make it more obvious that they can be run directly (when debugging,
for example).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/Git-SVN/00compile.t              | 0
 t/Git-SVN/Utils/add_path_to_url.t  | 0
 t/Git-SVN/Utils/can_compress.t     | 0
 t/Git-SVN/Utils/canonicalize_url.t | 0
 t/Git-SVN/Utils/collapse_dotdot.t  | 0
 t/Git-SVN/Utils/fatal.t            | 0
 t/Git-SVN/Utils/join_paths.t       | 0
 t/t0202/test.pl                    | 0
 t/t9150/make-svk-dump              | 0
 t/t9151/make-svnmerge-dump         | 0
 10 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 t/Git-SVN/00compile.t
 mode change 100644 => 100755 t/Git-SVN/Utils/add_path_to_url.t
 mode change 100644 => 100755 t/Git-SVN/Utils/can_compress.t
 mode change 100644 => 100755 t/Git-SVN/Utils/canonicalize_url.t
 mode change 100644 => 100755 t/Git-SVN/Utils/collapse_dotdot.t
 mode change 100644 => 100755 t/Git-SVN/Utils/fatal.t
 mode change 100644 => 100755 t/Git-SVN/Utils/join_paths.t
 mode change 100644 => 100755 t/t0202/test.pl
 mode change 100644 => 100755 t/t9150/make-svk-dump
 mode change 100644 => 100755 t/t9151/make-svnmerge-dump

diff --git a/t/Git-SVN/00compile.t b/t/Git-SVN/00compile.t
old mode 100644
new mode 100755
diff --git a/t/Git-SVN/Utils/add_path_to_url.t b/t/Git-SVN/Utils/add_path_to_url.t
old mode 100644
new mode 100755
diff --git a/t/Git-SVN/Utils/can_compress.t b/t/Git-SVN/Utils/can_compress.t
old mode 100644
new mode 100755
diff --git a/t/Git-SVN/Utils/canonicalize_url.t b/t/Git-SVN/Utils/canonicalize_url.t
old mode 100644
new mode 100755
diff --git a/t/Git-SVN/Utils/collapse_dotdot.t b/t/Git-SVN/Utils/collapse_dotdot.t
old mode 100644
new mode 100755
diff --git a/t/Git-SVN/Utils/fatal.t b/t/Git-SVN/Utils/fatal.t
old mode 100644
new mode 100755
diff --git a/t/Git-SVN/Utils/join_paths.t b/t/Git-SVN/Utils/join_paths.t
old mode 100644
new mode 100755
diff --git a/t/t0202/test.pl b/t/t0202/test.pl
old mode 100644
new mode 100755
diff --git a/t/t9150/make-svk-dump b/t/t9150/make-svk-dump
old mode 100644
new mode 100755
diff --git a/t/t9151/make-svnmerge-dump b/t/t9151/make-svnmerge-dump
old mode 100644
new mode 100755
-- 
1.8.4.1
