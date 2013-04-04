From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 00/13] remote-hg: general updates
Date: Thu,  4 Apr 2013 09:30:09 -0600
Message-ID: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 04 17:31:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNm8m-0003fD-29
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 17:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762559Ab3DDPbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 11:31:20 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:38696 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762372Ab3DDPbT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 11:31:19 -0400
Received: by mail-ob0-f180.google.com with SMTP id wo10so2711537obc.11
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 08:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=jIU2cDdrd3AKGrbC0d+4gwf5ijwXDUbggsYHk12+tw4=;
        b=R342/2ORvJrj9Q3KD+X9W8oDb3iXgOwOuie5Jq2uw2jKwU6znHpLh/EvLCUudvhm4s
         gbK08nXacbOVSAY0msMzGMZm0Si78ZT2KxGg6tPB8PnE6r+4rJjs8IiOLmAK0RGJr/+2
         XNQMztOqqtLP55RH8enuhH7BokSBE/KMxJLjQAbd8/WsBTEc+zVYMOJ+J7keU+SfBJLO
         Ahmst+LAAmjJwISkS16ebEO0KCxwQTWdwZlticIh7rGP22s+wr/3rp4bfx3NeTclCPC7
         3oQG51q9HzGNsPqce9F9RgIUpG/KyH8FbzyfwRVO9z2T3v5wK76dS4yuKPbH0x50S6/8
         pZgw==
X-Received: by 10.60.62.70 with SMTP id w6mr4794510oer.38.1365089478536;
        Thu, 04 Apr 2013 08:31:18 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id ri7sm7112388oeb.6.2013.04.04.08.31.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 08:31:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220003>

Hi,

A reroll of the previous series, only a very small bugfix, and one updated
commit message.

Dusty Phillips (2):
  remote-hg: add missing config variable in doc
  remote-hg: push to the appropriate branch

Felipe Contreras (10):
  remote-hg: trivial cleanups
  remote-hg: properly report errors on bookmark pushes
  remote-hg: make sure fake bookmarks are updated
  remote-hg: trivial test cleanups
  remote-hg: redirect buggy mercurial output
  remote-hg: split bookmark handling
  remote-hg: refactor export
  remote-hg: update remote bookmarks
  remote-hg: force remote push
  remote-hg: update tags globally

Peter van Zetten (1):
  remote-hg: fix for files with spaces

 contrib/remote-helpers/git-remote-hg     | 75 ++++++++++++++++++++++++--------
 contrib/remote-helpers/test-hg-bidi.sh   |  6 +--
 contrib/remote-helpers/test-hg-hg-git.sh |  4 +-
 3 files changed, 63 insertions(+), 22 deletions(-)

-- 
1.8.2
