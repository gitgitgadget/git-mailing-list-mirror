From: Dirk Wallenstein <halsmit@t-online.de>
Subject: [PATCH] doc: status, remove leftover statement about '#' prefix
Date: Fri, 21 Mar 2014 15:10:18 +0100
Message-ID: <20140321141006.GA2126@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 21 15:10:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR09b-0003mJ-9F
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 15:10:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965401AbaCUOK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 10:10:27 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:36202 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965355AbaCUOKY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 10:10:24 -0400
Received: by mail-ee0-f46.google.com with SMTP id t10so1824274eei.5
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 07:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=phV6Xj0qu0irT9h61mwXbjFDPgNbdwfQfht2SDA2d9Q=;
        b=IjY6JIKjE7uvF13Z8A5/jqdHi6v+9Ou3G6TfF2ltDRMuSUOwll4YWW3DbAokuMwNBw
         IaFW3L/+V0SPuiMckeU79j+ulsptTsWL/0WYWQpZ6WSthssR7MgODivEUxKLEnbHHRKc
         CI27JHX2zci9G1mXohvOiIoixhXWsUVWjLAjiFN3ZxJjXNiV38Q2HXSwrfUfIxhrnKkM
         T7rzn7/mV59WbVhtyXh/0vaX//K66FOQRNMiPehvTJrpbuC4lWXeGXEINZb4cHYWqbVK
         H/bDcFMUmN9vhdSQQiOu+ytIhk+ghcNGq+PVCzmpd31KEcHzVSGHw0l6U7oFIR6o0Jhv
         tZzw==
X-Received: by 10.14.206.137 with SMTP id l9mr48781033eeo.40.1395411023753;
        Fri, 21 Mar 2014 07:10:23 -0700 (PDT)
Received: from localhost (ip-178-202-211-233.unitymediagroup.de. [178.202.211.233])
        by mx.google.com with ESMTPSA id j41sm11826721eeg.10.2014.03.21.07.10.21
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 07:10:22 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244689>

This hasn't been true since 2556b9962e7c0353d562b7bf70eed11d8f29d0b0

Signed-off-by: Dirk Wallenstein <halsmit@t-online.de>
---
 Documentation/git-status.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index a4acaa0..def635f 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -97,7 +97,7 @@ configuration variable documented in linkgit:git-config[1].
 OUTPUT
 ------
 The output from this command is designed to be used as a commit
-template comment, and all the output lines are prefixed with '#'.
+template comment.
 The default, long format, is designed to be human readable,
 verbose and descriptive.  Its contents and format are subject to change
 at any time.
-- 
1.9.0.1.g16216b6
