From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/5] Minor additions to git-completion.bash
Date: Sun, 21 Apr 2013 18:35:46 +0530
Message-ID: <1366549551-18763-1-git-send-email-artagnon@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 21 15:06:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTtxz-0006xx-D3
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 15:06:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753283Ab3DUNF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 09:05:59 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:63823 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155Ab3DUNF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 09:05:58 -0400
Received: by mail-pb0-f50.google.com with SMTP id um15so163214pbc.23
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 06:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=6ZLYyyC2ksnSezKVe6a7xLWuRhz2eJ+3ODiJEiWdSiM=;
        b=W2JATo/7T5EKXKjKCvQaBSYR2iEkGJ+XPT4kgttu3cz5uoLP0/seSQJDETnS9DvQyG
         DPEICY0ZcqHdo2lPqPuVngQyazAcMvv64m3UB/94rK9bvLy3SHBrickmUxhP+bdAr/FJ
         vdVWe69yuE3J98sXa1rfqJHktRkvxhJOdTcB1WTLih2r/vSwwlWS+EUcYDEUnIpHFfJb
         BBqQz5Os5JCxACCJDrkZdkQw0F3jrjDLYlMwR3soU0dLYAaQUqjGtF7z+i9ZupqSAFdE
         zNDGK90M7NP3WGy7l5qE7n2Hsg+xUB+sls9Q62WMsJ3Xh/fszH5Y1BU3jwMF525fTCQ7
         9oEQ==
X-Received: by 10.66.250.230 with SMTP id zf6mr11221574pac.153.1366549557956;
        Sun, 21 Apr 2013 06:05:57 -0700 (PDT)
Received: from localhost.localdomain ([122.174.41.136])
        by mx.google.com with ESMTPS id aa8sm1570112pad.14.2013.04.21.06.05.54
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 06:05:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.501.gd2949c7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221947>

Hi,

I just looked at the config section, and started writing patches, and
kept going until I got bored.  So they're pretty random.

Sorry about the triviality of the patches: I was just looking to kill
some time on a lazy Sunday afternoon.

Thanks.

Ramkumar Ramachandra (5):
  git-completion.bash: lexical sorting for diff.statGraphWidth
  git-completion.bash: add diff.submodule to config list
  git-completion.bash: complete branch.*.rebase as boolean
  git-completion.bash: add branch.*.pushremote to config list
  git-completion.bash: add remote.pushdefault to config list

 contrib/completion/git-completion.bash | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

-- 
1.8.2.1.501.gd2949c7
