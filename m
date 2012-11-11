From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] Documentation/log: fix description of format.pretty
Date: Sun, 11 Nov 2012 16:57:04 +0530
Message-ID: <CALkWK0=hdmYF2VoOZY4F7+yPD8D0rBnPY-tvp5pryRWp-0WBeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 11 12:27:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXVhU-0005SK-8G
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 12:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914Ab2KKL11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 06:27:27 -0500
Received: from mail-wg0-f44.google.com ([74.125.82.44]:40675 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050Ab2KKL10 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 06:27:26 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr13so3551365wgb.1
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 03:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=h8dRvzKbVao+iKL5gFHXU10f7dhksm74/OksrHnKQf0=;
        b=Yc9Iqy1FIVSiipqiAA5EPAhwSS403EjE2SuKdUW3cXO8rdbQA15r9UqmAstviSC1G/
         EJVLPxvt1+ECuB3nlWEAjG3P00brkDOepfYDHjS+LSNWy31L6lCL6s0ine+X8ArNXGa+
         +9CZ6ysnSiFpVf84iT0ERpDrYfvb8XVcZYNCGEBQSMRb1z4KBMofY+x9dNjeWpMqU68R
         LqUxhJsPqMGv4d3MEEJ+W7ukrrbHZhG7IYK+Vo5Is8Z3j8u3JoE293EK1HNHcL7m/zEw
         5gDXOkb0hsuSNDOfk/7uHVD4jBiG6naW64CufX7AxcYvHkIZALWewr+tZJ0n+Ny5x4oE
         NVug==
Received: by 10.180.19.73 with SMTP id c9mr10462887wie.8.1352633245190; Sun,
 11 Nov 2012 03:27:25 -0800 (PST)
Received: by 10.217.61.2 with HTTP; Sun, 11 Nov 2012 03:27:04 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209340>

59893a88 (Documentation/log: add a CONFIGURATION section, 2010-05-08)
mentioned that `format.pretty` is the default for the `--format`
option.  Such an option never existed, and the author meant
`--pretty`.  Make this correction.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-log.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 585dac4..4b07ad4 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -148,7 +148,7 @@ See linkgit:git-config[1] for core variables and
linkgit:git-
 for settings related to diff generation.

 format.pretty::
-       Default for the `--format` option.  (See "PRETTY FORMATS" above.)
+       Default for the `--pretty` option.  (See "PRETTY FORMATS" above.)
        Defaults to "medium".

 i18n.logOutputEncoding::
-- 
1.7.12.1.428.g652398a.dirty
