X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Move git_get_last_activity subroutine earlier
Date: Sat, 28 Oct 2006 12:24:48 -0700
Message-ID: <7v3b988cqn.fsf@assigned-by-dhcp.cox.net>
References: <200610281943.40456.jnareb@gmail.com>
	<7vvem48dsr.fsf@assigned-by-dhcp.cox.net> <ei0ags$l1l$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 28 Oct 2006 19:25:13 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <ei0ags$l1l$1@sea.gmane.org> (Jakub Narebski's message of "Sat,
	28 Oct 2006 21:20:46 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30393>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdtnZ-00080l-Mr for gcvg-git@gmane.org; Sat, 28 Oct
 2006 21:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964859AbWJ1TYu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 15:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbWJ1TYu
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 15:24:50 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:48097 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S964859AbWJ1TYt
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 15:24:49 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061028192449.GDAL6077.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Sat, 28
 Oct 2006 15:24:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id fvQt1V00C1kojtg0000000 Sat, 28 Oct 2006
 15:24:53 -0400
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> Why is this needed?
>  
> This is purely cosmetic, and originally was to be first patch in series
> converting git_summary, git_heads and git_tags to use of git-for-each-ref...
> but unfortunately git-for-each-ref lacks sorting on taggerdate OR
> committerdate (i.e. use taggerdate if applicable, committerdate otherwise).
>
> I'd rather not have git_get_last_activity between two parse_* subroutines...

Ok, will apply but the last line of your response _should_ have
been in the proposed commit log message without being asked.

