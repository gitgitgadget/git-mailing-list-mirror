From: Andreas Ericsson <ae@op5.se>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 10:42:52 +0200
Message-ID: <451A398C.3060800@op5.se>
References: <20060926233321.GA17084@coredump.intra.peff.net>	<20060927002745.15344.qmail@web51005.mail.yahoo.com> <7vodt2nmft.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthew L Foster <mfoster167@yahoo.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 27 10:43:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSV0e-0007lm-Qw
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 10:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWI0Im7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 04:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbWI0Im7
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 04:42:59 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:15533 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750864AbWI0Im6
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 04:42:58 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id B07846BD7E; Wed, 27 Sep 2006 10:42:56 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.4
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 44FEE6BD7C; Wed, 27 Sep 2006 10:42:53 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vodt2nmft.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27892>

Junio C Hamano wrote:
> Matthew L Foster <mfoster167@yahoo.com> writes:
> 
>>> PS Nit: Git doesn't work with changesets, it works with snapshots,
>>> building a directed graph of snapshots. Maybe that is the source of your
>>> confusion
>> It's true I don't know much about git, what is the difference
>> between a changeset and a snapshot?  Are you saying timestamps
>> should be tracked separately or tracked by an scm system built
>> on top of git? Does/should git care about the when of a
>> snapshot?
> 
> I do not know what Jeff meant by snapshot vs changeset, so I
> would not comment on this part.
> 

Me neither, but I've seen this distinction before on the mailing-list.

To my mind, a changeset is the patch that brings some form of data from 
one state (snapshot) to another. In this respect, git is certainly both 
snapshot- and changeset-based.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
