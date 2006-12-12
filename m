X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 12 Dec 2006 09:32:46 +0100
Message-ID: <457E692E.7060708@op5.se>
References: <20061130170625.GH18810@admingilde.org>	 <200612010902.51264.andyparkins@gmail.com>	 <20061201110032.GL18810@admingilde.org> <45701B8D.1030508@b-i-t.de>	 <20061201121234.GQ18810@admingilde.org> <4570289D.9050802@b-i-t.de>	 <20061201133558.GU18810@admingilde.org> <45703174.8000609@op5.se>	 <20061201134610.GW18810@admingilde.org> <457041AD.4010601@op5.se>	 <20061201150045.GZ18810@admingilde.org> <45705A94.2070509@op5.se>	 <Pine.LNX.4.64.0612010844380.3695@woody.osdl.org>	 <457061A7.2000102@b-i-t.de>	 <Pine.LNX.4.64.0612011134080.3695@woody.osdl.org> <1165602554.19135.309.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 08:32:57 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, sf <sf@b-i-t.de>,
	Git List <git@vger.kernel.org>,
	Martin Waitz <tali@admingilde.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <1165602554.19135.309.camel@cashmere.sps.mot.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34068>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu34I-0003yt-Eh for gcvg-git@gmane.org; Tue, 12 Dec
 2006 09:32:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750987AbWLLIct (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 03:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbWLLIct
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 03:32:49 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:53459 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1750987AbWLLIcs (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006
 03:32:48 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 439146BCBE; Tue, 12 Dec 2006 09:32:47 +0100 (CET)
To: Jon Loeliger <jdl@freescale.com>
Sender: git-owner@vger.kernel.org

Jon Loeliger wrote:
> On Fri, 2006-12-01 at 14:13, Linus Torvalds wrote:
> 
>> So this is why it's really important that the submodule really is a git 
>> repository in its own right, and why committing stuff in the supermodule 
>> NEVER affect the submodule itself directly (it might _cause_ you to also 
>> do a commit in the submodule indirectly, but the submodule commit MUST be 
>> totally independent, and stand on its own).
> 
> An implication of this is that the entire administrative
> responsibility for having some super-sub module interaction
> lies entirely with the supermodule.
> 

That's a good thing. I wouldn't want the openssl maintainers to have to 
bother with every project that uses their code, and I'm fairly certain 
they feel the same.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
