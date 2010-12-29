From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4/4] git-instaweb: Use "git-instaweb" as sitename (for page titles)
Date: Wed, 29 Dec 2010 17:50:09 +0100
Message-ID: <201012291750.09610.jnareb@gmail.com>
References: <201012291743.41213.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 29 17:51:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXzEr-000563-8x
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 17:51:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753476Ab0L2Qul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Dec 2010 11:50:41 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57019 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841Ab0L2Quh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Dec 2010 11:50:37 -0500
Received: by mail-bw0-f46.google.com with SMTP id 15so11085534bwz.19
        for <git@vger.kernel.org>; Wed, 29 Dec 2010 08:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=fxX4Lkc7KwWu4ycgAASkQJwHcWklnIwlvU3UVu03sUs=;
        b=ZMw+keZdct9dE410mz1KQWTrRUWj474weSjTYlxMughgctMQqsxPZU5+5pwF8YJvXM
         phl9BWJBr9AJ+T8iSf25ZKSeRxqWOsqzSIuGrkyCtJqkC1aQ1PfcO6lMuG8U2vW1gfv8
         mv078tqR5xruX60GtOlRQP6HSVQGn/w9XbWFA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=DbINhBavGHblw+cSpfIEzEAqrPCh2fE/z8Dti2mTnhYlAreZ+94UAQ2nGPNyRlEbmN
         1ecdTBeFOK4mt0l+xa9xlsVpgwG6MdS9HxL9484DTwYObJnEagezILR4M0p8SMr1gCvw
         F/zzLzZNgujW9LC85xVi5T5og9w6PfjQa4xTE=
Received: by 10.204.72.20 with SMTP id k20mr5458443bkj.184.1293641436678;
        Wed, 29 Dec 2010 08:50:36 -0800 (PST)
Received: from [192.168.1.13] (abvs18.neoplus.adsl.tpnet.pl [83.8.216.18])
        by mx.google.com with ESMTPS id x38sm7505600bkj.13.2010.12.29.08.50.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Dec 2010 08:50:35 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201012291743.41213.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164319>

The default is to use "$ENV{'SERVER_NAME'} Git" or "Untitled Git";
use "git-instaweb" instead.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is new feature, and doesn't need to be in 1.7.4

It would be an RFC, if not for the fact that it is such trivial change.

 git-instaweb.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 94f8b07..935515d 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -583,6 +583,7 @@ gitweb_conf() {
 our \$projectroot = "$(dirname "$fqgitdir")";
 our \$git_temp = "$fqgitdir/gitweb/tmp";
 our \$projects_list = \$projectroot;
+our \$site_name = "git-instaweb";
 
 our @stylesheets = ("static/".basename(\$stylesheets[0]));
 our \$logo = "static/git-logo.png";
-- 
1.7.3
