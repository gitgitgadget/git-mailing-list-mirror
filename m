From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: ~/.git/config ?
Date: Fri, 26 May 2006 18:37:51 +0200
Organization: At home
Message-ID: <e57aso$krk$1@sea.gmane.org>
References: <20060526152837.GQ23852@progsoc.uts.edu.au> <20060526193325.d2a530a4.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri May 26 18:38:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjfKa-0008BI-UC
	for gcvg-git@gmane.org; Fri, 26 May 2006 18:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWEZQiV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 May 2006 12:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWEZQiV
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 12:38:21 -0400
Received: from main.gmane.org ([80.91.229.2]:21954 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751097AbWEZQiU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 May 2006 12:38:20 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FjfK2-00084b-5g
	for git@vger.kernel.org; Fri, 26 May 2006 18:37:58 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 May 2006 18:37:58 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 May 2006 18:37:58 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20818>

Timo Hirvonen wrote:

> Anand Kumria <wildfire@progsoc.uts.edu.au> wrote:
> 
>> Hi,
>> 
>> git is unable to construct a reasonable default email address in my
>> current environment.  So, I use GIT_AUTHOR_EMAIL and GIT_COMMITTER_EMAIL
>> to override things.
>> 
>> This has worked well but, now, I need to vary the email address for some
>> repositories.  Unfortunately the environment variables override
>> .git/config.
>> 
>> It would be good if things were like:
>>      - try to construct one automagically
>>      - use ~/.git/config (if available)
>>      - use .git/config
>>      - use environment variables
>> 
>> That way I could set my default email address in ~/.git/config and
>> override it as required for those repositories that need it.
> 
> I backup my $HOME using git, so there's a .git directory in ~.  I don't
> think a global config file is really needed but it would be nice if
> .git/config would override the environment variables, not the other way
> around.

Well, I'm not sure if environmental variables overriding wouldn't make
invocations like 'GIT_DIR=something git command' possible.

There are templates, also for config. Currently git lacks user (not
repository) config file, e.g. ~/.gitconfig (common for all repositories).

-- 
Jakub Narebski
Warsaw, Poland
