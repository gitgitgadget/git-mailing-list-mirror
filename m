From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] diff --check: use colour
Date: Fri, 26 Jan 2007 12:10:26 +0100
Message-ID: <45B9E1A2.40505@op5.se>
References: <Pine.LNX.4.63.0701241505260.22628@wbgn013.biozentrum.uni-wuerzburg.de>	<7vr6tkdnee.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.63.0701251015390.22628@wbgn013.biozentrum.uni-wuerzburg.de>	<7vk5za925w.fsf@assigned-by-dhcp.cox.net>	<17849.13327.527531.262943@lisa.zopyra.com>	<Pine.LNX.4.63.0701260034320.22628@wbgn013.biozentrum.uni-wuerzburg.de> <17849.17947.645022.282882@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Fri Jan 26 12:10:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAOyX-00042y-2H
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 12:10:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932936AbXAZLK3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 06:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933158AbXAZLK3
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 06:10:29 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:33475 "EHLO
	smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932936AbXAZLK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 06:10:29 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 24CD26BCC3; Fri, 26 Jan 2007 12:10:27 +0100 (CET)
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
In-Reply-To: <17849.17947.645022.282882@lisa.zopyra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37839>

Bill Lear wrote:
> On Friday, January 26, 2007 at 00:41:42 (+0100) Johannes Schindelin writes:
>> ...
>> The easiest way to find out what it does is to execute:
>>
>> 	git log -S--check diff.c
> 
> Hmm, using 1.5.0-rc2, I created a test repo, and did this:
> 
> echo foo > foo
> git add foo
> git commit -a -m foo
> echo bar > foo
> git commit -a -m bar
> git log -S--check foo
> 
> and nothing happened.
> 
> I did
> 
> git log -S --check foo
> 
> and the thing went off into outer space.  Now at over 2 1/2 minutes of
> CPU time on my 2 Ghz Opteron box...
> 
> Is it really '-S--check'?
> 

Yes. '-S--check' will start a pickaxe search for the string '--check' in
the repository, covering all the history and the likes. It can take quite
a long time (even if used properly ;-)), but it's certainly better than having
to look manually.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
