From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Documentation: clarify interaction of --reset-author with
 --author
Date: Tue, 15 Feb 2011 18:05:53 -0600
Message-ID: <20110216000553.GB18151@elie>
References: <1297805034-3512-1-git-send-email-jaysoffian@gmail.com>
 <1297805034-3512-3-git-send-email-jaysoffian@gmail.com>
 <20110215230015.GA17812@elie>
 <AANLkTinZ0ewJy01rV66xMMCKLon=7qz=hoJ3DbtXmtXL@mail.gmail.com>
 <20110215234735.GA18151@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 01:06:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpUuY-0006rU-Ef
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 01:06:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755472Ab1BPAGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 19:06:22 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:48981 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406Ab1BPAGU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 19:06:20 -0500
Received: by qwa26 with SMTP id 26so626794qwa.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 16:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=zxscpm0eDkpA5zWmeiaL9y9UNHvYmj5TAfg4ccVMPYA=;
        b=DkopvTfBPULlf3IDyWaNqwshV00n2qpMTl3kJTMF1hVOWm27biQy3gqUpJz/uUXeGo
         oEZ1ptxqH/Nf24Zc5yYlQM4anDg8wx+pMwGorbVpoVJTCcoZwgcfyH5tdbSWtPRgf014
         vHPSXQk7gHVELL7oHMk9mFVix4vMAwlCw5EYE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Hvb0oqMi8iIsV8fhEC9kWmAQwbQReDGSQJ0IbArEXiYLDiBU/m8QxITBatxBbJGbls
         omb0F+jYhjTclzqaiSgjDYpDWScMn79XDZkrvi/NqTl9E2pzFD8Kdtin8B3NmFgjDR8d
         /Z05e54P8pWt0SWf/nxVcCuhOMHJf416+HYpQ=
Received: by 10.224.80.208 with SMTP id u16mr15406qak.196.1297814758947;
        Tue, 15 Feb 2011 16:05:58 -0800 (PST)
Received: from elie (adsl-69-209-51-217.dsl.chcgil.sbcglobal.net [69.209.51.217])
        by mx.google.com with ESMTPS id e20sm22520vbz.18.2011.02.15.16.05.57
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Feb 2011 16:05:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110215234735.GA18151@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166907>

The --author and --date options override the author and date from
--reset-author.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jonathan Nieder wrote:

> Patch below.

Sane?

 Documentation/git-commit.txt |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index b586c0f..f766d53 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -84,9 +84,12 @@ OPTIONS
 	linkgit:git-rebase[1] for details.
 
 --reset-author::
-	When used with -C/-c/--amend options, declare that the
-	authorship of the resulting commit now belongs of the committer.
+	Despite use of the -c, -C, or --amend option, declare that the
+	authorship of the new commit belongs to the committer.
 	This also renews the author timestamp.
++
+Can be combined with `--author` or `--date` to claim authorship using
+some specific name and email address or date.
 
 --short::
 	When doing a dry-run, give the output in the short-format. See
-- 
1.7.4.1
