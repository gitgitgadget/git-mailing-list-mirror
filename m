X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: linux@horizon.com
Subject: Re: Feature request: git-pull -e/--edit
Date: 19 Nov 2006 21:43:08 -0500
Message-ID: <20061120024308.18620.qmail@science.horizon.com>
References: <7vy7q67tf2.fsf@assigned-by-dhcp.cox.net>
NNTP-Posting-Date: Mon, 20 Nov 2006 02:43:32 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vy7q67tf2.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31879>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Glz7u-0003Rm-Ku for gcvg-git@gmane.org; Mon, 20 Nov
 2006 03:43:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933846AbWKTCnL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 21:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933867AbWKTCnL
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 21:43:11 -0500
Received: from science.horizon.com ([192.35.100.1]:39218 "HELO
 science.horizon.com") by vger.kernel.org with SMTP id S933846AbWKTCnK (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 21:43:10 -0500
Received: (qmail 18621 invoked by uid 1000); 19 Nov 2006 21:43:08 -0500
To: junkio@cox.net, linux@horizon.com
Sender: git-owner@vger.kernel.org

> How often is this desired, when the merge is clean?  

Well, if I could quote your own words:

>> I use "git pull . topicA topicB" for a tetrapus, so that is not
>> a reason for me, but when a topicA's older parts are worthy to
>> be in 'next' while later parts are not yet, I often do (on 'next'):
>> 
>>	git merge "Merge early part of branch 'topicA'" HEAD topicA~3

I can't speak from personal experience, but a merge can bring in a lot
of changes, and sometimes the auto-generated message doesn't say quite
as much as you'd like.

The commits on the branch speak for themselves, of course, but sometimes
it's nice to add the same sort of overview that appears in a [PATCH 0/13]
e-mail.  We wouldn't have that convention if there wasn't a frequent
desire for it.

(Indeed, it might be nice to come up with a way of including a piece of
the "please pull" e-mail, similar to the way that git-applypatch works.)

> If the answer is "not so often", you can already use "commit
> --amend" after "pull" creates an automated merge commit.

It's not done very often right now, but how much of that is due to
the awkwardness?  I agree it works perfectly, but "commit --amend"
has very much the feel of a workaround.

I'm not going to besiege Troy for a decade over the idea, but it seemed
