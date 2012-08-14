From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH/RFC v3 00/16] GSOC remote-svn
Date: Tue, 14 Aug 2012 21:13:02 +0200
Message-ID: <1344971598-8213-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 21:16:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1Mb3-0001dc-Sm
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 21:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755870Ab2HNTPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 15:15:39 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53159 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755774Ab2HNTPe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 15:15:34 -0400
Received: by bkwj10 with SMTP id j10so265180bkw.19
        for <git@vger.kernel.org>; Tue, 14 Aug 2012 12:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=h7UE2a0jFAfFDTvWzFHlTRaH9Mf7lHEDhWHAnNfhU+c=;
        b=Y9H+u5ULvFd9/V6cZks2+TziE42d+5M6Od+1mTXhRIMVbe09xNTSgghGnyWHT42yyD
         h6448QXgw5JdcUxGIWzO/dzcqFo8wbe9BDGwLQp2HPZ61hVzbZowOrov6f6kFp671H5o
         oo6BlsQtryzgTexTedg7QwaS/DpEpDathjI1ACkxaCW3lZQaE1gcIi2vhidu5lbA55u5
         l4IMyE+YkK3aATFDPEBq3x72sRuVlvC+lZlb9haiUEF/65srXFgiMAOEdHJy8bIjDoxv
         s6211MPcq59Dz7f/NrnyPwjPrVIRC8va5AiXCZSzlVDl5VyzNmPwj6XSdnVHZ7JU/WhJ
         xuEw==
Received: by 10.205.130.17 with SMTP id hk17mr6989881bkc.76.1344971732969;
        Tue, 14 Aug 2012 12:15:32 -0700 (PDT)
Received: from localhost.localdomain (089144206125.atnat0015.highway.a1.net. [89.144.206.125])
        by mx.google.com with ESMTPS id fu8sm1681583bkc.5.2012.08.14.12.15.26
        (version=SSLv3 cipher=OTHER);
        Tue, 14 Aug 2012 12:15:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203424>

Hi.

Version 3 of this series adds the 'bidi-import' capability, as suggested
Jonathan. 
Diff details are attached to the patches.
04 and 05 are completely new.

[PATCH/RFC v3 01/16] Implement a remote helper for svn in C.
[PATCH/RFC v3 02/16] Integrate remote-svn into svn-fe/Makefile.
[PATCH/RFC v3 03/16] Add svndump_init_fd to allow reading dumps from
[PATCH/RFC v3 04/16] Connect fast-import to the remote-helper via
[PATCH/RFC v3 05/16] Add documentation for the 'bidi-import'
[PATCH/RFC v3 06/16] remote-svn, vcs-svn: Enable fetching to private
[PATCH/RFC v3 07/16] Add a symlink 'git-remote-svn' in base dir.
[PATCH/RFC v3 08/16] Allow reading svn dumps from files via file://
[PATCH/RFC v3 09/16] vcs-svn: add fast_export_note to create notes
[PATCH/RFC v3 10/16] Create a note for every imported commit
[PATCH/RFC v3 11/16] When debug==1, start fast-import with "--stats"
[PATCH/RFC v3 12/16] remote-svn: add incremental import.
[PATCH/RFC v3 13/16] Add a svnrdump-simulator replaying a dump file
[PATCH/RFC v3 14/16] transport-helper: add import|export-marks to
[PATCH/RFC v3 15/16] remote-svn: add marks-file regeneration.
[PATCH/RFC v3 16/16] Add a test script for remote-svn.
