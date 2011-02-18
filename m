From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 6/3] Move git-compat-util.h, strbuf.h, and cache.h to include/
Date: Thu, 17 Feb 2011 22:35:36 -0600
Message-ID: <20110218043536.GF15643@elie>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
 <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie>
 <20110218023750.GD23435@elie>
 <AANLkTi=VhJi4eDrtRPHukckQKo9TYCcnh1_u0_tnv24z@mail.gmail.com>
 <20110218042916.GC15643@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 05:35:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqI4I-0002FF-8d
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 05:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888Ab1BREfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 23:35:42 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50858 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755515Ab1BREfl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 23:35:41 -0500
Received: by iyj8 with SMTP id 8so3119065iyj.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 20:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=lPItGygHZjtYgV4RmpdlCMLp0iOKEWgkmAxTqh80d+o=;
        b=eCQ1I3UBZmN0WWM/IKurhdGYLB58qzC0jGlR9L8/XoBmoOcUZH1O7QTddmB3kWY8l6
         HFWuA5ch9/GiRCEAhPLfaEh6awg69D8v+mguk54Jt9PYn/tFRfT8QiTBH1qF9yPQbxxZ
         j5u8BUemuZR5iZXuzxZiTTY54tW2wGXJoeQZU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FORO+mN17+8E4OSM3thRBdamQ63JcHQ3kb728ftswJkEP5lSPp8s9Q5WSA2pph2oWd
         azy/FPLpwcyV03zj6REvTnk6hInGI2Klanrnkc0VsodcQN4MkvMCi03SkAFar/EC41T6
         imagNGdp9kMp95QgNc9toF0q42PXAKN0qHSng=
Received: by 10.42.217.202 with SMTP id hn10mr338944icb.168.1298003740599;
        Thu, 17 Feb 2011 20:35:40 -0800 (PST)
Received: from elie (adsl-69-209-72-148.dsl.chcgil.ameritech.net [69.209.72.148])
        by mx.google.com with ESMTPS id u9sm1342830ibe.2.2011.02.17.20.35.39
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Feb 2011 20:35:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110218042916.GC15643@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167170>

Having one directory for all core headers except a few and another
directory for the most important ones is too confusing.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile                                       |    6 +++---
 cache.h => include/cache.h                     |    0
 git-compat-util.h => include/git-compat-util.h |    0
 strbuf.h => include/strbuf.h                   |    0
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename cache.h => include/cache.h (100%)
 rename git-compat-util.h => include/git-compat-util.h (100%)
 rename strbuf.h => include/strbuf.h (100%)

diff --git a/Makefile b/Makefile
index 1e96504..9ce9ccd 100644
--- a/Makefile
+++ b/Makefile
@@ -496,7 +496,7 @@ LIB_H += include/archive.h
 LIB_H += include/attr.h
 LIB_H += include/blob.h
 LIB_H += include/builtin.h
-LIB_H += cache.h
+LIB_H += include/cache.h
 LIB_H += include/cache-tree.h
 LIB_H += include/color.h
 LIB_H += include/commit.h
@@ -515,7 +515,7 @@ LIB_H += include/diff.h
 LIB_H += include/dir.h
 LIB_H += include/exec_cmd.h
 LIB_H += include/fsck.h
-LIB_H += git-compat-util.h
+LIB_H += include/git-compat-util.h
 LIB_H += include/graph.h
 LIB_H += include/grep.h
 LIB_H += include/hash.h
@@ -548,7 +548,7 @@ LIB_H += include/run-command.h
 LIB_H += include/sha1-lookup.h
 LIB_H += include/sideband.h
 LIB_H += include/sigchain.h
-LIB_H += strbuf.h
+LIB_H += include/strbuf.h
 LIB_H += include/string-list.h
 LIB_H += include/submodule.h
 LIB_H += include/tag.h
diff --git a/cache.h b/include/cache.h
similarity index 100%
rename from cache.h
rename to include/cache.h
diff --git a/git-compat-util.h b/include/git-compat-util.h
similarity index 100%
rename from git-compat-util.h
rename to include/git-compat-util.h
diff --git a/strbuf.h b/include/strbuf.h
similarity index 100%
rename from strbuf.h
rename to include/strbuf.h
-- 
1.7.4.1
