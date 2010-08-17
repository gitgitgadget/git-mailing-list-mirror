From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 08/24] Documentation: add a SEE ALSO section for merge-base
Date: Tue, 17 Aug 2010 01:59:55 -0500
Message-ID: <20100817065955.GH22057@burratino>
References: <20100817065147.GA18293@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, Tay Ray Chuan <rctay89@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 09:01:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlGB0-0007j1-BC
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 09:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756885Ab0HQHBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 03:01:31 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64835 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756649Ab0HQHBa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 03:01:30 -0400
Received: by yxg6 with SMTP id 6so2284300yxg.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 00:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Yd/ypl1y+LUX0DPnbfi89vzuGmQEPpAAo6kz/4xRJXs=;
        b=nz8E2R22d15B3VT/WK5h5GfiVcb5CnV9ertnHEp7JGJag1XWid+PXCNAPNKGL6k9a+
         WklDXc0YZbMMfQTFmF9qywjrSnBMVphxs0dYR6HLfNFr8YUbR56xRwL7q8/FdVXZ8kHG
         f6haWuEvbYYj33/cUbk667PHOE0B192XGJ4yA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=f1s9wrBUILWvPmRxz2qdGXCfxCp1KUW19fNqIx5WEFFdoT+abw9VIY5bKSb6bnOyxh
         pVPYEmOS636Sohi3kNAZmUPhV6zeXg+AjLTy/P1Ozprv0vw9ZEO84UQboli3wzyOET5L
         VIa8E+we7WSlNJ/BWsacqbfkQTP+b+rfT7qY4=
Received: by 10.101.183.16 with SMTP id k16mr7047630anp.120.1282028490135;
        Tue, 17 Aug 2010 00:01:30 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id p12sm11754167ane.14.2010.08.17.00.01.29
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 00:01:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100817065147.GA18293@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153711>

For example, a person reading the merge-base man page might wonder
about the fastest way to check if one commit is an ancestor of
another (which would require rev-list).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-merge-base.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index ce5b369..09b34b0 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -96,6 +96,12 @@ Documentation
 --------------
 Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+See also
+--------
+linkgit:git-rev-list[1],
+linkgit:git-show-branch[1],
+linkgit:git-merge[1]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
1.7.2.1.544.ga752d.dirty
