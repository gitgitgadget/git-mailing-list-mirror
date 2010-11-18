From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 3/3] mergetool--lib: Add the proper executable name for ECMerge
Date: Thu, 18 Nov 2010 11:44:31 +0100
Message-ID: <4CE5038F.2040400@gmail.com>
References: <4CE50290.90600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Thu Nov 18 11:44:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ1yq-0006LL-TG
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 11:44:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756451Ab0KRKog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 05:44:36 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33362 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756293Ab0KRKof (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 05:44:35 -0500
Received: by eye27 with SMTP id 27so1823744eye.19
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 02:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:newsgroups:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=YpCHOerEXfE1zvuKOv1NJOBk+GRt3plxL+8zeS3KliI=;
        b=u14TSygVl1D5/k9HzpXQSXz9Auxylx7rEfMIxErIN8XrUsx5kFtsINBdyb5gOiramJ
         3edLU3DXLtXKfDIUu8Uxnl0nF+prTzxJ6wIQ0vMHscDfHN8KXUiR4zazy1BAyZ4amGkT
         Bb4uHNzY5xXsvu9YZFHsW8MsRICs1JIAK5HNY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=sLX7/gK54WMlu5Z1ustG7xBEQd04JHuHqHaIhid3zboLknpZKgxKC7tltQgiS4mUh3
         FDcQKipxm019ydOwZyF1u6PD/x0EryV33DmdS/3aEeAJqlbBPxGgcSDSstcGHeOssdAk
         YQ7XqFu+2wYd+HXZu+qn2ngYlpuqU30KR36/E=
Received: by 10.213.28.205 with SMTP id n13mr3530099ebc.5.1290077073522;
        Thu, 18 Nov 2010 02:44:33 -0800 (PST)
Received: from [130.73.68.143] (berry.zib.de [130.73.68.143])
        by mx.google.com with ESMTPS id q58sm274038eeh.9.2010.11.18.02.44.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Nov 2010 02:44:32 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4CE50290.90600@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161662>



Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 git-mergetool--lib.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 47049a6..58398bd 100644
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
1.7.3.2.msysgit.11
