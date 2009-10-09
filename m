From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH 7/8] mingw: enable OpenSSL
Date: Fri,  9 Oct 2009 17:04:41 +0200
Message-ID: <1255100682-13952-7-git-send-email-kusmabite@gmail.com>
References: <1255100682-13952-1-git-send-email-kusmabite@gmail.com>
 <1255100682-13952-2-git-send-email-kusmabite@gmail.com>
 <1255100682-13952-3-git-send-email-kusmabite@gmail.com>
 <1255100682-13952-4-git-send-email-kusmabite@gmail.com>
 <1255100682-13952-5-git-send-email-kusmabite@gmail.com>
 <1255100682-13952-6-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 17:11:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwH8A-0007fT-6R
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 17:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761019AbZJIPGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 11:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761038AbZJIPGN
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 11:06:13 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:39022 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761016AbZJIPGM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 11:06:12 -0400
Received: by mail-ew0-f208.google.com with SMTP id 4so697240ewy.37
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 08:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=3SQllWLH2W94tFum8SO0dZxUIrD3gH3werk2t3SDOhc=;
        b=ZnoFscVRYifO2yy3VIboclXc9HLXIFA/2ItY8Wo8PxujuqaDPhAmwGbciYviNvifeT
         UzBPQdnXRjA4Oosgpz5jBljsfJYIlyA3gO15fh6hNxiATKxwlVmbKquGOKMNU6gNAyrC
         LI8V9THehp/NhCKuqfjLM/Gclw3aW65IWCIsk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=o6GCmO+K7eDCj76b5idaYDuNpG0n1DuvsDfAIOG743LzlQD7HAXTDTtEUibhLn+x9h
         Vad6qPqgG/dpIJVoaaFMnXUkH5SJSwif0FrY+W7YX3celflYRzSmjgxiFWBwwRlMyTUP
         CXFvioHtvGNi6kwhAhAkOyvNZye3slhj18oYU=
Received: by 10.211.158.15 with SMTP id k15mr3362255ebo.25.1255100761180;
        Fri, 09 Oct 2009 08:06:01 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id 24sm175487eyx.41.2009.10.09.08.05.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Oct 2009 08:06:00 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1255100682-13952-6-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129808>

Since we have OpenSSL in msysgit now, enable it to support SSL
encryption for imap-send.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 Makefile |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 8ba789a..8818f0f 100644
--- a/Makefile
+++ b/Makefile
@@ -933,7 +933,6 @@ else
 ifneq (,$(findstring MINGW,$(uname_S)))
 	pathsep = ;
 	NO_PREAD = YesPlease
-	NO_OPENSSL = YesPlease
 	NO_LIBGEN_H = YesPlease
 	NO_SYMLINK_HEAD = YesPlease
 	NO_IPV6 = YesPlease
-- 
1.6.5.rc1.60.g41795
