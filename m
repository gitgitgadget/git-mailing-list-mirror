X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: git UI nit
Date: Wed, 06 Dec 2006 15:22:32 +0100
Message-ID: <el6jmt$mej$1@sea.gmane.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 14:22:58 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 24
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33459>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grxfj-0000sM-Gr for gcvg-git@gmane.org; Wed, 06 Dec
 2006 15:22:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760637AbWLFOWx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 09:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760639AbWLFOWw
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 09:22:52 -0500
Received: from main.gmane.org ([80.91.229.2]:45617 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1760637AbWLFOWw
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 09:22:52 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Grxfa-0007A7-AW for git@vger.kernel.org; Wed, 06 Dec 2006 15:22:46 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Wed, 06 Dec 2006 15:22:46 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 06 Dec 2006 15:22:46
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


When merging changes into a dirty working copy, one may get 

..
Updating 62a005d..7bbd698
Makefile: needs update
README: needs update
config.mak.in: needs update
configure.ac: needs update
fatal: Entry 'Makefile' not uptodate. Cannot merge.
..


This is bad error message; "uptodate" suggests that Makefile is too old. 
The problem is the reverse.  The Makefile has been
edited and hence it is 'newer'.  

This message should say 

 Entry 'Makefile' is dirty. 
 Revert or commit changes before merging

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
