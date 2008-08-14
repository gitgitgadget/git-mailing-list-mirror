From: Lee Marlow <lee.marlow@gmail.com>
Subject: [PATCH 0/2] Helpful completions for merging
Date: Thu, 14 Aug 2008 16:41:09 -0600
Message-ID: <1218753671-58099-1-git-send-email-lee.marlow@gmail.com>
Cc: git@vger.kernel.org, Lee Marlow <lee.marlow@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 15 00:42:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTlWN-00081i-6J
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 00:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbYHNWlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 18:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbYHNWlQ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 18:41:16 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:36028 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbYHNWlP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 18:41:15 -0400
Received: by rv-out-0506.google.com with SMTP id k40so635822rvb.1
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 15:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=DktzLlSA1lv98nDwjUyeoXdNmWGF6wtJKgfLRJfvbV0=;
        b=DuNNHk4vyoLDUsoLuKdRjgmuMwC2TNFRWnUAdZ91qndYy4N/ZFZwPXe1RBXR2kD84k
         /As/CxwENdTigz/2zKFoyzUGQjgy5cmCKu6TnDqSRUP1rvCxsg8bQJ5isyLXBsZGfi8p
         yjK9yh1qH9HZ2623lchf5D68GEGcJbOUHNL8U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=EAPCa/1biXoF1kWtfD0FOk/Eog3UEO/nubPaWIITQTUHo07J75oOh4gJCnFnY7x3Bt
         u2BRyjlhy6s2aJJvvgV3qUgZIt8IGqhKJiLtL5GqoEQN1rp5feueCUZhm0Fqf3l4lJfd
         si63p2uoymqHARVEu67OKmkzafPq39MDEkki4=
Received: by 10.140.191.14 with SMTP id o14mr1071449rvf.78.1218753675042;
        Thu, 14 Aug 2008 15:41:15 -0700 (PDT)
Received: from localhost.localdomain ( [75.71.41.234])
        by mx.google.com with ESMTPS id f21sm2511657rvb.5.2008.08.14.15.41.13
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 Aug 2008 15:41:14 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc3.6.ga0653
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92428>

These patches just add some simple completions for merging.

Lee Marlow (2):
  bash completion: Add completion for 'git mergetool'
  bash completion: Add '--merge' long option for 'git log'

 contrib/completion/git-completion.bash |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)
