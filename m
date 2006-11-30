X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Unprivileged User
Date: Thu, 30 Nov 2006 01:39:18 -0800
Message-ID: <7vwt5djmt5.fsf@assigned-by-dhcp.cox.net>
References: <2b9545a0611292154r4334d1afn1f49bbd3be2c3374@mail.gmail.com>
	<ekm6si$psp$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 30 Nov 2006 09:39:33 +0000 (UTC)
Cc: jnareb@gmail.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <ekm6si$psp$1@sea.gmane.org> (Jakub Narebski's message of "Thu,
	30 Nov 2006 10:07:13 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32714>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpiO6-00016a-2V for gcvg-git@gmane.org; Thu, 30 Nov
 2006 10:39:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933340AbWK3JjV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 04:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933351AbWK3JjV
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 04:39:21 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:20218 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S933340AbWK3JjU
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 04:39:20 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061130093919.YOAM296.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Thu, 30
 Nov 2006 04:39:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id sxfU1V00H1kojtg0000000; Thu, 30 Nov 2006
 04:39:29 -0500
To: Ed <ed.since.06@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Ed wrote:
>
>> From gitweb it says that my git project's owner is: Unprivileged User
> ...
> Actually gitweb uses uid/user the repository (the $GIT_DIR), unless you
> provide it with an index file.

This is a shot in the dark, but by any chance is this repository
owned by nobody, which is mapped to "Unprivileged User" by
/etc/passwd?  Googling for "Unprivileged User" and "getpwent"
tells me that on OSX boxes nobody seems to map to that Gecos
name.

To explicitly set the names of list of projects and their
owners, set up $projects_list text file.  A hint for its format
is found around line 1111 in gitweb/gitweb.perl script.

Hopefully somebody has documentation for gitweb configuration
so that people do not have to refer to the source to find things
out, but I do not know of a URL offhand...


