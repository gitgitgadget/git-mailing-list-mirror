X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add git-count-packs, like git-count-objects.
Date: Sat, 28 Oct 2006 16:28:29 +0200
Organization: At home
Message-ID: <ehvpcs$20j$2@sea.gmane.org>
References: <20061028040056.GA14191@spearce.org> <7v8xj1axlm.fsf@assigned-by-dhcp.cox.net> <20061028065143.GA14607@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sat, 28 Oct 2006 14:28:46 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 31
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-116.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30379>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdpAk-00043U-79 for gcvg-git@gmane.org; Sat, 28 Oct
 2006 16:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752487AbWJ1O20 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 10:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752488AbWJ1O20
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 10:28:26 -0400
Received: from main.gmane.org ([80.91.229.2]:43148 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1752487AbWJ1O20 (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 10:28:26 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GdpAO-0003yb-I9 for git@vger.kernel.org; Sat, 28 Oct 2006 16:28:08 +0200
Received: from host-81-190-18-116.torun.mm.pl ([81.190.18.116]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 28 Oct 2006 16:28:08 +0200
Received: from jnareb by host-81-190-18-116.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 28 Oct 2006
 16:28:08 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Shawn Pearce wrote:

> Junio C Hamano <junkio@cox.net> wrote:
>> Shawn Pearce <spearce@spearce.org> writes:
>> 
>> > Now that we are starting to save packs rather than unpacking into
>> > loose objects its nice to have a way to list the number of current
>> > packs and their total size.  This can help the user in deciding
>> > when its time to run `git repack -a -d`.
>> 
>> Why not just do "ls -lh $GIT_OBJECT_DIR/pack/pack-*.pack"???
> 
> Because whatever we decide to use to make a pack 'active' may not
> be that simple.
> 
> Whatever.  It was clearly a very tiny patch put together quickly
> before dinner tonight, perhaps not worth including at this point.
> Lets see what comes out of the other pack oriented discussion first.

Perhaps to nod add yet another command to already large set, rename
git-count-objects to git-count end enhance it to count both loose objects
and packs (or not, and use git-count-objects name).

BTW what does "garbage:" in git-count-objects -v mean? And in what units
git-count-objects -v returns "size:" (git-count-objects says "kilobytes",
why git-count-objects -v doesn't do the same)?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

