X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Florian Weimer <fw@deneb.enyo.de>
Subject: git-svn: File added multiple times?
Date: Sat, 02 Dec 2006 22:38:00 +0100
Message-ID: <87psb2ou6f.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 2 Dec 2006 21:38:28 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33059>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqcYs-0000yj-7E for gcvg-git@gmane.org; Sat, 02 Dec
 2006 22:38:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424168AbWLBViP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 16:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424169AbWLBViO
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 16:38:14 -0500
Received: from mail.enyo.de ([212.9.189.167]:63506 "EHLO mail.enyo.de") by
 vger.kernel.org with ESMTP id S1424168AbWLBViO (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 16:38:14 -0500
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de) by
 mail.enyo.de with esmtp id 1GqcYm-0007Cj-PF for git@vger.kernel.org; Sat, 02
 Dec 2006 22:38:12 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.63) (envelope-from
 <fw@deneb.enyo.de>) id 1GqcYa-0001Sk-J9 for git@vger.kernel.org; Sat, 02 Dec
 2006 22:38:00 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Is this expected?

$ sort /tmp/git-svn-output | uniq -c | sort -rn | head
      4         A       mlton/trunk/doc/web/papers/index.html
      4         A       mlton/trunk/doc/web/papers/01-icfp.ps.gz
      4         A       mlton/trunk/doc/web/papers/00-esop.ps.gz
      4         A       mlton/trunk/doc/examples/save-world/save-world.sml
      4         A       mlton/trunk/doc/examples/save-world/Makefile
      4         A       mlton/trunk/doc/examples/profiling/profiling.sml
      4         A       mlton/trunk/doc/examples/profiling/Makefile
      4         A       mlton/trunk/doc/examples/ffi/Makefile
      4         A       mlton/trunk/doc/examples/ffi/main.sml
      4         A       mlton/trunk/doc/examples/ffi/ffi.h
$ 

It's somewhat counter-intuitive, at least.  This is with Debian's
