X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Wink Saville <wink@saville.com>
Subject: Re: How-to revert a locally modified file
Date: Thu, 30 Nov 2006 22:20:52 -0800
Message-ID: <456FC9C4.5040405@saville.com>
References: <456FBC63.5090609@saville.com> <7v4psgduzg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 06:21:33 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
In-Reply-To: <7v4psgduzg.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32854>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq1lv-0003Es-Mc for gcvg-git@gmane.org; Fri, 01 Dec
 2006 07:21:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759111AbWLAGUt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 01:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759125AbWLAGUt
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 01:20:49 -0500
Received: from 70-91-206-233-BusName-SFBA.hfc.comcastbusiness.net
 ([70.91.206.233]:60635 "EHLO saville.com") by vger.kernel.org with ESMTP id
 S1759111AbWLAGUs (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006
 01:20:48 -0500
Received: from [192.168.0.52] (unknown [192.168.0.52]) by saville.com
 (Postfix) with ESMTP id 0466657A6F; Thu, 30 Nov 2006 22:16:52 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Wink Saville <wink@saville.com> writes:
> 
> 
> Where did you find 0.99.7 ToDo?  I am curious...

here: http://kerneltrap.org/node/5678

> 
>     git-checkout: revert specific paths to either index or a given tree-ish.
>     
>     When extra paths arguments are given, git-checkout reverts only those
>     paths to either the version recorded in the index or the version
>     recorded in the given tree-ish.
>     

FYI the above seems more obvious then what's in the man page:

"It updates the named paths in the working tree from the
index file (i.e. it runs git-checkout-index -f -u)."

But for me saying something like;

"It reverts the paths in the working tree to the most recent version stored in git."

would even be better. It may not be as precise as the current sentence,
but more obvious to this neophyte. Finally, in the EXAMPLES you
might add another example of reverting a "modified the file" as
well as recovering a deleted file.

In any case thanks,

