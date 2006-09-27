From: Andreas Ericsson <ae@op5.se>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 16:29:45 +0200
Message-ID: <451A8AD9.2010107@op5.se>
References: <20060927140918.65775.qmail@web51004.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 27 16:30:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSaQ5-0008TO-R2
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 16:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWI0O3s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 10:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWI0O3s
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 10:29:48 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:11452 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932326AbWI0O3s
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 10:29:48 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id DC8BF6BD4F; Wed, 27 Sep 2006 16:29:46 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.4
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 9815E6BCDC; Wed, 27 Sep 2006 16:29:45 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: Matthew L Foster <mfoster167@yahoo.com>
In-Reply-To: <20060927140918.65775.qmail@web51004.mail.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27906>

Matthew L Foster wrote:
> How can git be
> said to keep an accurate record of history if time is uncertain?
> 

Because git doesn't care about timestamps. It stores them as comments 
(albeit auto-formatted comments) and relies on the dependency chain to 
provide history.

In the same way that contributors are expected to write clear and 
concise commit-messages, they are also expected to keep their system 
clocks somewhat in sync. Sometimes one or the other fails, and this is 
as inevitable as it can be annoying (although commit-messages along the 
line of "fixed some bugs causing some random crashes" for a commit that 
touches 2384 lines are indefinitely worse than a bad timestamp).

What's beautiful about git is that it's designed to present a correct 
history even if random-contributor-X's system clock is out of sync with 
the rest of the world, as it inevitably will be at one point or another. 
It handles content, and the order in which each piece of content was 
added/removed/mutilated/transformed into something else, and it does a 
good job at that.

All that aside though, would you rather have that fix pronto with a bad 
timestamp, or three days later when the contributor had time to set up 
ntp properly?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
