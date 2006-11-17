X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Atom feeds
Date: Fri, 17 Nov 2006 01:01:05 -0800
Message-ID: <7v4psysazy.fsf@assigned-by-dhcp.cox.net>
References: <11635494363452-git-send-email-asf@boinkor.net>
	<ejdmlb$77s$1@sea.gmane.org> <ejim5q$31b$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 09:01:21 +0000 (UTC)
Cc: git@vger.kernel.org, Andreas Fuchs <asf@boinkor.net>,
	Petr Baudis <pasky@suse.cz>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <ejim5q$31b$1@sea.gmane.org> (Andreas Fuchs's message of "Thu, 16
	Nov 2006 22:45:25 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31677>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gkzb1-000131-25 for gcvg-git@gmane.org; Fri, 17 Nov
 2006 10:01:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755544AbWKQJBH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 04:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755545AbWKQJBH
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 04:01:07 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:55772 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S1755544AbWKQJBG
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 04:01:06 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061117090105.YCKS4817.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>; Fri, 17
 Nov 2006 04:01:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id nl1C1V0021kojtg0000000; Fri, 17 Nov 2006
 04:01:12 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Andreas Fuchs <asf@boinkor.net> writes:

> Jakub Narebski wrote:
>> Andreas Fuchs <asf@boinkor.net> wrote:
>> 
>>> * Wrap the commit message in <pre>
>> We use <div class="pre"> in "commit" view if I remember correctly.
>
> That's ok for rendered HTML output, but in my experience, the way feed
> readers interpret that ranges from "badly" to "not at all"; it's better
> to stick to explicit structure hints only in feeds. /-:
>
> So, this is the only thing I haven't fixed in the attached patch (:
> ...
> In addition to the above points, the attached patch emits a
> Last-Changed: HTTP response header field, and doesn't compute the feed
> body if the HTTP request type was HEAD. This helps keep the web server
> load down for well-behaved feed readers that check if the feed needs
> updating.
>
> Hope you like it,

Seems sane to me.  Jakub, how do you like this one?  If it looks
Ok to you, please arrange to include your one-liner that this
depends on and forward a readily applicable patch with
appropriate commit log message.


