From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 04/20] fetch: add missing documentation
Date: Sat, 12 Oct 2013 02:07:14 -0500
Message-ID: <1381561636-20717-19-git-send-email-felipe.contreras@gmail.com>
References: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:14:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtOv-00063E-DL
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:14:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754834Ab3JLHOH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:14:07 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:33672 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754830Ab3JLHOE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:14:04 -0400
Received: by mail-oa0-f54.google.com with SMTP id n5so3189133oag.27
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0Ndh3jF+37J7jV9ZZ1uewMEelh8yJfSLX3nEoZqO+w0=;
        b=r6SE8jElUAvUomra/Q4GQ8/BQ6LWD7c/uF/blpz+ayyiUHoRd8GO4yM5QU5Yl0Ftqb
         NGm2DAvScTZsj4+k0zsOtsvQhpNMIYleTkWyNNQjjp08VcmNc2o+o4nrGjE3/NOz1kEz
         t7Y9/JD9Eg9YPpK3qY8bVfmxEb9wkIsdEZrboPYa03ZQLrv8Kd2oM/nBnNHqMPeE/g0r
         RCg/bygNk9QuKNKPFCDOh9zaYQrXrde3PsYO59OJHQJnb2eIThygmUIpcZUXAclgNUdr
         Nbchcj6QgzgMmtZQZdvIJm7fYLc1sHKB9LhFlyvomrkgZmfcHgwI4CFQAJN4CztnIzZn
         1F0A==
X-Received: by 10.60.131.197 with SMTP id oo5mr976509oeb.39.1381562043553;
        Sat, 12 Oct 2013 00:14:03 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id xx9sm28643528obc.6.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:14:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236026>

There's no mention of the 'origin' default, or the fact that the
upstream tracking branch remote is used.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-fetch.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index e08a028..7e75dc4 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -37,6 +37,9 @@ or from several repositories at once if <group> is given and
 there is a remotes.<group> entry in the configuration file.
 (See linkgit:git-config[1]).
 
+When no remote is specified, by the default the `origin` remote will be used,
+unless there's an upstream branch configured for the current branch.
+
 OPTIONS
 -------
 include::fetch-options.txt[]
-- 
1.8.4-fc
