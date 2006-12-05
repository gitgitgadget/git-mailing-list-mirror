X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: latest update to git-svn blows up for me
Date: 04 Dec 2006 20:19:41 -0800
Message-ID: <86slfvj7oi.fsf@blue.stonehenge.com>
References: <863b7wnwcw.fsf@blue.stonehenge.com>
	<20061204070021.GG1369@localdomain>
	<86hcwbnb0o.fsf@blue.stonehenge.com> <20061204181241.GA27342@soma>
	<86zma3lahj.fsf@blue.stonehenge.com> <20061204195452.GB27342@soma>
	<86slfvl95j.fsf@blue.stonehenge.com>
	<20061204200844.GC30316@hand.yhbt.net>
	<86odqjl8vp.fsf@blue.stonehenge.com>
	<20061204205126.GA23853@hand.yhbt.net>
	<20061205040844.GA6826@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 04:19:59 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
x-mayan-date: Long count = 12.19.13.15.11; tzolkin = 5 Chuen; haab = 4 Mac
In-Reply-To: <20061205040844.GA6826@localdomain>
Original-Lines: 28
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33298>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrRmd-0005Ms-9d for gcvg-git@gmane.org; Tue, 05 Dec
 2006 05:19:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968326AbWLEETo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 23:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968327AbWLEETo
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 23:19:44 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:12500 "EHLO
 blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S968326AbWLEETn (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 23:19:43 -0500
Received: from localhost (localhost [127.0.0.1]) by blue.stonehenge.com
 (Postfix) with ESMTP id A9C658FFA5; Mon,  4 Dec 2006 20:19:42 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1]) by localhost
 (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP id
 04620-01-28; Mon,  4 Dec 2006 20:19:41 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001) id BE2758FFB2;
 Mon,  4 Dec 2006 20:19:41 -0800 (PST)
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

>>>>> "Eric" == Eric Wong <normalperson@yhbt.net> writes:

Eric> Eric Wong <normalperson@yhbt.net> wrote:
>> Same here..  I'm still waiting for it to fetch and will try to reproduce
>> it here.

Eric> Update: Nearly 16k revisions later and I still can't reproduce this on
Eric> my computer.

I still say it was odd that it happened exactly when I did a git-svn
update in the other window. :)

So, maybe I'll just toss this archive.  Oh wait, can I back it up a few dozen
revs and try to roll forward?  That might be interesting.

git-reset --hard HEAD~10
blow away everything you had me blow away last time
make git-svn equal to HEAD
git-svn rebuild
git-svn fetch

Lemme try that.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
