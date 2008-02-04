From: Paul Gardiner <osronline@glidos.net>
Subject: Re: New to git: sorry for obvious question.
Date: Mon, 04 Feb 2008 10:41:01 +0000
Message-ID: <47A6EBBD.9060500@glidos.net>
References: <47A6E130.7090909@glidos.net> <vpq4pcp6moq.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 04 11:41:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLylk-00045d-RH
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 11:41:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbYBDKlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 05:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbYBDKlK
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 05:41:10 -0500
Received: from mk-outboundfilter-1.mail.uk.tiscali.com ([212.74.114.37]:22506
	"EHLO mk-outboundfilter-1.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751204AbYBDKlI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Feb 2008 05:41:08 -0500
X-Trace: 33325151/mk-outboundfilter-1.mail.uk.tiscali.com/PIPEX/$MX-ACCEPTED/pipex-infrastructure/62.241.163.7
X-SBRS: None
X-RemoteIP: 62.241.163.7
X-IP-MAIL-FROM: osronline@glidos.net
X-IP-BHB: Once
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAMZ6pkc+8aMH/2dsb2JhbACqew
X-IP-Direction: IN
Received: from blaster.systems.pipex.net ([62.241.163.7])
  by smtp.pipex.tiscali.co.uk with ESMTP; 04 Feb 2008 10:41:04 +0000
Received: from [10.0.0.24] (80-42-19-184.dynamic.dsl.as9105.com [80.42.19.184])
	by blaster.systems.pipex.net (Postfix) with ESMTP id A36B3E0000A7
	for <git@vger.kernel.org>; Mon,  4 Feb 2008 10:41:03 +0000 (GMT)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <vpq4pcp6moq.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72487>

Matthieu Moy wrote:
> Paul Gardiner <osronline@glidos.net> writes:
> 
>> Hi,
>>
>> I've moved a project from CVS on sourceforge to git on repo.or.cz.  I
>> want a local mirror on my own home server, so that it appears amongst
>> the projects shown by my own gitweb set up, and so it gets caught by
>> my backup system.  I've created the mirror with
>>
>>   git clone --bare <remote-url> <local-dir>
>>
>> and that seems fine.  But how do I now keep it up to date.  I was
>> guessing a cron job doing some sort of git pull, but pull doesn't
>> look to work on --bare proj.git type repositories.
> 
> You probably want "git fetch". Actually, "git pull" does a fetch first
> (get the remote revisions that you don't have), and then a merge with
> your working tree.

Yeah, that's what I thought, but it doesn't seem to work with --bare
repositories that are of the form proj.git, rather than having a dir 
proj containing checkout files and a .git folder. Both pull and fetch
say that it isn't a git repository (although I can view it under gitweb,
and I can clone and pule from it).
