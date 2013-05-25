From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/6] build: cleanups
Date: Fri, 24 May 2013 21:41:00 -0500
Message-ID: <1369449666-18879-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:42:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4RU-00009p-FV
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849Ab3EYCmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:42:44 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:35646 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822Ab3EYCmo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:42:44 -0400
Received: by mail-ob0-f172.google.com with SMTP id tb18so6270982obb.17
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=8UGjzulS8tzSCHYS3FsRFqyUE55LrN6PbwxsylTvaQ4=;
        b=cz7YasxImK12g6g62qnu1BIKL+kqEc69cm0l8Jafeww23/8AV7BzeByqRiHI1ZsHvI
         4s/lOWeofGMoQw/pNaYHWlvMlimw11qwEk5CYNc8wK2lx8XsZTynndd2MO8zp1c/qrC+
         4Tk5lJNdme+z2zWuAonBhaXhtxqKvnvUuw/EL04BxZrpH/yDdYlFGDBRpcMUA0AMJiCH
         AWeWKlBrbH+lrs2nceDPuh9GNvUOkCxfLCS8L4AJ6f+dYsy72oY8GzoIKoZ6rz7gFTvF
         eBfV5czv3VTMpu2RxVHlQx2K6PN+EUZdCczlB51L0DvOpEMCAUEivWHSkkTHxto1DfUQ
         FNjA==
X-Received: by 10.182.134.231 with SMTP id pn7mr13294059obb.11.1369449763739;
        Fri, 24 May 2013 19:42:43 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id b5sm20062869oby.12.2013.05.24.19.42.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:42:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225468>

Hi,

Here's a bunch of cleanups, after which it's trivial to avoid the installation
of test scripts, namely git-remote-testpy.

Felipe Contreras (6):
  build: trivial simplification
  build: cleanup using $^
  build: cleanup using $<
  build: be clearer about order-only prerequisites
  build: add NO_INSTALL variable
  build: do not install git-remote-testpy

 Makefile | 48 +++++++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

-- 
1.8.3.rc3.312.g47657de
