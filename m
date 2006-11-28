X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Tue, 28 Nov 2006 14:23:51 +0100
Organization: At home
Message-ID: <ekhd5q$qb1$1@sea.gmane.org>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home> <7vk61gcnzl.fsf@assigned-by-dhcp.cox.net> <7vd5786opj.fsf@assigned-by-dhcp.cox.net> <200611281400.37191.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 28 Nov 2006 13:23:46 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 32
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32521>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp2ve-00014o-07 for gcvg-git@gmane.org; Tue, 28 Nov
 2006 14:23:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758662AbWK1NXP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 08:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758663AbWK1NXP
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 08:23:15 -0500
Received: from main.gmane.org ([80.91.229.2]:25799 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1758662AbWK1NXO (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 08:23:14 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gp2us-0000r4-Tf for git@vger.kernel.org; Tue, 28 Nov 2006 14:22:31 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 14:22:30 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 28 Nov 2006
 14:22:30 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Josef Weidendorfer wrote:

> On Tuesday 28 November 2006 07:59, Junio C Hamano wrote:
>> Once I am done, I can ask "git diff" and expect it to show my
>> local changes I have no intention of committing for now
>> ...
>> 
>> And at that point, I trust "git commit" to do the right thing --
>> the damn thing I just checked with "git diff --cached" _is_ what
>> will be committed.
> 
> I think the difference behavior between "git commit" and "git diff" is
> a little bit confusing.
> 
> Currently, we have
> * "git diff" shows what "git commit -a" would commit
> * "git diff --cached" shows what "git commit" would commit
> 
> IMHO, "git diff" should show what's in the staging area,
> and we should introduce "git diff -a" as a way to see the full
> changes.

I see it in other way. "git diff" tells us if a tree has changed wrt. what
would be committed. It is not a preview of commit.

Also, as of now the version without additional option is a fastest one, both
for diff and for commit.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

