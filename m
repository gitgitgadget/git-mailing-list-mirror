From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/4] Minor sequencer.c cleanups
Date: Thu, 29 Mar 2012 19:28:11 +0530
Message-ID: <1333029495-10034-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 29 15:58:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDFs3-00070Z-N0
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 15:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932953Ab2C2N63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 09:58:29 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57959 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932807Ab2C2N6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 09:58:24 -0400
Received: by pbcun15 with SMTP id un15so162702pbc.19
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 06:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=x82cCypdzKPBk46VwJE8tpdON0R7dcrIjiLk0IuNwpI=;
        b=Czaiy9gUtMYuDMSLZxbwG84PmRIq7aOw8NNdXx2pgOWTub9a2jWiErHHzvqLRFoPjv
         b3CKWADcVPfwF5Bke3p2vx4H5RenwS87Dag98/3b+2D1Vz8ixa6ZhfdHD8YEl0MtxPqS
         2NjM/KlfUw8j3ZFLnEg2DCRVOX9iUyU9ZReTG9cso30cTg/hn2ci/KrceCC3/7CKuiN1
         iYIRItrw7iyi4itnaHVUy8Zz1g+w98fK6jFF7x16GpCc5VMz5uXob9A3kyjQczyAZK4u
         ROT3rzG6xr9eY5D49NeXEUbnjY0EbLlh76QQOrk3rBL1N3INljyIIsLoq5gOHR99XZpE
         8p2g==
Received: by 10.68.220.137 with SMTP id pw9mr217630pbc.122.1333029503318;
        Thu, 29 Mar 2012 06:58:23 -0700 (PDT)
Received: from localhost.localdomain ([122.174.77.58])
        by mx.google.com with ESMTPS id j3sm5090947pbb.29.2012.03.29.06.58.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Mar 2012 06:58:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194255>

I have a lot of code left over from my work on the sequencer; I'm
slowly rebasing the work and sending out patches.  This series
includes some minor improvements to sequencer.c.  All tests pass.

Thanks for reading.

    Ram

Ramkumar Ramachandra (4):
  sha1_name: introduce getn_sha1() to take length
  revert: use getn_sha1() to simplify insn parsing
  revert: simplify insn parsing logic
  revert: report fine-grained errors from insn parser

 cache.h     |    1 +
 sequencer.c |   64 +++++++++++++++++++++++++++++++++++------------------------
 sha1_name.c |   23 +++++++++++++++++---
 3 files changed, 58 insertions(+), 30 deletions(-)

-- 
1.7.8.1.362.g5d6df.dirty
