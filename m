From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] remote-bzr: trivial updates
Date: Tue, 13 Nov 2012 02:03:26 +0100
Message-ID: <1352768608-20703-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 02:03:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY4uy-0002UB-81
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 02:03:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754043Ab2KMBDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 20:03:42 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:41372 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914Ab2KMBDm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 20:03:42 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so320111bkw.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 17:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=geaZCAmA7OjD/7cDwWslgmQIbwuu2Ikg30/jog/vJvQ=;
        b=Tk3E7Z0PoLFzm2WZvtdj6B4EtXh9Bq4WBzLbqbczlr3XTOpD/Ga3u0wA8wMh7TZn4o
         ar5NbDISCNSi7g8kz9xUYfWTcdHhxe5MhH9Ngt260y635Tnr15lhOXDCyrDsDUaO1UqG
         F9fNB/gn+T0rI+DBQIq5M68TGtG66tIVILyHvjG+1QvcUblioVdmmlv8xlPefk1X9oH6
         3fy/QpUx648hVNdJ2kNH0BBwH48PG49CqSLiOmoZor1wlSATjmwR5/s7SAR7eSM0NTwZ
         sYiC1mDDInTgZxpuB5WJxojc5zm4zUMjcWNEeOYt9zbgwYKmtF+YxsFwfLqsYiKVzCei
         jMTw==
Received: by 10.204.156.11 with SMTP id u11mr3568266bkw.106.1352768620868;
        Mon, 12 Nov 2012 17:03:40 -0800 (PST)
Received: from localhost (ip-109-43-0-114.web.vodafone.de. [109.43.0.114])
        by mx.google.com with ESMTPS id hu14sm4372822bkc.12.2012.11.12.17.03.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Nov 2012 17:03:39 -0800 (PST)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209558>

Hi,

Here's a fix for older versions of bzr, and a check for local repositories.

Felipe Contreras (2):
  remote-bzr: add support for older versions of bzr
  remote-bzr: detect local repositories

 contrib/remote-helpers/git-remote-bzr | 54 +++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 21 deletions(-)

-- 
1.8.0
