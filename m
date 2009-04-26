From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Google Code: Support for Mercurial and Analysis of Git and Mercurial
Date: Sun, 26 Apr 2009 10:54:48 -0400
Message-ID: <49F475B8.20903@gmail.com>
References: <200904260703.31243.chriscool@tuxfamily.org> <m363grq13i.fsf@localhost.localdomain>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 12:09:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ly5o4-0003NR-Eh
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 16:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754812AbZDZOy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 10:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754759AbZDZOy4
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 10:54:56 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:53155 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754702AbZDZOyz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 10:54:55 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1137571ywb.1
        for <git@vger.kernel.org>; Sun, 26 Apr 2009 07:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Kd7gADuuGkqjSZBpBvuxE9J7adjVJCDOQprF3MkqcWo=;
        b=loWf3YCrgNwNxyL7QIMXJh0mr0Xd8hnpQsPX5kckWWciZPHMsr7RUgU3Da/jZm7eWD
         wi/G+hOsbRz/RvxO3M+xAxNzMsEO1RkzK2S0Rf0PlqoOd8KSZOjwmKAnkgkHqnVAoL7F
         8/RZ+nmNFfGtkWTiFd7tVj7CEqvvDbCQz8O/U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=aNftto+pVNPyKOalpDTSsJK0lnf2mf00NoMKuS1bOiDSy+tvo4vYP8TwMe9rTRaxEG
         JSrL+tN2VKJMJnbVcFLUvu8Enj4FdUwPG7Lu16JD8UD0tIJLTMhhBl0YbYyP/27/LM9d
         4P39I1B6YUawTduPoTL4JK0PZurtwinNvEW2Y=
Received: by 10.100.152.12 with SMTP id z12mr6837650and.96.1240757693952;
        Sun, 26 Apr 2009 07:54:53 -0700 (PDT)
Received: from ?10.0.0.6? (c-66-177-19-100.hsd1.fl.comcast.net [66.177.19.100])
        by mx.google.com with ESMTPS id b37sm9980007ana.13.2009.04.26.07.54.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Apr 2009 07:54:53 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <m363grq13i.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117639>

Jakub Narebski wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> 
>> For information, now Google Code supports Mercurial for project hosting:
>>
>> http://google-code-updates.blogspot.com/2009/04/mercurial-support-for-project-hosting.html
>>
>> Mercurial was choosen over Git because of this (one year old) analysis:
>>
>> http://code.google.com/p/support/wiki/DVCSAnalysis
>>
>> There is this article on LWN about the analysis:
>>
>> http://lwn.net/Articles/330138/
> 
> It is a pity that the choice was based on year old analysis.  One year
> for actively developed and fast moving targets such like Git and
> Mercurial is ages in terms of development history.  But I guess this
> is unavoidable.
> 
> For example periodic "maintenance" (garbage collecting) is nowadays
> quite automatic in git, with fetching into pack, periodic repacking if
> number of loose objects is above tthreshold, and "git gc --auto".
> 
> Whether Mercurial or Git has better UI and better documentation is
> IMHO a matter of debate.  Git documentation is much better that it
> was, with "Git User's Manual" and "Git Community Book"; UI also is
> being improved.
> 
> I can't comment on MS Windows support, but AFAIK Mercurial has better
> support here than Git.
> 
> 
> The deciding feature (well, one of deciding features) was the fact
> that Mercurial has better HTTP support... I guess (it was not obvious
> from the analysis, but it was hinted at) that Mercurial uses its
> custom protocol over HTTP, as opposed to "dumb" HTTP protocol support
> in Git.
> 
> Perhaps it is time to restart work on _"smart" HTTP protocol_?
> 

Another important criteria was which, both or neither of Git and Hg 
would actually work and perform well on top of Google Code's underling 
storage system and except to mention they would be using Bigtable, the 
report did not discuss this. Git on top of Bigtable will not perform well.

Read the paper and do the math if you are interested.

	http://labs.google.com/papers/bigtable-osdi06.pdf
