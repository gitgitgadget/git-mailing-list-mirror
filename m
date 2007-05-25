From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: Pulling from refs/remotes/ ?
Date: Thu, 24 May 2007 23:24:42 -0300
Message-ID: <465648EA.8070608@xs4all.nl>
References: <f35d9n$21e$1@sea.gmane.org>	<7v7iqxvgx8.fsf@assigned-by-dhcp.cox.net> <46563D55.3070607@xs4all.nl> <7v3b1lvfc5.fsf@assigned-by-dhcp.cox.net>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 25 04:26:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrPVt-0004C3-Be
	for gcvg-git@gmane.org; Fri, 25 May 2007 04:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbXEYC0l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 22:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752632AbXEYC0l
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 22:26:41 -0400
Received: from main.gmane.org ([80.91.229.2]:46606 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751843AbXEYC0k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 22:26:40 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HrPVl-00027L-26
	for git@vger.kernel.org; Fri, 25 May 2007 04:26:37 +0200
Received: from c911deb6.bhz.virtua.com.br ([201.17.222.182])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 May 2007 04:26:37 +0200
Received: from hanwen by c911deb6.bhz.virtua.com.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 May 2007 04:26:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c911deb6.bhz.virtua.com.br
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
In-Reply-To: <7v3b1lvfc5.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48335>

Junio C Hamano escreveu:
> Han-Wen Nienhuys <hanwen@xs4all.nl> writes:
> 
>> Yes, that works, thanks. Wouldn't it be more consistent with this
>> reasoning to disallow 
>>
>>   git pull . LOCAL-BRANCH 
>>
>> too?
> 
> I do not think so.
> 
> If somebody else (or yourself) did:
> 
> 	$ git pull $dir LOCAL-BRANCH
> 
> (replace $dir with the `pwd` you would get in your repository),
> that would work.  Why shouldn't it work for yourself?
 
Because

"You are treating your local repository as if it is a remote
repository somewhere else, namely, '.' (current repository)."

that was the justification for not being able to pull in a remote
branch.  This justification (which I disagree with) applies to this
case as well.

I understand that we don't want people committing to
remotes, because fetches will then later fail, but other than 
that, why should there be limitations on using a remote?

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
