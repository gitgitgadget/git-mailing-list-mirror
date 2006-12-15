X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's in git.git (stable)
Date: Fri, 15 Dec 2006 16:38:54 +0100
Organization: At home
Message-ID: <elufdn$jqt$1@sea.gmane.org>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <20061214114546.GI1747@spearce.org> <7v4pry16n5.fsf@assigned-by-dhcp.cox.net> <200612142250.27766.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 15 Dec 2006 15:36:50 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 30
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34519>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvF71-0002tY-JY for gcvg-git@gmane.org; Fri, 15 Dec
 2006 16:36:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752748AbWLOPgh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 10:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752749AbWLOPgh
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 10:36:37 -0500
Received: from main.gmane.org ([80.91.229.2]:55885 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1752748AbWLOPgg
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006 10:36:36 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GvF6u-0004EE-Oa for git@vger.kernel.org; Fri, 15 Dec 2006 16:36:32 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 16:36:32 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 15 Dec 2006
 16:36:32 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:

> On Thursday 2006, December 14 21:58, Junio C Hamano wrote:
> 
>> Correct but a bad example that does not demonstrate the real
>> power of reflog.  Andy's AGGGHHHHHH can be recovered with a
>> simple:
>>
>>      $ git reset ORIG_HEAD
> 
> HAHA!  I knew reading this mailing list would pay off.
> 
> It amazes me that there is always an answer.  It's almost becoming a 
> pantomime - I say "well git can't do this", and you say "oh yes it can".

And it is mentioned in git-reset(1), although:

 * it would be nice to have example with ORIG_HEAD about how
   to recover from bad (wrong) git reset in EXAMPLES section.

 * it would be nice to mention that the first example can
   be now done with simply "edit; git commit -a --amend"
   instead of "git reset --soft HEAD^; edit; git commit -a -c ORIG_HEAD"
   (which can fail for merges).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

