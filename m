From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Can't figure out some sense from the git-commit-tree man page
Date: Fri, 17 Aug 2007 19:16:41 +0200
Organization: At home
Message-ID: <fa4l5t$3jh$1@sea.gmane.org>
References: <20070817163034.GA11151@glandium.org> <Pine.LNX.4.64.0708171751360.20400@racer.site> <20070817165655.GA13891@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 19:17:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IM5RW-0004uU-Ek
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 19:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754376AbXHQRQ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 13:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754505AbXHQRQ7
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 13:16:59 -0400
Received: from main.gmane.org ([80.91.229.2]:47637 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754376AbXHQRQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 13:16:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IM5RP-0004fx-J6
	for git@vger.kernel.org; Fri, 17 Aug 2007 19:16:55 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Aug 2007 19:16:55 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Aug 2007 19:16:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56070>

[Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org]

Mike Hommey wrote:

> On Fri, Aug 17, 2007 at 05:52:52PM +0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> 
>> On Fri, 17 Aug 2007, Mike Hommey wrote:
>> 
>>>   ?   committer name and email and the commit time.
>>>   If not provided, "git-commit-tree" uses your name, hostname and domain to
>>>   provide author and committer info. This can be overridden by either
>>>   .git/config file, or using the following environment variables.
>>>   (...)
>>> 
>>> The "If not provided" part doesn't make sense.
>> 
>> It does, if you know how to specify the committer info.  Which the man 
>> page specifies how to provide:
>> 
>> This can be overridden by either `.git/config` file, or using the 
>> following environment variables.
>> 
>>         GIT_AUTHOR_NAME
>>         GIT_AUTHOR_EMAIL
>>         GIT_AUTHOR_DATE
>>         GIT_COMMITTER_NAME
>>         GIT_COMMITTER_EMAIL
>>         GIT_COMMITTER_DATE
>>         EMAIL
> 
> This is exactly where the man page doesn't make sense to me. It tells
> you that if you don't provide committer name, etc. it uses your name,
> hostname, etc., and you can override this with .git/config or the
> environment variable you listed.
> 
> So where were you supposed to provide these informations in the first
> place ?

Where you are supposed to provide this information? In .git/config (per
repository) or in ~/.gitconfig (per user), in the form:

[user]
        name  = Mike Hommey
        email = mh@glandium.org


"If not provided" means that git gets your user name from system, from the
GECOS files in /etc/passwd, and composes your email address from your user
id (account name), and from the hostname of your machine (or "(localhost)").
This is last resort fallback, so you better provide user and email yourself.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
