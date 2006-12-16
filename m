X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Florian v. Savigny" <lorian@fsavigny.de>
Subject: Re: Can git be tweaked to work cross-platform, on FAT32?
Date: Sat, 16 Dec 2006 10:51:04 +0100
Message-ID: <0ML25U-1GvWC81sjR-0001UB@mrelayeu.kundenserver.de>
References: <0MKwpI-1GuWVF2znk-0006fC@mrelayeu.kundenserver.de> <46a038f90612132155rc987a9cs6a4fa33dd4c882c6@mail.gmail.com>
NNTP-Posting-Date: Sat, 16 Dec 2006 09:51:27 +0000 (UTC)
Cc: martin.langhoff@gmail.com, Johannes.Schindelin@gmx.de
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <46a038f90612132155rc987a9cs6a4fa33dd4c882c6@mail.gmail.com>
	(martin.langhoff@gmail.com)
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:39e16ec7cf8ca3e7595f9f2370cc61be
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34600>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvWCR-0003Jv-5c for gcvg-git@gmane.org; Sat, 16 Dec
 2006 10:51:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965382AbWLPJvM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 04:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965386AbWLPJvM
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 04:51:12 -0500
Received: from moutng.kundenserver.de ([212.227.126.174]:56378 "EHLO
 moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S965382AbWLPJvK (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec
 2006 04:51:10 -0500
Received: from [87.234.143.108] (helo=bertrandrussell.teuto37.teuto.37.de) by
 mrelayeu.kundenserver.de (node=mrelayeu5) with ESMTP (Nemesis), id
 0ML25U-1GvWC81sjR-0001UB; Sat, 16 Dec 2006 10:51:04 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org



Thank you Martin and Johannes -

before proceeding by following either of your two suggestions, I
would like to make sure that there is no other way, so I would like to
ask:

1. I know, there is absolutely nothing in either of your answers that
   says that the route I conceived is not possible, but anyway: DO
   your answers imply that it is NOT possible (by "possible", I mean
   of course: possible without re-programming the source code ;-)) to
   compile git in a way that would enable it to work DIRECTLY with a
   local repository on FAT32 from both Windows and Linux (or, perhaps
   more simple: to work directly with a repository on FAT32 under
   Linux)?

   I'm repeating my question because it is impossible for me to tell
   whether this would involve a rather simple change (such as: don't
   use symlinks, and/or: don't care about user/group permissions), or
   whether the critical differences are rather an inherent
   characteristic of git, or perhaps even the libraries it uses.

   And: if this were possible, I would consider it a rather attractive
   idea, not only for me, hence I'd like to rule it out before
   dropping it altogether.


2. ad Martin: Ouf! I have no idea of how Samba works (well, yes: I
   thought it was some kind of server or client program permitting to
   connect to Windows servers or clients), hence I don't get a very
   clear idea of what you have in mind. I hope I have made it clear
   that I am using only one computer (double-boot, simply), and that
   everything is local. I am aware that Linux permits to do "virtual"
   networking with localhost, but how would your scheme work on a
   single machine? Can samba "pretend" there is a Windows network
   behind it, while in truth, it accesses a local directory (on
   FAT32)? And can git work directly in a repository it considers to
   be accessible over the network only?

   The interesting thing in this could be that one could use indeed
   the same repository under both OSes. If I got vaguely the right
   idea, that is.

3. ad Johannes: This does sound quite simple and straightforward. If I
   got it right, it would involve having one repository on a, say,
   ext2 partition to work with under Linux, and one on a FAT32
   partition to work with under Windows, and syncing the two after
   booting (fetching from FAT32) and before shutting down (pushing to
   FAT32) Linux.

   It is quite interesting, BTW, that git can /sync/ with a repository
   on FAT32 under Linux, but not work with it.


Thanks very much for both answers! I would still be curious to know
whether there is an answer to my first question, but yours should get
me working one way or other.

Regards, Florian
