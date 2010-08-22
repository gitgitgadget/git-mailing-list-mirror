From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v5 0/5] merge --log configurability
Date: Sun, 22 Aug 2010 21:56:33 +0530
Message-ID: <1282494398-20542-1-git-send-email-artagnon@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 22 18:29:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnDQC-0003gO-KJ
	for gcvg-git-2@lo.gmane.org; Sun, 22 Aug 2010 18:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376Ab0HVQ2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Aug 2010 12:28:55 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:39817 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974Ab0HVQ2x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Aug 2010 12:28:53 -0400
Received: by pwi7 with SMTP id 7so1793710pwi.19
        for <git@vger.kernel.org>; Sun, 22 Aug 2010 09:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=3ip8tuROlWusfBKLCWtJ4yBBXMSUhN5C6/IPA+f1+yE=;
        b=JJsJwEOg1n+X/TTDCA90JCK3n3/GIFzqd0CGVFxV9NdNBlklpvFGtMwEViThnUy7/J
         4Axzce38t+5HDyubdzBK0ux366mXOyZ0CaKgHumDgQ7QRTYB+KjpwmgKEBM6cTZwN4KX
         ymErU5u1VQXnEEdjnf5taut3ItGZcxTx4uCAY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=lF67XG88J+NV8uIucHZG/7PiRoj1+1SEep2T/RCYLBsa2dTSswO9Z66gLpPy+5OMFj
         PZE7kv/1pVlJDc9dkBvRzhQExtXMz+Y4UWIixc++kfVHDNx+XQ2fHSzB8fkl92AxdYl/
         9ftEwcmNqqxbJoUJqzOii37iu8L5QWppiGAKM=
Received: by 10.142.170.19 with SMTP id s19mr3454337wfe.97.1282494533344;
        Sun, 22 Aug 2010 09:28:53 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id y16sm7089065wff.14.2010.08.22.09.28.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Aug 2010 09:28:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154183>

This series is a complete rewrite after Jonathan's last review. I've
tried to pay close attention to detail and be as careful as possible-
let me know if I've missed something.

Thanks.

Jonathan Nieder (1):
  parse-options: clarify PARSE_OPT_NOARG description

Ramkumar Ramachandra (4):
  fmt_merge_msg: Change fmt_merge_msg API to accept shortlog_len
  merge: Make '--log' an integer option for number of shortlog entries
  merge: Make 'merge.log' an integer or boolean option
  fmt-merge-msg: Remove deprecated '--summary' option

 Documentation/git-fmt-merge-msg.txt |   23 +++++----------
 Documentation/merge-config.txt      |    8 ++++-
 Documentation/merge-options.txt     |   11 ++-----
 builtin.h                           |    5 +--
 builtin/fmt-merge-msg.c             |   49 ++++++++++++++++------------------
 builtin/merge.c                     |   25 +++++++++++------
 parse-options.h                     |    2 +-
 7 files changed, 59 insertions(+), 64 deletions(-)

-- 
1.7.2.2.409.gdbb11.dirty
