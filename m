From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/7] Documentation: suggest `reset --merge` in How Merge
 Works section
Date: Sat, 23 Jan 2010 03:31:19 -0600
Message-ID: <20100123093118.GC7571@progeny.tock>
References: <20100123092551.GA7571@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 10:31:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYcL3-0006Jm-DP
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 10:31:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164Ab0AWJbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 04:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752731Ab0AWJbV
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 04:31:21 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:63094 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570Ab0AWJbS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 04:31:18 -0500
Received: by iwn16 with SMTP id 16so816760iwn.33
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 01:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=J5hGq0m88IJnvbXUEAvqapg8Qyk/2ckVSu+q1x5hp50=;
        b=do2RKghTftyLTCF00TjytshJdQ9t5d5xH3Uerj5vkHdFuFO0JXHnF9V8J7/8hH2o/o
         9uzahoHWdnXGLwfqGoeKiJw1pOgSeZ6HCudQhSC6xfI9FMwSShOQI2cUUco7NfoyObxm
         1PFE5vbV2lV/OgGUS/GhaZI3LdxcZ5/BwlhR0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=tCPfOjFEd6y8KyWRxDf+gJD2N53naFMJkWm8R+c+ldEkCasejs9CPOu4un3h1xyJh2
         9sBPK9E+kG4tOmpn+y1b+hv5XcIkx0eDvDENUeUkRrkK7ENiffE85OCEs/UogIsuJEue
         7RXjXKXGfDYBVYBLVz7NCSt9QSO+VvW/XLDz4=
Received: by 10.231.149.201 with SMTP id u9mr5595121ibv.1.1264239077813;
        Sat, 23 Jan 2010 01:31:17 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm2582030iwn.5.2010.01.23.01.31.16
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 01:31:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100123092551.GA7571@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137820>

The 'merge' manual suggests 'reset' to cancel a merge at the end
of the Merge Strategies list.  It is more logical to explain this
right before explaining how merge conflicts work, so the daunted
reader can have a way out when he or she needs it most.

While at it, make the advice more dependable and self-contained
by providing the --merge option.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
This should make the reference to 'git reset' easier to find on
second reading.  Something like this ought to happen if we are
going to move the Merge Strategies list down towards the end of
the man page.

 Documentation/git-merge.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 6aa2bf3..1fecedb 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -45,9 +45,6 @@ include::merge-options.txt[]
 include::merge-strategies.txt[]
 
 
-If you tried a merge which resulted in complex conflicts and
-want to start over, you can recover with 'git reset'.
-
 HOW MERGE WORKS
 ---------------
 
@@ -115,6 +112,9 @@ When there are conflicts, the following happens:
    same and the index entries for them stay as they were,
    i.e. matching `HEAD`.
 
+If you tried a merge which resulted in complex conflicts and
+want to start over, you can recover with `git reset --merge`.
+
 HOW CONFLICTS ARE PRESENTED
 ---------------------------
 
-- 
1.6.6
