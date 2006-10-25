X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] document the <tree ish> <file> blob reference syntax
Date: Wed, 25 Oct 2006 13:13:29 -0700
Message-ID: <7vy7r4nogm.fsf@assigned-by-dhcp.cox.net>
References: <38fafea491402334df335c486270ebe9@pinky>
	<7vwt6ob5zc.fsf@assigned-by-dhcp.cox.net>
	<453FBDAA.50305@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 20:13:49 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <453FBDAA.50305@shadowen.org> (Andy Whitcroft's message of "Wed,
	25 Oct 2006 20:40:26 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30099>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gcp82-00061b-NU for gcvg-git@gmane.org; Wed, 25 Oct
 2006 22:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965224AbWJYUNc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 16:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965219AbWJYUNb
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 16:13:31 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:42999 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S1030205AbWJYUNb
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 16:13:31 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061025201330.SESY22409.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>; Wed, 25
 Oct 2006 16:13:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id ekDC1V00n1kojtg0000000 Wed, 25 Oct 2006
 16:13:13 -0400
To: Andy Whitcroft <apw@shadowen.org>
Sender: git-owner@vger.kernel.org

Andy Whitcroft <apw@shadowen.org> writes:

>> +For a more complete list of ways to spell object names, see
>> +"SPECIFYING REVISIONS" section in gitlink:git-rev-parse[1].
>> +
>
> That section seems to have more compresensive descriptions of the
> various definitions of commit-ish, but not a tree-ish.  Specifically,
> there is no mentions of tree-ish:file

  164 * A suffix ':' followed by a path; this names the blob or tree
  165   at the given path in the tree-ish object named by the part
  166   before the colon.

