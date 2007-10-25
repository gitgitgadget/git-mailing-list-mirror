From: Andreas Ericsson <ae@op5.se>
Subject: Re: recent change in git.git/master broke my repos
Date: Thu, 25 Oct 2007 22:42:00 +0200
Message-ID: <4720FF98.5080905@op5.se>
References: <86oden6z97.fsf@blue.stonehenge.com> <20071025150107.GB31196@diana.vm.bytemark.co.uk> <alpine.LFD.0.9999.0710251344220.22100@xanadu.home> <4720FB4E.3030300@op5.se> <alpine.LFD.0.9999.0710251637240.22100@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-15?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Oct 25 22:43:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il9Xj-0007d2-Q3
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 22:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755648AbXJYUmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 16:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756622AbXJYUmM
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 16:42:12 -0400
Received: from mail.op5.se ([193.201.96.20]:52122 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755648AbXJYUmI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 16:42:08 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 02B69173071F;
	Thu, 25 Oct 2007 22:41:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PjxusfBcJrM7; Thu, 25 Oct 2007 22:41:57 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id EA428173071D;
	Thu, 25 Oct 2007 22:41:56 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <alpine.LFD.0.9999.0710251637240.22100@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62373>

Nicolas Pitre wrote:
> On Thu, 25 Oct 2007, Andreas Ericsson wrote:
> 
>> Nicolas Pitre wrote:
>>> Isn't that called a remote branch that gets updated with "git fetch' ?
>>> You can even trick Git into not using the refs/remotes/ namespace for them
>>> if you wish.
>>>
>> You'd lose the ability to do "git diff origin/master" while disconnected
>> though. It's quite valuable.
> 
> I don't see how you'd lose anything.
> 

Sorry, I thought you were talking about a config along the lines of:
fetch = refs/heads/*:refs/heads/*

What other trick are you talking about?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
