From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/5] Re-roll rr/revert-cherry-pick
Date: Wed,  7 Dec 2011 12:07:52 +0530
Message-ID: <1323239877-24101-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 07:39:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYB9o-0000Iw-My
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 07:39:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865Ab1LGGjD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 01:39:03 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51429 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351Ab1LGGjC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 01:39:02 -0500
Received: by iakc1 with SMTP id c1so437161iak.19
        for <git@vger.kernel.org>; Tue, 06 Dec 2011 22:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=/Az9HuTGLisXIzC/qBb3dsNWCzRcg2M+ff10JQUr/kc=;
        b=FLN12OlQ2ia7rxIiqbrcX+8h9deOHfEYEjAcTO5WMIGjTVJ64a6pCG2k8X7NiPNUQt
         ZaXoQGRoTlIB6QmN4Ra/tycf3W08JUVKzEM1F4kHhV6j1XWvlVIDbqL2xH6UUDP2DG8d
         mJKRg6h7O+TMlWVix2foVvEO+Cj5qiSLIGmUU=
Received: by 10.231.70.195 with SMTP id e3mr4014577ibj.39.1323239941751;
        Tue, 06 Dec 2011 22:39:01 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id eb23sm3166839ibb.2.2011.12.06.22.38.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Dec 2011 22:39:00 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186425>

Hi,

This is a re-roll of rr/revert-cherry-pick, with Junio's suggestions
($gname/186365) implemented.  My new branch rr/sequencer will be based
on this branch.

Thanks.

Jonathan Nieder (1):
  revert: simplify communicating command-line arguments

Ramkumar Ramachandra (4):
  revert: free msg in format_todo()
  revert: make commit subjects in insn sheet optional
  revert: simplify getting commit subject in format_todo()
  revert: allow mixed pick and revert instructions

 builtin/revert.c                |  225 +++++++++++++++++++--------------------
 sequencer.h                     |    8 ++
 t/t3510-cherry-pick-sequence.sh |   86 +++++++++++++++
 3 files changed, 206 insertions(+), 113 deletions(-)

-- 
1.7.7.3
