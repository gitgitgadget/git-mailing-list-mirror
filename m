From: Andreas Ericsson <ae@op5.se>
Subject: Re: [BUG] daemon.c blows up on OSX
Date: Wed, 03 Jan 2007 16:25:38 +0100
Message-ID: <459BCAF2.1080002@op5.se>
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>	<86vek6z0k2.fsf@blue.stonehenge.com>	<Pine.LNX.4.64.0612201412250.3576@woody.osdl.org>	<86irg6yzt1.fsf_-_@blue.stonehenge.com>	<7vr6uu6w8e.fsf@assigned-by-dhcp.cox.net>	<86ejquyz4v.fsf@blue.stonehenge.com>	<86ac1iyyla.fsf@blue.stonehenge.com>	<Pine.LNX.4.64.0612201502090.3576@woody.osdl.org>	<86wt4mximh.fsf@blue.stonehenge.com>	<Pine.LNX.4.64.0612201524230.3576@woody.osdl.org>	<caf068570612201636g75180138r223aef7c42f69a50@mail.gmail.com> <7vtzzq3wo6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Terje Sten Bjerkseth <terje@bjerkseth.org>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 03 16:25:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H27zs-0005Dt-2X
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 16:25:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbXACPZl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 10:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbXACPZk
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 10:25:40 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:38084 "EHLO
	smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbXACPZk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 10:25:40 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id E034A6BCC4; Wed,  3 Jan 2007 16:25:38 +0100 (CET)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vtzzq3wo6.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35872>

Junio C Hamano wrote:
> 
> Does everybody use Apple CC on OSX?  Is the symbol defined even
> with GCC?  Or Gcc fixes headers well enough and makes this a
> non-issue?
> 

Just for future reference

http://predef.sourceforge.net/preos.html

holds a pretty complete list of identifying macros for more kinds of 
systems than I've had the questionable privilege of having to work with. 
I've used it pretty extensively when trying to write portable code, 
since I too have a hard time liking autoconf and friends.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
