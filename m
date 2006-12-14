X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-svnimport breakage as of git-1.4.4
Date: Thu, 14 Dec 2006 13:32:28 -0800
Message-ID: <7vejr217v7.fsf@assigned-by-dhcp.cox.net>
References: <1165505193.26874.13.camel@systems03.lan.brontes3d.com>
	<20061208203230.GA9193@sashak.voltaire.com>
	<1165847230.13854.2.camel@systems03.lan.brontes3d.com>
	<20061211204904.GC1003@sashak.voltaire.com>
	<1166027289.21948.4.camel@systems03.lan.brontes3d.com>
	<20061214022142.GA14521@sashak.voltaire.com>
	<1166130300.21982.0.camel@systems03.lan.brontes3d.com>
	<20061214212033.GG7838@sashak.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 21:32:45 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061214212033.GG7838@sashak.voltaire.com> (Sasha Khapyorsky's
	message of "Thu, 14 Dec 2006 23:20:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34406>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuyBs-0002tO-FJ for gcvg-git@gmane.org; Thu, 14 Dec
 2006 22:32:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932930AbWLNVca (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 16:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932932AbWLNVca
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 16:32:30 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:62568 "EHLO
 fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932930AbWLNVc3 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 16:32:29 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061214213228.IBIV97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Thu, 14
 Dec 2006 16:32:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id ylYf1V0161kojtg0000000; Thu, 14 Dec 2006
 16:32:40 -0500
To: Sasha Khapyorsky <sashak@voltaire.com>
Sender: git-owner@vger.kernel.org

Sasha Khapyorsky <sashak@voltaire.com> writes:

> On 16:05 Thu 14 Dec     , Daniel Drake wrote:
>> On Thu, 2006-12-14 at 04:21 +0200, Sasha Khapyorsky wrote:
>> > Try this please:
>> > 
>> > 
>> > diff --git a/git-svnimport.perl b/git-svnimport.perl
>> > index cbaa8ab..071777b 100755
>> > --- a/git-svnimport.perl
>> > +++ b/git-svnimport.perl
>> 
>> Thanks, it now works for both forms of command line arguments.
>
> Thanks for reporting. I still run git-svnimport against
> http://tortoisesvn.tigris.org/svn/tortoisesvn, works fine up to now.

An applicable version of the patch with proposed commit log
message would be much appreciated.
