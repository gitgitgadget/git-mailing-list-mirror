X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git fetch --reference?
Date: Tue, 14 Nov 2006 17:49:58 -0800
Message-ID: <7vu011tr5l.fsf@assigned-by-dhcp.cox.net>
References: <f2b55d220611141638k5f4a0aeas1a43301e4b40bf59@mail.gmail.com>
	<7vy7qdttc0.fsf@assigned-by-dhcp.cox.net>
	<f2b55d220611141717r4507c9demddb1cf872dbee073@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 01:51:07 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <f2b55d220611141717r4507c9demddb1cf872dbee073@mail.gmail.com>
	(Michael K. Edwards's message of "Tue, 14 Nov 2006 17:17:04 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31402>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk9ui-0006nU-Nn for gcvg-git@gmane.org; Wed, 15 Nov
 2006 02:50:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966444AbWKOBuD (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 20:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966624AbWKOBuA
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 20:50:00 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:20190 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S966444AbWKOBt7
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 20:49:59 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061115014958.OQYO18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Tue, 14
 Nov 2006 20:49:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id mpq41V0131kojtg0000000; Tue, 14 Nov 2006
 20:50:05 -0500
To: "Michael K. Edwards" <medwards.linux@gmail.com>
Sender: git-owner@vger.kernel.org

"Michael K. Edwards" <medwards.linux@gmail.com> writes:

> On 11/14/06, Junio C Hamano <junkio@cox.net> wrote:
>> I am somewhat doubtful that this is common enough to warrant
>> adding an extra option to "git fetch", but you could add
>> alternates to these new reference object stores before
>> initiating the fetch.
>> ...
>
> Thanks, that's what I was looking for.  I can just set up a "tracking"
> tree where I don't attempt any merges, include it in the alternates
> for each working tree, and "git fetch" in the tracking tree when it's
> convenient.  Now, will tags from the tracking tree propagate into the
> working trees?

For the working trees, if you "fetch" from the tracking tree
using short-hand, just like you "fetch" from the origin using
short-hand, tags will be followed, I think.

