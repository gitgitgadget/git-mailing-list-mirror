X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: latest update to git-svn blows up for me
Date: 04 Dec 2006 12:10:50 -0800
Message-ID: <86odqjl8vp.fsf@blue.stonehenge.com>
References: <863b7wnwcw.fsf@blue.stonehenge.com>
	<20061204070021.GG1369@localdomain>
	<86hcwbnb0o.fsf@blue.stonehenge.com> <20061204181241.GA27342@soma>
	<86zma3lahj.fsf@blue.stonehenge.com> <20061204195452.GB27342@soma>
	<86slfvl95j.fsf@blue.stonehenge.com>
	<20061204200844.GC30316@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 20:11:34 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
x-mayan-date: Long count = 12.19.13.15.11; tzolkin = 5 Chuen; haab = 4 Mac
In-Reply-To: <20061204200844.GC30316@hand.yhbt.net>
Original-Lines: 34
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33238>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrK9m-0005Aw-Pd for gcvg-git@gmane.org; Mon, 04 Dec
 2006 21:11:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966640AbWLDULH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 15:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966611AbWLDULG
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 15:11:06 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:5903 "EHLO
 blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S937362AbWLDULE (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 15:11:04 -0500
Received: from localhost (localhost [127.0.0.1]) by blue.stonehenge.com
 (Postfix) with ESMTP id 521D38F3F6; Mon,  4 Dec 2006 12:10:51 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1]) by localhost
 (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP id
 27297-01-81; Mon,  4 Dec 2006 12:10:50 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001) id 8F0838F3F1;
 Mon,  4 Dec 2006 12:10:50 -0800 (PST)
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

>>>>> "Eric" == Eric Wong <normalperson@yhbt.net> writes:

Eric> "Randal L. Schwartz" <merlyn@stonehenge.com> wrote:
>> >>>>> "Eric" == Eric Wong <normalperson@yhbt.net> writes:
>> 
Eric> Can you try:
>> 
Eric> git update-ref refs/remotes/git-svn \
Eric> <last commit successfully imported from git-svn>
>> 
Eric> and running rebuild again?
>> 
>> Yes, and now after seeing 14000 lines scroll by, I tried again:

Eric> <snip>

>> Anything you want me to try now?  I'm not in a fast net place (at
>> least not for a week), so I can't rebuild from scratch.

Eric> Which version of the SVN libraries are you using?

SVN::Core is 1.4.2  - not sure what distro that comes from.

Eric>   Also, are you
Eric> tracking https://svn.perl.org/parrot/trunk or just
Eric> https://svn.perl.org/parrot (top-level)

http://svn.perl.org/parrot

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
