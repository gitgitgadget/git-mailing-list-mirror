From: Igor Mironov <igor.a.mironov@gmail.com>
Subject: [PATCH 4/4] Documentation: add new git-svn branch/tag options --username
 and --commit-url
Date: Tue, 12 Jan 2010 03:22:27 +1100
Message-ID: <4B4B5043.3010101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 17:22:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUN2P-0006hf-Tz
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 17:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743Ab0AKQWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 11:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190Ab0AKQWi
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 11:22:38 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:47907 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172Ab0AKQWh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 11:22:37 -0500
Received: by bwz27 with SMTP id 27so393724bwz.21
        for <git@vger.kernel.org>; Mon, 11 Jan 2010 08:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=SVFdFHwAPge7nv7Z1Qc8n21P9EdEodocNLTXq9KJmes=;
        b=io9ciOIDVZVrKtrqFzZbd/42PtOdw+NrE70EPqgzBJzhH4tcCygjka5OrJHYsrp5wQ
         B4g8TEQWIw7LjM0JOl+LIcmjbOeMwNvvL255gn/Zk1ZS34seixTGspR1DELdWcuBIxgR
         dYF92BbPS/YR5WvVaWlAO7hT7QyovwVZRQsOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=nTISaYWS3+QWlEgtyilFvGvQdQhpVDLR/OetEfDYJBQhJePw/clVOaGWFwcS7YUeen
         mP8dQ1HUK7lvhOutbWsxxjdx/AYmvxqbslV+JyjEpWMQdJayl60ouDhI0AEcEcf+h5Ue
         ZqBXmvrXFQ5xrauys5j2hBK8kJwIKpBiNF/fw=
Received: by 10.204.3.220 with SMTP id 28mr4428016bko.4.1263226954921;
        Mon, 11 Jan 2010 08:22:34 -0800 (PST)
Received: from ?10.54.5.111? (ppp121-45-186-233.lns20.syd7.internode.on.net [121.45.186.233])
        by mx.google.com with ESMTPS id 16sm2681233bwz.3.2010.01.11.08.22.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 Jan 2010 08:22:34 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136640>

Signed-off-by: Igor Mironov <igor.a.mironov@gmail.com>
---
 Documentation/git-svn.txt |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 4cdca0d..8dbf9d1 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -239,6 +239,19 @@ discouraged.
 where <name> is the name of the SVN repository as specified by the -R option to
 'init' (or "svn" by default).
 
+--username;;
+	Specify the SVN username to perform the commit as.  This option overrides
+	configuration property 'username'.
+
+--commit-url;;
+	Use the specified URL to connect to the destination Subversion
+	repository.  This is useful in cases where the source SVN
+	repository is read-only.  This option overrides configuration
+	property 'commiturl'.
++
+	git config --get-all svn-remote.<name>.commiturl
++
+
 'tag'::
 	Create a tag in the SVN repository. This is a shorthand for
 	'branch -t'.
-- 
1.6.6.106.ge2de8
