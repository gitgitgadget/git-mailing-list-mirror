From: Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH 5/5] WIP/Document the http protocol change
Date: Fri, 27 Feb 2015 17:01:58 -0800
Message-ID: <1425085318-30537-6-git-send-email-sbeller@google.com>
References: <CAGZ79ka8Zg86qqvWByNiP3F6a9QggO-bNY3ZZ9g+A-MdKYQ7NQ@mail.gmail.com>
 <1425085318-30537-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, gitster@pobox.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 02:02:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRVnT-0003cO-Nf
	for gcvg-git-2@plane.gmane.org; Sat, 28 Feb 2015 02:02:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760AbbB1BCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2015 20:02:14 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:33229 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbbB1BCH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2015 20:02:07 -0500
Received: by igbhl2 with SMTP id hl2so4483553igb.0
        for <git@vger.kernel.org>; Fri, 27 Feb 2015 17:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H5yQQd4+nRDZR75KQpcFntYIgQNnEvAHckr0Ghx5s4g=;
        b=YPU9TCJUJ7jGwOFswkVLue1dlUT3FfNO2RIhcrlcHpTt3+FghlPf2hpy9Tq0CQIE07
         +Aso263V036cRldqZoKYAVjaZ6DGYmgDFQBZPxXO8KKtdI1kj7T3wLpLlNnWiZmpl0il
         rJHlyMHmtMu0xV03wiEyJIEB7e1Sc+S68uMXbNMdoenjWy/rICxm9vEqWOy7UpaDyTjc
         y7dSWrbCq8rZe72025+4mqqHw7pxmvUaRZRc8lfTsXy3DhAIS+QHzlalA5DBRJLwq4HH
         GKZVt1OCkNohE1TSbFhjP8/uw2Vf6ihD74UcxZX7wl92HvT6FXSWpl1bp4oS3JkywKVH
         wRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H5yQQd4+nRDZR75KQpcFntYIgQNnEvAHckr0Ghx5s4g=;
        b=Dkyxg24v5jzkpJ4LX6BFEQ+10mWuAYRNuOxm+7bR2KRvtOwyAemxhS7CRSVhmb4FJv
         zsuMplcXZ+V6sxxGlXhzKLcU04AN35RTMviNRXNr7zNrzzX5MsFm1Byj67DTe3F1AHjv
         eANQNJHdmIvLz+ZnLMFQPfXTtPSERNiy7pccP2gBvvwhoeqUDCihlpdUED+p75Tjwrja
         iA+fzGVNdcUenEz43UoMalpcFzF7Lgs/505ic52sQmoIbbU4Ye4LG0OAA/vIrJqssscL
         /s75LsL/ZFetiPY8uTsIXsnHaft0lhq2ZeQoFHXyBXoOxubSZ0FRHlm6xVo9Ql3uQSU3
         sgZA==
X-Gm-Message-State: ALoCoQlkSmNbaBJ0T/gGvp8hg+YDGrjRHlsZGgQjMc7sb+JKkucbhLzAnU981Nu/URG9jvWDB8Qn
X-Received: by 10.50.138.76 with SMTP id qo12mr8254679igb.36.1425085326983;
        Fri, 27 Feb 2015 17:02:06 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:700c:d3d2:5834:b5cc])
        by mx.google.com with ESMTPSA id ao5sm2299555igc.3.2015.02.27.17.02.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 27 Feb 2015 17:02:06 -0800 (PST)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1425085318-30537-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264522>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/technical/http-protocol.txt         | 4 ++--
 Documentation/technical/protocol-capabilities.txt | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
index 229f845..638819d 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -191,10 +191,10 @@ HTTP clients that support the "smart" protocol (or both the
 "smart" and "dumb" protocols) MUST discover references by making
 a parameterized request for the info/refs file of the repository.
 
-The request MUST contain exactly one query parameter,
+The request MAY contain parameters. Supported parameters includes
 `service=$servicename`, where `$servicename` MUST be the service
 name the client wishes to contact to complete the operation.
-The request MUST NOT contain additional query parameters.
+Further parameters are as described in protocol-capabilities.txt
 
    C: GET $GIT_URL/info/refs?service=git-upload-pack HTTP/1.0
 
diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index 4f8a7bf..40ddb37 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -3,6 +3,10 @@ Git Protocol Capabilities
 
 Servers SHOULD support all capabilities defined in this document.
 
+The client MAY ask for capabilities first out of band to the server.
+If so the server MUST NOT advertise any capabilities the client did
+not ask for.
+
 On the very first line of the initial server response of either
 receive-pack and upload-pack the first reference is followed by
 a NUL byte and then a list of space delimited server capabilities.
-- 
2.3.0.81.gc37f363
