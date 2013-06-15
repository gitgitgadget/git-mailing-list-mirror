From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 0/5] Write a good 'stash store' for autostash
Date: Sat, 15 Jun 2013 18:43:21 +0530
Message-ID: <1371302006-29775-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 15 15:16:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnqL9-0008K3-OM
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 15:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754471Ab3FONQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 09:16:01 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:48648 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522Ab3FONPU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 09:15:20 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so1395013pbc.2
        for <git@vger.kernel.org>; Sat, 15 Jun 2013 06:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=3TGAb5b7kM18IDQP1Fcw2IFUS+GvJYsdidMkzK0wXwc=;
        b=kET0slslRaqzy5IspmkRsGmYehUtnlw/WLrtWp8OKYhclIcujsUJAbBTdYcj1zNc+p
         oBUL94r7gNBZWTVFBLRsXVwF/UyO6KEMA/itgH+mbCfhKGR4/7Ug4vunpuye12MDomve
         aK5ulu3OXEK6UbPxUbl+JiFD2zhwW0ZuSHMqesT7BJo/zpw97midz/cMVrDzCIc9fT8J
         9PtMO7NbqZab9f9T3LQJU+cKPMJ22nGxWF3JlttcqnTTJHh3iu/2D3/wBOlVsPdFrIQq
         Z5i2StAKYkgpVy/198yJ4rCf0V7dOrGfzhskvIMLa3HtUSFGDqGU/X6V7F7N8eYra2zf
         ejNg==
X-Received: by 10.66.4.106 with SMTP id j10mr6404553paj.218.1371302120051;
        Sat, 15 Jun 2013 06:15:20 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id pe9sm6239122pbc.35.2013.06.15.06.15.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Jun 2013 06:15:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.441.gd7d6b72.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227955>

The interface actually makes sense in this iteration, thanks to Junio.
Also fix minor nits pointed out by Phil Hord.

Thanks.

Ramkumar Ramachandra (5):
  stash doc: add a warning about using create
  stash doc: document short form -p in synopsis
  stash: simplify option parser for create
  stash: introduce 'git stash store'
  rebase: use 'git stash store' to simplify logic

 Documentation/git-stash.txt | 13 ++++++++++--
 git-rebase.sh               |  7 ++----
 git-stash.sh                | 52 ++++++++++++++++++++++++++++++++++++---------
 t/t3903-stash.sh            | 19 +++++++++++++++++
 4 files changed, 74 insertions(+), 17 deletions(-)

-- 
1.8.3.1.441.gd7d6b72.dirty
