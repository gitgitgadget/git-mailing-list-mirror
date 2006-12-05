X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC/PATCH] git-reset to remove "$GIT_DIR/MERGE_MSG"
Date: Tue, 05 Dec 2006 09:36:30 +0100
Message-ID: <45752F8E.9020405@op5.se>
References: <7v4psbknvb.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612050847340.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 5 Dec 2006 08:36:45 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	ltuikov@yahoo.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <Pine.LNX.4.63.0612050847340.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33316>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrVn2-0003hY-LD for gcvg-git@gmane.org; Tue, 05 Dec
 2006 09:36:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967469AbWLEIgd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 03:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968073AbWLEIgd
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 03:36:33 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:55741 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S967469AbWLEIgc (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006
 03:36:32 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id CCD0C6BCC7; Tue,  5 Dec 2006 09:36:30 +0100 (CET)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 4 Dec 2006, Junio C Hamano wrote:
> 
>>  * Marked as RFC because I suspect I am missing a valid use case
>>    where a user might want to say "reset" as part of continuing
>>    the conflicted merge resolution, although I do not think of
>>    any offhand...
> 
> I can only speak for myself, of course: When I use git-reset in a merge, 
> more often than not I use "--hard", in which case I want to try something 
> different. So yes, I like this patch.
> 
> The only possible exception I can think of: git-reset --mixed when a 
> merge failed.
> 

Indeed, but any invocation of git-reset means you'll quite likely have 
to re-do the merge to get all changes anyways.

Like most others, I also use the --hard option most of the times when I 
have merge-errors (usually because I've forgotten to create a 
topic-branch to do my work in, so I create one from 'master', reset 
master to whatever it was last time I pulled and then try rebase'ing on 
to it).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
