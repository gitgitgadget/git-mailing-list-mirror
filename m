From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] git-remote
Date: Tue, 09 Jan 2007 10:22:53 +0100
Message-ID: <45A35EED.5090105@op5.se>
References: <7vfyarokk7.fsf@assigned-by-dhcp.cox.net>	<20070109042851.GF1686@fieldses.org> <7vr6u4sq9e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 10:23:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4DC7-0001kD-69
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 10:22:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbXAIJW4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 04:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbXAIJW4
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 04:22:56 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:41167 "EHLO
	smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbXAIJWz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 04:22:55 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 5E24B6BCBC; Tue,  9 Jan 2007 10:22:54 +0100 (CET)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr6u4sq9e.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36334>

Junio C Hamano wrote:
> "J. Bruce Fields" <bfields@fieldses.org> writes:
> 
>> Would it make sense for "git add" to do the initial fetch as well?
> 
> It would be handy.
> 
> And perhaps we could make it the default but with a command line
> override to help disconnected people.
> 

I'd rather do it the other way around ("--fetch" switch) and if that 
wasn't supplied, tell the user that he should now run

	git fetch $whatever_name_was_supplied

The reason being it's easier to fetch afterwards than it is to undo the 
fetch if you didn't mean to do it straight away. Judging by its other 
uses, I also wouldn't expect the command to actually work over the network.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
