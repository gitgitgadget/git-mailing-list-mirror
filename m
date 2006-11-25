X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Show remote branches on gitweb
Date: Fri, 24 Nov 2006 17:04:07 -0800
Message-ID: <7vu00o8hh4.fsf@assigned-by-dhcp.cox.net>
References: <loom.20061124T210559-701@post.gmane.org>
	<ek7jsp$j83$1@sea.gmane.org> <ek7m6m$qqd$1@sea.gmane.org>
	<20061124235911.GO7201@pasky.or.cz>
	<7vy7q08iko.fsf@assigned-by-dhcp.cox.net>
	<20061125005029.GN4842@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 25 Nov 2006 01:04:36 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061125005029.GN4842@pasky.or.cz> (Petr Baudis's message of
	"Sat, 25 Nov 2006 01:50:29 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32252>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gnlxo-0005jr-Ke for gcvg-git@gmane.org; Sat, 25 Nov
 2006 02:04:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935110AbWKYBEJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 20:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935111AbWKYBEJ
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 20:04:09 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:43905 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S935110AbWKYBEI
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 20:04:08 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061125010408.OSPM97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Fri, 24
 Nov 2006 20:04:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id qp4F1V00l1kojtg0000000; Fri, 24 Nov 2006
 20:04:16 -0500
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

>> > Does that mean we _can_ parse $GIT_DIR/remotes? ;-)
>> 
>> Surely you should be able to.  You are working in Perl and the
>> remotes and config are trivially parsable text files.
>
> But so is the configuration file, unless I'm missing something...?

I do not think you are missing anything.  I said that remotes
and config are simple trivially parsable text files and Perl
should be a pleasant tool to read them with.

So yes, we _can_ parse them, and we _can_ parse configuration
file.

Unless I'm missing something...?

