X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: [BUG] making docs blows up in b1bfcae438ad:git-merge-file.txt
Date: 16 Dec 2006 15:41:34 -0800
Message-ID: <86y7p7cssx.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 16 Dec 2006 23:41:49 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
x-mayan-date: Long count = 12.19.13.16.3; tzolkin = 4 Akbal; haab = 16 Mac
Original-Lines: 21
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34658>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gvj9v-0002ct-Ad for gcvg-git@gmane.org; Sun, 17 Dec
 2006 00:41:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422839AbWLPXlg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 18:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422844AbWLPXlg
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 18:41:36 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:16369 "EHLO
 blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1422839AbWLPXlf (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006
 18:41:35 -0500
Received: from localhost (localhost [127.0.0.1]) by blue.stonehenge.com
 (Postfix) with ESMTP id E3BF78F599 for <git@vger.kernel.org>; Sat, 16 Dec
 2006 15:41:34 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1]) by localhost
 (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP id
 02782-01-95 for <git@vger.kernel.org>; Sat, 16 Dec 2006 15:41:34 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001) id 71BD78F5A8;
 Sat, 16 Dec 2006 15:41:34 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


asciidoc -b xhtml11 -d manpage -f asciidoc.conf git-merge-file.txt
ERROR: manpage document title is mandatory
ERROR: git-merge-file.txt: line 3: title not permitted in sidebar body
ERROR: git-merge-file.txt: line 8: title not permitted in sidebar body
ERROR: git-merge-file.txt: line 15: title not permitted in sidebar body
ERROR: git-merge-file.txt: line 46: title not permitted in sidebar body
ERROR: git-merge-file.txt: line 65: title not permitted in sidebar body
ERROR: git-merge-file.txt: line 79: title not permitted in sidebar body
ERROR: git-merge-file.txt: line 84: title not permitted in sidebar body
ERROR: git-merge-file.txt: line 89: title not permitted in sidebar body
ERROR: git-merge-file.txt: line 92: closing [blockdef-example] delimiter expected
make[1]: *** [git-merge-file.html] Error 1
make: *** [doc] Error 2


-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
