From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/3] rr/fmt-merge-msg replacements
Date: Sat, 28 Aug 2010 16:05:31 +0530
Message-ID: <1282991734-3368-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 28 12:38:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpInn-0003l9-PD
	for gcvg-git-2@lo.gmane.org; Sat, 28 Aug 2010 12:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651Ab0H1KiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Aug 2010 06:38:19 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36156 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095Ab0H1KiS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Aug 2010 06:38:18 -0400
Received: by pwi7 with SMTP id 7so1499756pwi.19
        for <git@vger.kernel.org>; Sat, 28 Aug 2010 03:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=BPX+o8QPhSyYvvYkyrWi8NhzaUqXI6L3HfJ6RlEMZgo=;
        b=HjA1m7XD+pYMf1iyToqmELJ4A51+2wmNjZeeBreTiXspdvueT9Qi0GIpZnUBBhpiup
         cRVy88dUOK1uSii4OQtAO/KG+aO4bkyU+7yDdX+lBOIiyg7xofRaJw7YyTlbB7eBHt4N
         sI/OC/CUcp15krpTKxra0TCxcOUT2LRuytfV8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=kRaDq+ZekowUCAahJcoHhn6wby7s3/U43R78r0h6qKECjET7Szb1TLhiamhnOeWmNi
         VMPfsERSTGBfH5L1eGiz4sGD3gwAoc+lX+so5eOF84SAZfYNqznE5KzKSwiHxcI0mq1n
         yA/u+8Klmt4W4JiBSjOcHMM5FJH1N23pzYNuo=
Received: by 10.142.226.4 with SMTP id y4mr2278921wfg.201.1282991898223;
        Sat, 28 Aug 2010 03:38:18 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id t11sm5855798wfc.4.2010.08.28.03.37.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Aug 2010 03:38:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154637>

I found a problem while writing the test for -1: the first patch is a
correction for that; sorry I didn't detect it earlier.

The second and third patches are rewrites of the tests I submitted
earlier- the rest of the file needs to be cleaned up to match this
style. Thanks Jonathan.

Ramkumar Ramachandra (3):
  fmt-merge-msg: Disallow '--log', 'merge.log' < 0
  t6200-fmt-merge-msg: Exercise 'merge.log' to configure shortlog
    length
  t6200-fmt-merge-msg: Exercise '--log' to configure shortlog length

 builtin/fmt-merge-msg.c |    4 +++-
 builtin/merge.c         |    2 +-
 t/t6200-fmt-merge-msg.sh |  123 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+), 2 deletions(-)

-- 
1.7.2.2.409.gdbb11.dirty
