From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 22/24] t9300 (fast-import), series P: re-indent
Date: Fri, 24 Sep 2010 02:27:36 -0500
Message-ID: <20100924072736.GW4666@burratino>
References: <20100701031819.GA12524@burratino>
 <20100701054849.GA14972@burratino>
 <20100817170216.GA14491@kytes>
 <20100905031528.GA2344@burratino>
 <20100905032253.GB2344@burratino>
 <20100924065900.GA4666@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 09:32:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz2lF-0004bV-5R
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 09:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755091Ab0IXHa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 03:30:26 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39589 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754439Ab0IXHaY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 03:30:24 -0400
Received: by mail-iw0-f174.google.com with SMTP id 5so2167278iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 00:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=3SLSWBBlIC5lCfm1NmmWjntjoK/NRsrAL7dj/hL4o4I=;
        b=USNbA/b/vkyviTxcCQ2gDsKydgNh7YPKBCwYHUrWGkfTKVkGUBlSGeeE+7YRhAeSgX
         7q0jSD3Ine63RVTZ9e63AIelWPT5ekr0dnQYApSvyngv25bPZVSBqBTEaw/BMufjBQP9
         quzZQsqiO49q1iZaOCq9d/6hRfy7IGk0jHVQI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pobKI9bmIj/ItZbvEjuhOttAF5GZO8GC87xBRyrRiLbTD0OvropSly3n7NoNsKfeZ/
         Uzf5arL1UP1BMhewTbL5afkPPiPllK4eqtW3VVBbs2nNj/eq3AeCXNK+nbKCsCCIXeUK
         /Ww2e+B80sVOk7uWcTXVQpOKO4ybfzBl4VTbk=
Received: by 10.231.146.134 with SMTP id h6mr3369826ibv.170.1285313422481;
        Fri, 24 Sep 2010 00:30:22 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r3sm1968990ibk.13.2010.09.24.00.30.21
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 00:30:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100924065900.GA4666@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156958>

See "t9300 (fast-import), series A: re-indent".

Cc: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9300-fast-import.sh |   38 ++++++++++++++++++++------------------
 1 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 04e4f6d..ef432e7 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1162,16 +1162,16 @@ M 160000 :6 sub
 
 INPUT_END
 
-test_expect_success \
-	'P: supermodule & submodule mix' \
-	'git fast-import <input &&
-	 git checkout subuse1 &&
-	 rm -rf sub && mkdir sub && (cd sub &&
-	 git init &&
-	 git fetch --update-head-ok .. refs/heads/sub:refs/heads/master &&
-	 git checkout master) &&
-	 git submodule init &&
-	 git submodule update'
+test_expect_success 'P: supermodule & submodule mix' '
+	git fast-import <input &&
+	git checkout subuse1 &&
+	rm -rf sub && mkdir sub && (cd sub &&
+	git init &&
+	git fetch --update-head-ok .. refs/heads/sub:refs/heads/master &&
+	git checkout master) &&
+	git submodule init &&
+	git submodule update
+'
 
 SUBLAST=$(git rev-parse --verify sub)
 SUBPREV=$(git rev-parse --verify sub^)
@@ -1204,12 +1204,12 @@ M 160000 $SUBLAST sub
 
 INPUT_END
 
-test_expect_success \
-	'P: verbatim SHA gitlinks' \
-	'git branch -D sub &&
-	 git gc && git prune &&
-	 git fast-import <input &&
-	 test $(git rev-parse --verify subuse2) = $(git rev-parse --verify subuse1)'
+test_expect_success 'P: verbatim SHA gitlinks' '
+	git branch -D sub &&
+	git gc && git prune &&
+	git fast-import <input &&
+	test $(git rev-parse --verify subuse2) = $(git rev-parse --verify subuse1)
+'
 
 test_tick
 cat >input <<INPUT_END
@@ -1229,7 +1229,8 @@ DATA
 INPUT_END
 
 test_expect_success 'P: fail on inline gitlink' '
-	test_must_fail git fast-import <input'
+	test_must_fail git fast-import <input
+'
 
 test_tick
 cat >input <<INPUT_END
@@ -1252,7 +1253,8 @@ M 160000 :1 sub
 INPUT_END
 
 test_expect_success 'P: fail on blob mark in gitlink' '
-	test_must_fail git fast-import <input'
+	test_must_fail git fast-import <input
+'
 
 ###
 ### series Q (notes)
-- 
1.7.2.3
