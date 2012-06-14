From: Luka Perkov <lists@lukaperkov.net>
Subject: git-http-fetch: remove unused cmd_http_fetch
Date: Thu, 14 Jun 2012 22:20:52 +0200
Message-ID: <20120614202052.GA3592@w500.iskon.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 14 22:20:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfGXK-0007fG-LW
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 22:20:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756334Ab2FNUUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 16:20:54 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:63090 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756277Ab2FNUUx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 16:20:53 -0400
Received: by wgbdr13 with SMTP id dr13so2316044wgb.1
        for <git@vger.kernel.org>; Thu, 14 Jun 2012 13:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent:x-gm-message-state;
        bh=rqJdRtVaEdFBm4LsWTTWe/FEqzPKYQAfbrnlw+mbJgY=;
        b=apDYF52ITJuI5w0pKiY8DehZ7lHStjbqRJ2C+Fk/q64fj6GnkvfSo0SVD2xgbeQsdQ
         5y8OozRaVTpaWPT8uJU3IV9DLSECLPPopHKT8yXddsgawzccapJUoVhcUuMDv/P0ordw
         uc6wum+Ja/Gk/1uPQi6WxluzYQmb6JF8OhD4G9mmtVWnQli0j9uRW9w07JCcwnxrrDv4
         BzRSNsnt8Td9fEsHUkiOIKWiXhhlFoTGFCvOuHK+icq1s2H8TGw1vhHFtIzicMLN5Oly
         MeM6UVdLUj+ebrKifmRgjMVP7n88iVQBi7pAjBadSWmPqd5DoykIvGCKYF7WVuSq161k
         srcw==
Received: by 10.180.83.197 with SMTP id s5mr7007858wiy.9.1339705251929;
        Thu, 14 Jun 2012 13:20:51 -0700 (PDT)
Received: from localhost (213-191-157-151.dhcp.iskon.hr. [213.191.157.151])
        by mx.google.com with ESMTPS id hv7sm23635658wib.0.2012.06.14.13.20.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jun 2012 13:20:51 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQkbbw+ugUYMz8s7L5iEXglRx165Nj1SEXI2/cKvYj1d0KaJmAmbcHShiHmEFGLd+t09Sruu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200029>

It was left out from commit 1088261f6fc90324014b5306cca4171987da85ce
    
Signed-off-by: Luka Perkov <lists@lukaperkov.net>
---

 builtin.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin.h b/builtin.h
index 338f540..f5b8ed1 100644
--- a/builtin.h
+++ b/builtin.h
@@ -83,7 +83,6 @@ extern int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix
 extern int cmd_grep(int argc, const char **argv, const char *prefix);
 extern int cmd_hash_object(int argc, const char **argv, const char *prefix);
 extern int cmd_help(int argc, const char **argv, const char *prefix);
-extern int cmd_http_fetch(int argc, const char **argv, const char *prefix);
 extern int cmd_index_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_init_db(int argc, const char **argv, const char *prefix);
 extern int cmd_log(int argc, const char **argv, const char *prefix);
