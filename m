From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 17/24] t9300 (fast-import), series K: re-indent
Date: Fri, 24 Sep 2010 02:25:03 -0500
Message-ID: <20100924072503.GR4666@burratino>
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
X-From: git-owner@vger.kernel.org Fri Sep 24 09:27:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz2hJ-0002sA-UP
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 09:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754064Ab0IXH1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 03:27:52 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39870 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753178Ab0IXH1w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 03:27:52 -0400
Received: by gyd8 with SMTP id 8so869142gyd.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 00:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=IWs9/46ZxIy1J0eSsXLEUDONZkh1XbScldYP7qsW7ds=;
        b=MEcGv0oXNhJ0EvOK0ZD1nUceLgtIytr88lzJaVGfI7ZNGDzfKof6Lu+XirZLJHN70L
         aI6QpQSz/AfpSlzgXfwe8ipXzDO7dNmSboOvD8g0DieWrg3WsrPoaKRamV9wsxiVqLQj
         Wd6+Pey8nDzijeDEIfbnTDFDFcZaNr0XASEtg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=f5QPC8px/3PrZsYzk4AQHCD5cJ+R/AIOA4kyF7aveMw4749ItKKghHNANTejpTzKpi
         xBTiuYxkbkiKM29lx3xi5wAwT3fkVXeM+GkaswnHEgGbMxI0KE4oLqRmhjxUL0q3tWmJ
         K87v7d6pF4ZwmFZuGjgQORGH2487vdo1OTVx4=
Received: by 10.100.196.9 with SMTP id t9mr3056724anf.109.1285313271213;
        Fri, 24 Sep 2010 00:27:51 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id c7sm2867265ana.38.2010.09.24.00.27.49
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 00:27:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100924065900.GA4666@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156952>

See "t9300 (fast-import), series A: re-indent".

Cc: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9300-fast-import.sh |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 2a2f969..82647f8 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -677,13 +677,13 @@ COMMIT
 from refs/heads/branch^1
 
 INPUT_END
-test_expect_success \
-	'K: reinit branch with from' \
-	'git fast-import <input'
-test_expect_success \
-	'K: verify K^1 = branch^1' \
-	'test `git rev-parse --verify branch^1` \
-	    = `git rev-parse --verify K^1`'
+test_expect_success 'K: reinit branch with from' '
+	git fast-import <input
+'
+test_expect_success 'K: verify K^1 = branch^1' '
+	test `git rev-parse --verify branch^1` \
+	   = `git rev-parse --verify K^1`
+'
 
 ###
 ### series L
-- 
1.7.2.3
