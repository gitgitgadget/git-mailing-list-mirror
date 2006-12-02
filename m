X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] git-add update with all-0 object
Date: Sat, 02 Dec 2006 09:26:43 +0100
Organization: At home
Message-ID: <ekrd8b$re8$1@sea.gmane.org>
References: <Pine.LNX.4.64.0611301634080.20138@iabervon.org> <Pine.LNX.4.64.0611301431420.3513@woody.osdl.org> <Pine.LNX.4.64.0611301749450.20138@iabervon.org> <20061201045727.GA22622@thunk.org> <Pine.LNX.4.64.0612010223010.20138@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sat, 2 Dec 2006 08:25:27 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 17
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33006>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqQBW-0000Hs-GI for gcvg-git@gmane.org; Sat, 02 Dec
 2006 09:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162827AbWLBIZN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 03:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162833AbWLBIZM
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 03:25:12 -0500
Received: from main.gmane.org ([80.91.229.2]:21147 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1162827AbWLBIZL (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 03:25:11 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GqQB8-0000Ed-Gs for git@vger.kernel.org; Sat, 02 Dec 2006 09:24:58 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 02 Dec 2006 09:24:58 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 02 Dec 2006
 09:24:58 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Daniel Barkalow wrote:

> Of course, we'd still have to disabuse people of the notion that the index 
> can store the information "there's nothing at this path yet, but I'm 
> interested in it", because that's a piece of information people often know 
> before a file is ready, and think git would be able to remember in a 
> staging area.

Well, that was what about the first message in this thread about. Marking
a file "interesting" (so 'git commit -a' would pick it up) using all-0
for object hash... which of course requires review and if necessary
modification of all core tools which touch the index.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

