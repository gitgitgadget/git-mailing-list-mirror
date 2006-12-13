X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Florian v. Savigny" <lorian@fsavigny.de>
Subject: Can git be tweaked to work cross-platform, on FAT32?
Date: Wed, 13 Dec 2006 16:58:41 +0100
Message-ID: <0MKwpI-1GuWVF2znk-0006fC@mrelayeu.kundenserver.de>
NNTP-Posting-Date: Wed, 13 Dec 2006 16:03:53 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 11:03:46 EST
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:39e16ec7cf8ca3e7595f9f2370cc61be
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34225>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuWaF-0004yE-73 for gcvg-git@gmane.org; Wed, 13 Dec
 2006 17:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964831AbWLMQDr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 11:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964774AbWLMQDr
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 11:03:47 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:54209 "EHLO
 moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S964831AbWLMQDq (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec
 2006 11:03:46 -0500
Received: from [87.234.143.108] (helo=BERTRANDRUSSELL.teuto.37.de) by
 mrelayeu.kundenserver.de (node=mrelayeu1) with ESMTP (Nemesis), id
 0MKwpI-1GuWVF2znk-0006fC; Wed, 13 Dec 2006 16:58:42 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org



Hi there,

I would like to use git to develop a somewhat larger Perl project
which I would need to test and develop under both Linux and Windows,
i.e. I would need a repository on a FAT32 partition (to my knowledge,
still the only filesystem that can be fully accessed from both OSes -
correct me if I'm wrong) which could be accessed by two compatible git
executables, such that I could switch back and forth.

Before describing how I (unsuccessfully, which is perhaps not
surprising, as I'm C-illiterate) hacked the Makefile to compile two
git siblings, I would like to generally ask whether this is possible
at all (or should be possible in theory, in which case I'm willing to
test extensively), whether with Cygwin or not. The preliminary
impression was that the Linux version would not accept a repository on
FAT32 (it did work with more Unixish filesystems). - I do not need the
networking capabilities, BTW (standalone development), if that is an
issue in any way.

Thanks for any hint!

Florian

-- 
                                               Florian von Savigny
__________________________________________________________________
lorian@fsavigny.de
