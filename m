From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC/PATCH] fail pull/merge early in the middle of conflicted
 merge
Date: Thu, 04 Jan 2007 16:37:56 +0100
Message-ID: <459D1F54.1060709@op5.se>
References: <7vwt478b5d.fsf@assigned-by-dhcp.cox.net>	<20070101204354.GA26687@spearce.org> <7vmz51usqf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 04 16:38:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2UfJ-0000QP-Ji
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 16:38:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbXADPh6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 10:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbXADPh6
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 10:37:58 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:54875 "EHLO
	smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964925AbXADPh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 10:37:57 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 63BCE6BCC2; Thu,  4 Jan 2007 16:37:56 +0100 (CET)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmz51usqf.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35935>

Junio C Hamano wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
>> Junio C Hamano <junkio@cox.net> wrote:
>>> After a pull that results in a conflicted merge, a new user
>>> often tries another "git pull" in desperation.  When the index
>>> is unmerged, merge backends correctly bail out without touching
>>> either index nor the working tree, so this does not make the
>>> wound any worse.
>> I've seen this many times too.  I don't understand why users cannot
>> read output messages and realize the current command failed, but
>> they don't.  *sigh*
> 
> That is not user's fault.  Tools should not make things worse
> when run more than once after they failed, and we do not either,
> so it is not a stupid behaviour on the user's part to do that.
> 
> We just need to make sure that it is more clear to the user that
> pull after a conflicted pull is futile, which is what this patch
> does.
> 

"Pulling is futile. Nothing will be assimilated" ?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
