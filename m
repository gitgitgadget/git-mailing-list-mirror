From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 3/3] Allow whole-tree operations to be started from a
 subdirectory
Date: Tue, 16 Jan 2007 16:14:46 +0100
Message-ID: <45ACEBE6.40506@op5.se>
References: <7v8xg9x8uu.fsf@assigned-by-dhcp.cox.net> <7vy7o8rnyw.fsf_-_@assigned-by-dhcp.cox.net> <7vac0orml9.fsf_-_@assigned-by-dhcp.cox.net> <200701140111.20671.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 16:15:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6q1h-0004NI-CC
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 16:15:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbXAPPOt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 10:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbXAPPOt
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 10:14:49 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:55951 "EHLO
	smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbXAPPOs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 10:14:48 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 92B4B6BCC8; Tue, 16 Jan 2007 16:14:46 +0100 (CET)
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200701140111.20671.Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36943>

Josef Weidendorfer wrote:
> On Friday 12 January 2007 21:56, Junio C Hamano wrote:
>> This updates five commands (merge, pull, rebase, revert and cherry-pick)
>> so that they can be started from a subdirectory.
>>
>> This may not actually be what we want to do.  These commands are
>> inherently whole-tree operations, and an inexperienced user may
>> mistakenly expect a "git pull" from a subdirectory would merge
>> only the subdirectory the command started from.
> 
> Yes, this IMHO is a problem.
> 
> Why not add a general "--top" option to the "git" wrapper,
> to temporarily let git change to the toplevel while running
> the command?
> 
> The wish to allow git-fetch from subdirectories is the
> inconvenience to have to cd up, and later down. This is
> avoided by running "git --top fetch", and theses people
> should be happy.
> 

It has the feel of forcing me to tell git to do the right thing when 
it's perfectly capable of figuring out what the right thing is on its own.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
