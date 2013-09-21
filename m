From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: [PATCH] warn about http server document being too old
Date: Sat, 21 Sep 2013 07:53:06 +0530
Message-ID: <523D030A.6080309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 21 04:23:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNCqr-0005jJ-Fu
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 04:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015Ab3IUCXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Sep 2013 22:23:13 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:48480 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880Ab3IUCXM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Sep 2013 22:23:12 -0400
Received: by mail-pa0-f45.google.com with SMTP id rd3so120353pab.32
        for <git@vger.kernel.org>; Fri, 20 Sep 2013 19:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=BA3H+0mYuWLfrLpsNwGtA/Qrg8ickooYMICGaTO/0ic=;
        b=c+1uGR8l4anTeKHTrEBstQf6HZLsJLwZiIPVRG8FVv4qM/GkUO4hPtyD5FsxVZZMfw
         VNHnzD/VlJx82tdnkWnXAUrHUoRg9CWgtCv38oV4tXxQ8DGRnOY+qrdtaDp+YZxtE/HY
         jDvNS8ZIwQdAS8CzZjlI501Zaf9UlRAeWK1baP+j1KFctRhBoteOzWQQwIjtQFFt+UEr
         afYUu9Qbip/xV5KmRoracI8JJIGovxLcn7VqQSPAg9ZFHzWG2DHPzOZil724ja+iiXft
         aZvLweRk6KPApximLs5IUSAe5oVQoRR9UIfrAFszWDMeVgjdFz+JS+lyFmCcDttcN9A1
         OEkw==
X-Received: by 10.68.60.226 with SMTP id k2mr1117093pbr.146.1379730191790;
        Fri, 20 Sep 2013 19:23:11 -0700 (PDT)
Received: from sita-lt.atc.tcs.com ([117.195.171.168])
        by mx.google.com with ESMTPSA id py4sm18741001pbc.14.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 20 Sep 2013 19:23:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130805 Thunderbird/17.0.8
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235090>


  - describe when it is still applicable
  - tell people where to go for most normal cases

Signed-off-by: Sitaram Chamarty <sitaram@atc.tcs.com>
---

ref: http://thread.gmane.org/gmane.comp.version-control.git/159633.  Yes
it's very old but better late than never.

 Documentation/howto/setup-git-server-over-http.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/howto/setup-git-server-over-http.txt b/Documentation/howto/setup-git-server-over-http.txt
index 7f4943e..90b19a0 100644
--- a/Documentation/howto/setup-git-server-over-http.txt
+++ b/Documentation/howto/setup-git-server-over-http.txt
@@ -3,6 +3,11 @@ Subject: Setting up a Git repository which can be pushed into and pulled from ov
 Date: Thu, 10 Aug 2006 22:00:26 +0200
 Content-type: text/asciidoc

+NOTE: This document is from 2006.  A lot has happened since then, and this
+document is now relevant mainly if your web host is not CGI capable.
+
+Almost everyone else should instead look at linkgit:git-http-backend[1].
+
 How to setup Git server over http
 =================================

-- 
1.8.3.1
