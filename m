From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v6 01/16] GSOC remote-svn
Date: Wed, 22 Aug 2012 21:15:45 +0200
Message-ID: <1345662961-9587-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 21:16:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4GPu-00019Y-Uw
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 21:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992Ab2HVTQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 15:16:32 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46610 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964976Ab2HVTQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 15:16:29 -0400
Received: by bkwj10 with SMTP id j10so449679bkw.19
        for <git@vger.kernel.org>; Wed, 22 Aug 2012 12:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Z+00RYmAv/Y2rMNB+rboC93NqyP+kNoT14MtwrOy5YE=;
        b=H/WSxsJt8oYR3anLkcb8y4X4qkNCMu7e2tbh4pXqQWovbTCQL7M4DUQ3UIc3Q9YSRw
         lV5WdGoRM7Hh2tp+eOJ2nirb5HKd6aHP3oh3G1lWbh/m3SFC+Zm9/gbt0zjwkKl5guar
         /UIwjK+dZAfzVCNj/QK+k0INoRDHeO8YJG/h+LwgnOHfb65RKe1p/PZJVMAz9LEZ0lPR
         5q2jArvyF46OS04FsCHSjasBbveoJePoP7gDK6XEeBea0n1WiBCgcvMpkX+Ms48yoL22
         exUk7m1UezKPbJ3fXxQCxMo+1HDqUb5zyXsjK3DExrClc9kCEGCQqSUws4VXtticW5uO
         +bGg==
Received: by 10.204.130.151 with SMTP id t23mr7119260bks.94.1345662988491;
        Wed, 22 Aug 2012 12:16:28 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id ht18sm3346763bkc.16.2012.08.22.12.16.25
        (version=SSLv3 cipher=OTHER);
        Wed, 22 Aug 2012 12:16:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204068>

Another improved series with fixups by Junio, and a little by me.
Diff:
- fix inconsistend indent in Documentation/git-remote-helpers.txt
- remove trailing newline in Makefile
- fix argument list and usage of regenerate_marks(void) in remote-svn.c


[PATCH v6 01/16] Implement a remote helper for svn in C
[PATCH v6 02/16] Add git-remote-testsvn to Makefile
[PATCH v6 03/16] Add svndump_init_fd to allow reading dumps from
[PATCH v6 04/16] Add argv_array_detach and argv_array_free_detached
[PATCH v6 05/16] Connect fast-import to the remote-helper via pipe,
[PATCH v6 06/16] Add documentation for the 'bidi-import' capability
[PATCH v6 07/16] When debug==1, start fast-import with "--stats"
[PATCH v6 08/16] remote-svn, vcs-svn: Enable fetching to private
[PATCH v6 09/16] Allow reading svn dumps from files via file:// urls
[PATCH v6 10/16] vcs-svn: add fast_export_note to create notes
[PATCH v6 11/16] Create a note for every imported commit containing
[PATCH v6 12/16] remote-svn: Activate import/export-marks for
[PATCH v6 13/16] remote-svn: add incremental import
[PATCH v6 14/16] Add a svnrdump-simulator replaying a dump file for
[PATCH v6 15/16] remote-svn: add marks-file regeneration
[PATCH v6 16/16] Add a test script for remote-svn
