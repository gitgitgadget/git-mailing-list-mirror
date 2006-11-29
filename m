X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Joseph Wakeling <joseph.wakeling@webdrake.net>
Subject: git blame [was: git and bzr]
Date: Wed, 29 Nov 2006 13:17:58 +0100
Message-ID: <456D7A76.3080605@webdrake.net>
References: <45357CC3.4040507@utoronto.ca> <20061021130111.GL75501@over-yonder.net> <453F2FF8.2080903@op5.se> <200610251146.06116.jnareb@gmail.com> <a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com> <87slhcz8zh.wl%cworth@cworth.org> <a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com> <7vu01ro20b.fsf@assigned-by-dhcp.cox.net> <a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com> <20061026101038.GA13310@coredump.intra.peff.net> <877iyne4dm.fsf@alplog.fr> <Pine.LNX.4.64.0610260753090.3962@g5.osdl.org> <456B7C6A.80104@webdrake.net> <Pine.LNX.4.64.0611271834090.30076@woody.osdl.org> <456CEF31.8080600@webdrake.net> <Pine.LNX.4.64.0611281906520.3395@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 29 Nov 2006 12:18:22 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
In-Reply-To: <Pine.LNX.4.64.0611281906520.3395@woody.osdl.org>
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32637>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpOOF-0000LH-Tc for gcvg-git@gmane.org; Wed, 29 Nov
 2006 13:18:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966972AbWK2MSJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 07:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967140AbWK2MSJ
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 07:18:09 -0500
Received: from alf.nbi.dk ([130.225.212.55]:14342 "EHLO alf.nbi.dk") by
 vger.kernel.org with ESMTP id S966972AbWK2MSI (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 07:18:08 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) by alf.nbi.dk
 (8.9.3/8.9.3) with ESMTP id NAA16843; Wed, 29 Nov 2006 13:17:59 +0100 (MET)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:
> Now, with small changes, "git blame -C" will just ignore copies entirely, 

Obvious when I think about it, otherwise every 'int i;' in the kernel
would have a huge blame list ... :-O

> I think Junio screwed up at some point. I'll send him a bug-report once 
> I've triaged this a bit more, but I can recreate your breakage if I start 
> a new git database and create two files in the root, and move data between 
> them in the second commit (but if I instead create the second file in the 
> second commit, and do the movement in the third commit, git blame -C works 
> again ;).

Actually my setup was like the latter situation you describe, so blame
was probably working fine and just ignoring the small change.  But
serendipity is a wonderful thing. :-)

    -- Joe
