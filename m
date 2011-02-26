From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 3/3] mergetool--lib: Add the proper executable name for ECMerge
Date: Sat, 26 Feb 2011 11:53:36 +0100
Message-ID: <4D68DBB0.2020909@gmail.com>
References: <4D68DAC4.9060100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, charles@hashpling.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sat Feb 26 11:53:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtHmV-0008Ly-Uc
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 11:53:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863Ab1BZKxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Feb 2011 05:53:43 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33416 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab1BZKxn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 05:53:43 -0500
Received: by fxm17 with SMTP id 17so2496255fxm.19
        for <git@vger.kernel.org>; Sat, 26 Feb 2011 02:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version
         :newsgroups:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=1DkH8z6zZUPVpKGJxCbgXMjY/7e4C8MXSwwYpxm7EG4=;
        b=Hqo5mwJeFnlN5yJePg5BfeadQN1CREY20kvqcmaDnr6djX3h5mxsJ0JKGWpW1BHTxG
         R0W0Au4soFHfJa7X4ttlIwdmbN6XjxRTSbvFrSIi8F2Fjx5BmPa0LGbuDGoPw3f971Yl
         fC3TBMgx3HUf50hTSX/EA0j8ZMwoVZXbiLjbM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=vRlowyM5NKg4LSsgytU6qo4peDkLREUgwRDPfZidSyLFUEdt8ux+cIhPQnoedvVhr/
         SQtDHQ0ftSPdoeyClUoMvx/WNnmNNILdxAoEAsewYdSRkPSU8+G2aTxSvvqSkD+H61EW
         ZXjrq8cg03ZvBQY7oFlgdPZk9PK3OYP86vgyQ=
Received: by 10.223.86.13 with SMTP id q13mr3896380fal.53.1298717621996;
        Sat, 26 Feb 2011 02:53:41 -0800 (PST)
Received: from [192.168.178.23] (p5DDB01ED.dip0.t-ipconnect.de [93.219.1.237])
        by mx.google.com with ESMTPS id r24sm717472fax.3.2011.02.26.02.53.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 26 Feb 2011 02:53:41 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4D68DAC4.9060100@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167977>

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 git-mergetool--lib.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 3ac6231..95da00b 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -16,6 +16,9 @@ translate_merge_tool_path () {
 	bc3)
 		echo BCompare
 		;;
+	ecmerge)
+		echo guimerge
+		;;
 	emerge)
 		echo emacs
 		;;
-- 
1.7.3.2.msysgit.6.dirty
