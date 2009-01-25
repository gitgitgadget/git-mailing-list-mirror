From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: diff settings
Date: Sun, 25 Jan 2009 16:02:10 -0500
Message-ID: <497CD352.2060402@tedpavlic.com>
References: <alpine.GSO.2.00.0901240936080.23073@kiwi.cs.ucla.edu> <87ocxwv6qg.fsf@iki.fi> <alpine.GSO.2.00.0901241159050.23073@kiwi.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Teemu Likonen <tlikonen@iki.fi>, git <git@vger.kernel.org>
To: Keith Cascio <keith@CS.UCLA.EDU>
X-From: git-owner@vger.kernel.org Sun Jan 25 22:03:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRC8t-0000UV-CS
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 22:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbZAYVCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 16:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbZAYVCQ
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 16:02:16 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:55715 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751324AbZAYVCP (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jan 2009 16:02:15 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 9C78280D8035;
	Sun, 25 Jan 2009 15:56:11 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fBFPkzIYjJqP; Sun, 25 Jan 2009 15:56:11 -0500 (EST)
Received: from TedBook.local (cpe-76-181-62-78.columbus.res.rr.com [76.181.62.78])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 4584380D8011;
	Sun, 25 Jan 2009 15:56:11 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <alpine.GSO.2.00.0901241159050.23073@kiwi.cs.ucla.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107103>

>>      git config --global alias.dff "diff -w"
>>
>> Then "git dff" is your new "git diff -w". :-)
>
> That feature is gonna come in handy.  It doesn't 100% fulfill my needs here but
> I like it!  Thanks, I did not know about alias.*

Mercurial has a "defaults.*" that does exactly what you want. That is, 
you can say

[defaults]
diff = -w

and "hg diff" will automatically do "hg diff -w". Such a feature might 
be a nice addition to git.

--Ted


-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.
