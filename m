From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: [PATCH]: git-merge-one-file-script use /usr/bin/env to call bash
Date: Sat, 7 May 2005 10:45:49 +0200
Message-ID: <20050507084549.GF23680@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat May 07 10:40:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUKrK-0000C1-Uv
	for gcvg-git@gmane.org; Sat, 07 May 2005 10:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262849AbVEGIq5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 May 2005 04:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262862AbVEGIqo
	(ORCPT <rfc822;git-outgoing>); Sat, 7 May 2005 04:46:44 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:36029 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262849AbVEGIpz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2005 04:45:55 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j478joS8002356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 7 May 2005 08:45:50 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j478jnIM002355;
	Sat, 7 May 2005 10:45:49 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>, GIT <git@vger.kernel.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	GIT <git@vger.kernel.org>
Content-Disposition: inline
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[PATCH]: git-merge-one-file-script use /usr/bin/env to call bash

Signed-Off-by: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>

--- a/git-merge-one-file-script
+++ b/git-merge-one-file-script
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/usr/bin/env bash
 #
 # This is the git merge script, called with
 #
