From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v5 00/16] GSOC remote-svn
Date: Mon, 20 Aug 2012 23:52:06 +0200
Message-ID: <1345499542-15536-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 23:53:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3Zu9-0007v7-F8
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 23:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755702Ab2HTVw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 17:52:56 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:57659 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755632Ab2HTVwz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 17:52:55 -0400
Received: by wgbdr13 with SMTP id dr13so5688635wgb.1
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 14:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=6QtJvs5Ujy+OaQ94BpMABkRhgCrNrK2GRM28Rq2AMMM=;
        b=Te5BYPzYyjQfT5tLE3CoCZRPmZtkXVsDCPMJcb/QyzaSYQ17S/14VdxaNnqtGgLnkJ
         0yyiwK4PWfcfVmbRMpc3liJfpLKpYveiCjIJNUAhxkyFVb2xK10etL2urlfXrRnr5uHl
         Kxf8Ygtb93BfhQqDf9Vx37HG5alxN0ONQKywB2H4PbAqr1jF+w5yI4x6qjanDm5qGBB+
         YZGxq+JMCrKU6dnXOTrENSQ96iT2u60xq7K3D1RriyUsa0Q3oPAtVR2PH0dcuh7UG3mU
         +fzXhg8YoYGyzYvQPSb4X4StUeAW1bswowX8o8bpnBxih3/9he/8TIim5aFYDCQKXlH1
         MUaw==
Received: by 10.180.80.134 with SMTP id r6mr32186102wix.1.1345499573789;
        Mon, 20 Aug 2012 14:52:53 -0700 (PDT)
Received: from flomedio.lan (91-115-90-54.adsl.highway.telekom.at. [91.115.90.54])
        by mx.google.com with ESMTPS id w7sm30196654wiz.0.2012.08.20.14.52.50
        (version=SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 14:52:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203876>

New version with these changes:

- includes fixups and changes by Junio from fa/remote-svn
- move contrib/svn-fe/remote-svn.c to remote-testsvn.c (in toplevel)
- add it to the toplevel Makefile
  (needed to copy the linker rule, is there a nicer way?)
- check for prerequisite in test script (probably not needed, 
  because it's built automatically now)

 [PATCH v5 01/16] Implement a remote helper for svn in C
 [PATCH v5 02/16] Add git-remote-testsvn to Makefile.
 [PATCH v5 03/16] Add svndump_init_fd to allow reading dumps from
 [PATCH v5 04/16] Add argv_array_detach and argv_array_free_detached
 [PATCH v5 05/16] Connect fast-import to the remote-helper via pipe,
 [PATCH v5 06/16] Add documentation for the 'bidi-import' capability
 [PATCH v5 07/16] When debug==1, start fast-import with "--stats"
 [PATCH v5 08/16] remote-svn, vcs-svn: Enable fetching to private
 [PATCH v5 09/16] Allow reading svn dumps from files via file:// urls
 [PATCH v5 10/16] vcs-svn: add fast_export_note to create notes
 [PATCH v5 11/16] Create a note for every imported commit containing
 [PATCH v5 12/16] remote-svn: Activate import/export-marks for
 [PATCH v5 13/16] remote-svn: add incremental import
 [PATCH v5 14/16] Add a svnrdump-simulator replaying a dump file for
 [PATCH v5 15/16] remote-svn: add marks-file regeneration
 [PATCH v5 16/16] Add a test script for remote-svn
