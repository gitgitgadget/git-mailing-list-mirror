From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 6/9 git-gui] git-gui: chmod +x po2msg, windows/git-gui.sh
Date: Mon, 25 Nov 2013 13:01:05 -0800
Message-ID: <20131125210105.GW4212@google.com>
References: <20131125205119.GQ4212@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	Clemens Buchacher <drizzd@aon.at>,
	Marc Branchaud <marcnarc@xiplink.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 22:01:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl3HQ-0003ZQ-38
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 22:01:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873Ab3KYVBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 16:01:09 -0500
Received: from mail-yh0-f52.google.com ([209.85.213.52]:65197 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845Ab3KYVBI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 16:01:08 -0500
Received: by mail-yh0-f52.google.com with SMTP id i72so3301463yha.39
        for <git@vger.kernel.org>; Mon, 25 Nov 2013 13:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=LfM3JDdF6pzPLw500NomED0AiLgt/xUNaK7rdvwVNLI=;
        b=ooX9pMOQibTQ0VhEVNP4ww36uSG7yqv1aIXAiiyZCCLf2eJyyTvzbPvitwA+twwNO7
         gNJBlzV7OjBSogS9U7pwZu2WUIIbYq3P5I4hhLbUxBVNihSilWd5BEi3KV0ys0YQeaU5
         uWwiOvspDsg4H7vUyTl+/PJHPOJyMI1eabFAtw3Qe0oJe+BC5QtFALXVzP3ZxB9RNWrG
         4w57YaHJsk9444wb03AhyotDmn2Kg08ipwmo0DMSxnZnzxKzPzGwfYK5i+TTSF3ti6cf
         SiDmgaIN8JcCjeFZ6VIeWojJqaiYpDEjH20+EFYg7B6C7WOCZso2FV6aAtJElNTMmPs+
         14qA==
X-Received: by 10.236.188.232 with SMTP id a68mr29489249yhn.8.1385413267815;
        Mon, 25 Nov 2013 13:01:07 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id e39sm78033624yhq.15.2013.11.25.13.01.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 Nov 2013 13:01:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131125205119.GQ4212@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238354>

The Makefile only runs po/po2msg.sh using tclsh, but because the
script has the usual tcl preamble starting with #!/bin/sh it can also
be run directly.

The Windows git-gui wrapper is usable in-place for the same reason.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 po/po2msg.sh       | 0
 windows/git-gui.sh | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 po/po2msg.sh
 mode change 100644 => 100755 windows/git-gui.sh

diff --git a/po/po2msg.sh b/po/po2msg.sh
old mode 100644
new mode 100755
diff --git a/windows/git-gui.sh b/windows/git-gui.sh
old mode 100644
new mode 100755
-- 
1.8.4.1
