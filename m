X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Rogan Dawes <discard@dawes.za.net>
Subject: Re: Ignoring local changes
Date: Thu, 14 Dec 2006 23:27:48 +0200
Message-ID: <4581C1D4.7080102@dawes.za.net>
References: <loom.20061214T171948-279@post.gmane.org> <45817F8A.3050701@op5.se> <9e7ab7380612140855p1f4ee6c1l5ef24c4d1d169da6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 21:49:36 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 1202 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 16:49:09 EST
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <9e7ab7380612140855p1f4ee6c1l5ef24c4d1d169da6@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34410>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuySH-0005DW-Kh for gcvg-git@gmane.org; Thu, 14 Dec
 2006 22:49:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964834AbWLNVtM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 16:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWLNVtL
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 16:49:11 -0500
Received: from sumo.dreamhost.com ([66.33.216.29]:57113 "EHLO
 sumo.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S964851AbWLNVtJ (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 16:49:09 -0500
Received: from spunkymail-a14.dreamhost.com (sd-green-bigip-202.dreamhost.com
 [208.97.132.202]) by sumo.dreamhost.com (Postfix) with ESMTP id 709D417B928
 for <git@vger.kernel.org>; Thu, 14 Dec 2006 13:29:06 -0800 (PST)
Received: from [192.168.201.101] (dsl-146-25-01.telkomadsl.co.za
 [165.146.25.1]) by spunkymail-a14.dreamhost.com (Postfix) with ESMTP id
 1EA7F190E26; Thu, 14 Dec 2006 13:27:57 -0800 (PST)
To: Pazu <pazu@pazu.com.br>
Sender: git-owner@vger.kernel.org

Pazu wrote:
> 2006/12/14, Andreas Ericsson <ae@op5.se>:
> 
>> Correction: I just tested this, and while git-add won't touch the file,
>> git-update-index will, and git-status still shows it as modified.
> 
> Yes, and that's exactly my problems. There are a number of
> modified/removed files in my working copy that were previously added
> to the repository, and git-status shows them as modified/removed, even
> when they're listed in .gitignore or .git/info/exclude
> 
>> This feels like a bug to me.
> 
> Dunno, sounds like this is by design. I acknowledge that my situation
> is unusual, and most often, you'll want to always track a file once
> it's been added to the repository.
> 
> -- Pazu

Why not remove it from the repo, then set .gitignore?

If it is generated code, or compiled code, it probably shouldn't be in 
the repo in the first place . . . Simply correct that mistake, and you 
are good to go.

