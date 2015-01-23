From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH 0/7] Coding style fixes.
Date: Fri, 23 Jan 2015 17:06:48 +0600
Message-ID: <1422011208-3832-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 12:07:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEc58-0000ut-9m
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 12:07:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754724AbbAWLHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 06:07:14 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:56557 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbbAWLHN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 06:07:13 -0500
Received: by mail-lb0-f174.google.com with SMTP id f15so6443298lbj.5
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 03:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=5fZhJjdy+nYeVL1E0j10I8fi7Vzngz8Rhavoe1bcclA=;
        b=kat6kYL2HtfK2/rxp1N5oariNWvpfWHcd2lFDgoarqiw8ynMik1ISuGz815jDVsoqy
         rpCdMuGA/F9Mm+dyg0agHzcG6IrItebZ1FPTN+QUrq89y+uJehOFsNxNPmWX+FR1zEsh
         GG6SIdhC8SlTKjrYV6AYefc7ddR9AdRsfaH6uYJbnTyVlHoDVoN1b56uPQqr8tfH7vzw
         GlVh0UEb2ltPy8sWyFM8q2qw2VhTXrF8r8UKPy9JnZPWOsxqYw8+82bxoYan6IDiHD9y
         9BXu4GkOJ4NLrgf7Ry1xpDpV54vVwCfg2xLS1vpsECZpMU+pYl5184uvezpe344/02at
         e/Rg==
X-Received: by 10.152.228.133 with SMTP id si5mr6545170lac.96.1422011231471;
        Fri, 23 Jan 2015 03:07:11 -0800 (PST)
Received: from localhost.localdomain ([5.63.126.22])
        by mx.google.com with ESMTPSA id e7sm362615lbq.33.2015.01.23.03.07.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Jan 2015 03:07:10 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc1.275.g028c360
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262906>

This patch set contatins minor style fixes. CodingGuidelines contains
rule that the star must side with variable name.

Alexander Kuleshov (7):
  show-branch: minor style fix
  clone: minor style fix
  test-hashmap: minor style fix
  http-backend: minor style fix
  refs: minor style fix
  quote: minor style fix
  fast-import: minor style fix

 builtin/clone.c       | 2 +-
 builtin/show-branch.c | 2 +-
 fast-import.c         | 2 +-
 http-backend.c        | 2 +-
 quote.c               | 2 +-
 refs.h                | 2 +-
 test-hashmap.c        | 4 ++--
 7 files changed, 8 insertions(+), 8 deletions(-)

--
2.3.0.rc1.275.g028c360
