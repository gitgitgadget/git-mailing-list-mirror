From: Larry Streepy <larry@lightspeed.com>
Subject: Re: removal of "percent done" messages from git pull
Date: Fri, 16 Feb 2007 13:56:05 -0600
Message-ID: <45D60C55.4060005@lightspeed.com>
References: <45D5E06B.6020706@lightspeed.com> <slrnetbrgm.ahb.siprbaum@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>
X-From: git-owner@vger.kernel.org Fri Feb 16 20:56:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI9By-0007Qm-Tg
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 20:56:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946102AbXBPT4W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 14:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946098AbXBPT4W
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 14:56:22 -0500
Received: from mailhost.lightspeed.com ([12.44.179.187]:59301 "EHLO
	lightspeed.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1946096AbXBPT4V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 14:56:21 -0500
Received: from [192.168.10.13] (account larry [192.168.10.13] verified)
  by lightspeed.com (CommuniGate Pro SMTP 5.0.9)
  with ESMTPA id 3607581; Fri, 16 Feb 2007 11:54:43 -0800
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
In-Reply-To: <slrnetbrgm.ahb.siprbaum@xp.machine.xx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39944>

Hi Peter,

Yes, I did try that, but the underlying "git-fetch" command complains about 
improper usage. So it seems that git-fetch-pack is not being called (or it 
is called from git-fetch and git-fetch is failing to understand -q).

Thanks,
Larry.


Peter Baumann wrote:
> Larry Streepy <larry@lightspeed.com> schrieb:
>> I run a nightly script to build and test our product.  I capture all the 
>> output and email it to interested parties.  One very annoying thing is the 
>> "percent done" messages that come out of git pull.  It results in log files 
>> that look like this:
>>
> 
> Have you tried with -q to make it more silent? (I didn't try this, but
> normaly the git porcelain commands just pass the options they don't
> understand to the underlying core commands; and git-fetch-pack has the
> option -q for quiet)
> 
> -Peter
