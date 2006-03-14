From: Mark Hollomon <markhollomon@comcast.net>
Subject: Re: What should I use instead of git show?
Date: Tue, 14 Mar 2006 06:49:19 -0500
Message-ID: <4416ADBF.9020906@comcast.net>
References: <20060313144747.GA81092@dspnet.fr.eu.org>	<200603131717.53416.astralstorm@o2.pl>	<Pine.LNX.4.64.0603130830050.3618@g5.osdl.org>	<4415FFB8.3000001@comcast.net> <7vmzftq4r4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 14 12:49:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJ81P-0002ES-K9
	for gcvg-git@gmane.org; Tue, 14 Mar 2006 12:49:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbWCNLtA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Mar 2006 06:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbWCNLtA
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Mar 2006 06:49:00 -0500
Received: from sccrmhc12.comcast.net ([63.240.77.82]:8611 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751806AbWCNLs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Mar 2006 06:48:59 -0500
Received: from [10.0.0.3] (c-69-249-27-188.hsd1.de.comcast.net[69.249.27.188])
          by comcast.net (sccrmhc12) with ESMTP
          id <2006031411485801200c77ice>; Tue, 14 Mar 2006 11:48:58 +0000
User-Agent: Thunderbird 1.5 (X11/20060113)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzftq4r4.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17587>

Junio C Hamano wrote:
> Mark Hollomon <markhollomon@comcast.net> writes:
> 
>> I must be misunderstanding this:
>>
>> 	git whatchanged -p -1 HEAD
>>
>> in the current git tree results in nothing. only when I get to -5 does it show something.
>>
>> Is this expected?
>>
>>> git version
>> git version 1.2.4.gea75
> 
> In this case what matterks is not the version of your git but
> what that HEAD is.  If it is a merge commit, whatchanged -p does
> not show anything by default.

Oh, I see. As a pass through to git-rev-list that makes sense. --max-count is really 
-max-commits-to-consider (or something like that).

Is there a --max-commits-to-show?

-- 
Mark Hollomon
