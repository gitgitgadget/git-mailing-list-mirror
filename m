X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: cygwin, 44k files: how to commit only index?
Date: Thu, 07 Dec 2006 11:57:40 -0800
Message-ID: <7vhcw7scln.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0612070627r3ff0b394s124d95fbf8084f16@mail.gmail.com>
	<7vd56vtt2g.fsf@assigned-by-dhcp.cox.net>
	<20061207192632.GC12143@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 19:57:49 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061207192632.GC12143@spearce.org> (Shawn Pearce's message of
	"Thu, 7 Dec 2006 14:26:32 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33621>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsPNJ-0002SP-DL for gcvg-git@gmane.org; Thu, 07 Dec
 2006 20:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S938015AbWLGT5m (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 14:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938017AbWLGT5m
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 14:57:42 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:34205 "EHLO
 fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S938015AbWLGT5l (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 14:57:41 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061207195741.YIGF4226.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Thu, 7
 Dec 2006 14:57:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id vvxr1V00R1kojtg0000000; Thu, 07 Dec 2006
 14:57:51 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

>> I am not sure what you are trying.  Do you mean stat() is slow
>> on your filesystem?
>
> Its Cygwin/NTFS.  lstat() is slow.  readdir() is slow.  I have the
> same problem on my Cygwin systems.
>  
>> > Is there any simple way to modify git commit for such a workflow?
>> > Failing that, any simple and _fast_ way to find out if the index
>> > is any different from HEAD? (so that I don't produce empty commits).
>> 
>> Maybe you want "assume unchanged"?
>
> Yes, basically.

Then maybe "git grep assume.unchanged" would help?
