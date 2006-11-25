X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Teach git-branch howto rename a branch
Date: Sat, 25 Nov 2006 09:53:34 +0100
Organization: At home
Message-ID: <ek9078$m2j$1@sea.gmane.org>
References: <1164409429445-git-send-email-hjemli@gmail.com> <7v1wns6q41.fsf@assigned-by-dhcp.cox.net> <20061125064901.GB4528@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sat, 25 Nov 2006 08:52:23 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 29
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32268>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GntGh-00064f-M4 for gcvg-git@gmane.org; Sat, 25 Nov
 2006 09:52:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757909AbWKYIwM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 03:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757908AbWKYIwM
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 03:52:12 -0500
Received: from main.gmane.org ([80.91.229.2]:5055 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1757909AbWKYIwL (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 03:52:11 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GntGV-000622-DM for git@vger.kernel.org; Sat, 25 Nov 2006 09:52:03 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 25 Nov 2006 09:52:03 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 25 Nov 2006
 09:52:03 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Shawn Pearce wrote:

> Junio C Hamano <junkio@cox.net> wrote:
>> Without -f, it should barf.  With -f, we would want the rename
>> to happen.  In the latter case, I think it should work the same
>> way as deleting it and creating it anew, and that would make
>> sure that reflog for the old one will be lost and a new log is
>> started afresh; otherwise, the log would say old history for
>> that branch and it won't be a "rename" anymore.
> 
> This patch doesn't rename the reflog when the branch renames.
> Myself and a few other users I support want the reflog preserved
> when a branch renames, we all see the reflog as part of the history
> of that branch and a rename is the same branch but stored under a
> different name...

And of course reflog should store the fact of renaming branch.

> I had planned to do a rename branch command myself, but its been
> lower priority than everything else, so I have just never gotten
> around to it.  I'm glad to see someone is attempting it!

I have thought that command to rename branch was created to deal
with simultaneous renaming of reflog + marking rename in reflog.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

