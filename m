From: Nicolas Vilz 'niv' <niv@iaglans.de>
Subject: Re: git + ssh + key authentication feature-request
Date: Thu, 09 Feb 2006 01:33:30 +0100
Message-ID: <43EA8DDA.3070906@iaglans.de>
References: <43EA73C3.2040309@iaglans.de>	<7vhd79o6m5.fsf@assigned-by-dhcp.cox.net>	<43EA7D57.7040409@iaglans.de> <7v4q39o3xs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Feb 09 00:34:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6ypo-00057E-2J
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 00:34:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422634AbWBHXes (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 18:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422635AbWBHXes
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 18:34:48 -0500
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:49157 "EHLO
	vsectoor.geht-ab-wie-schnitzel.de") by vger.kernel.org with ESMTP
	id S1422634AbWBHXes (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2006 18:34:48 -0500
Received: from localhost (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 0857B3E9D
	for <git@vger.kernel.org>; Thu,  9 Feb 2006 00:34:31 +0100 (CET)
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1])
	by localhost (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 31748-05 for <git@vger.kernel.org>;
	Thu, 9 Feb 2006 00:34:29 +0100 (CET)
Received: from [192.168.100.26] (hermes.lan.home.vilz.de [192.168.100.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 5AD5F3E51
	for <git@vger.kernel.org>; Thu,  9 Feb 2006 00:34:29 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <7v4q39o3xs.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15760>

Junio C Hamano wrote:
> Nicolas Vilz 'niv' <niv@iaglans.de> writes:
> 
> 
>>in my case it would be only one system-user which has full access to
>>several repositories. At this time, the users which use that account,
>>have to give a password, which isn't that bad... it would be easier
>>and more secure for me, not to give a password, but ask the users for
>>the ssh pubkey..

[... how sshd operates ...]

> You _could_ tell them to use the same -l option and log-in as
> the same UNIX user with their own keys, though.  But that way
> you cannot tell which developer pushed into the repository (of
> course if you trust the commits, commit log message would say
> the committer ident).

I think this (last) scenario would match my thoughts best :)

Exactly that was, what i was trying to do, although I couldn't tell git 
to send my identify-file. That was (more or less) my initial-question 
(howto do that, the ssh option -i) :)

You got a point which i haven't recognized, yet...

I really can't tell later on which developer pushed unless i trust the 
commit-messages. I will think about that.

So, how do i tell git to send my identity-file to sshd? And could I set 
an alias like in .git/remotes for that location / identity?

Thank you very much for your explanations and help.

Sincerly
Nicolas
