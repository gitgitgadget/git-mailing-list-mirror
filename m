From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 00/10] remote-hg: fixes and cleanups
Date: Mon, 13 May 2013 18:11:50 -0500
Message-ID: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 01:13:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc1wE-0006zw-D9
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 01:13:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755525Ab3EMXNk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 19:13:40 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:59057 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755514Ab3EMXNg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 19:13:36 -0400
Received: by mail-oa0-f54.google.com with SMTP id o17so3694442oag.41
        for <git@vger.kernel.org>; Mon, 13 May 2013 16:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=248uqrrzwseOubCC2GNJ5VyZE7nsJsQASKs39702p/M=;
        b=smx4UEOVvmN05uxXNzJttqJPhnvcCZioh6JZNZUpsTRCLpvrHK9UFJ8XDvc0j/JZ9B
         CiDFH1/eL03unT6hJJCqNp8MlkbKCEu3cT6pdfg1gVfrnxh1yJuFl3U9oMjKgiM200fg
         rrnubeVcyPzAT4vWzBORo9DHh6Dlx2UBfY+LyP0Q0vco+0oXJPqo1fC6uC/RNtLsVpOE
         VTjtWG8l4gaa+FHcJGYNdrKKXWsIbeOhnsbNSNqkr4Jh4UUHm5eV3GrMh8xJlKAV9Qyu
         wKrlnq42YeR4igtu706Iw9UL262JM6bC5gaGwHFQh80xO6e8VwAFF1Bc5gYlnseFHYct
         2+DQ==
X-Received: by 10.60.40.65 with SMTP id v1mr14721750oek.124.1368486816302;
        Mon, 13 May 2013 16:13:36 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id fm10sm9400301obb.4.2013.05.13.16.13.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 16:13:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224218>

Hi,

Since the last series is not merged to master yet, I decided to add more cleanups.

Felipe Contreras (10):
  remote-hg: trivial cleanups
  remote-hg: get rid of unused exception checks
  remote-hg: enable track-branches in hg-git mode
  remote-hg: add new get_config_bool() helper
  remote-hg: fix new branch creation
  remote-hg: disable forced push by default
  remote-hg: don't push fake 'master' bookmark
  remote-hg: update bookmarks when pulling
  remote-hg: test: be a little more quiet
  remote-hg: trivial reorganization

 contrib/remote-helpers/git-remote-hg     | 47 ++++++++++++++++----------------
 contrib/remote-helpers/test-hg-hg-git.sh |  3 +-
 contrib/remote-helpers/test-hg.sh        |  4 +--
 3 files changed, 26 insertions(+), 28 deletions(-)

-- 
1.8.3.rc1.579.g184e698
