From: Sebastian Staudt <koraktor@gmail.com>
Subject: [PATCH] config.txt: Document help.htmlpath config parameter
Date: Tue, 15 Jan 2013 21:56:21 +0100
Message-ID: <20130115205621.GB49671@mormegil.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 21:56:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvDYs-0002v2-Qt
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 21:56:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756395Ab3AOU40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 15:56:26 -0500
Received: from mail-wi0-f171.google.com ([209.85.212.171]:58367 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756323Ab3AOU4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 15:56:25 -0500
Received: by mail-wi0-f171.google.com with SMTP id hn14so2776771wib.16
        for <git@vger.kernel.org>; Tue, 15 Jan 2013 12:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=yHNDQmKLbuD/c1r5rlfq8vK1UadqP5rjC2cuOmoun6U=;
        b=HRUJK8GwEu2dfY9OwL6FjRxxh9FJAmJrHK3cNCrSg6Se/nBBD+wfWAE0yyPPQXJY1U
         mk9pnRoUhiMOiMa1Tf6VvgeJM0YZCvdGqM/LnPwqqdA7726iODH92SpUP115UJQMPeDF
         cccESZRGqhSuTg2U625lUHWOltmmnyVBBEjgbX3hVG8GaytUDXFS1bA5aezcPteiOaip
         +phYH8lACty6E7YqcfFXmOmLmGBp6cNxB6vI7zXWh7daTNr/OC0WPJaMzLtS3XOIjSHu
         fbE5u+ixgA0DmmfpUjzMPWn/UntRq2Q3zFK8IcjZKPiqWHbtP+BDn0PpXEBzPyU+AJWC
         2PoA==
X-Received: by 10.180.107.130 with SMTP id hc2mr5955814wib.12.1358283384370;
        Tue, 15 Jan 2013 12:56:24 -0800 (PST)
Received: from mormegil.local (88-134-169-8-dynip.superkabel.de. [88.134.169.8])
        by mx.google.com with ESMTPS id bw9sm5071741wib.5.2013.01.15.12.56.23
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 15 Jan 2013 12:56:23 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213677>

Signed-off-by: Sebastian Staudt <koraktor@gmail.com>
---
 Documentation/config.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bf8f911..e452ff8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1351,6 +1351,12 @@ help.autocorrect::
 	value is 0 - the command will be just shown but not executed.
 	This is the default.
 
+help.htmlpath::
+	Specify the path where the HTML documentation resides. File system paths
+	and URLs are supported. HTML pages will be prefixed with this path when
+	help is displayed in the 'web' format. This defaults to the documentation
+	path of your Git installation.
+
 http.proxy::
 	Override the HTTP proxy, normally configured using the 'http_proxy',
 	'https_proxy', and 'all_proxy' environment variables (see
-- 
1.8.1.1
