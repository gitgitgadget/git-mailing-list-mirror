From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 07 Feb 2008 02:32:48 -0800 (PST)
Message-ID: <m3ir113vmv.fsf@localhost.localdomain>
References: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org>
	<7vodavd9qw.fsf@gitster.siamese.dyndns.org>
	<7vbq6tset4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 11:33:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN44S-00038m-0T
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 11:33:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755144AbYBGKcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 05:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755038AbYBGKcy
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 05:32:54 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:52539 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754778AbYBGKcx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 05:32:53 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1020417wah.23
        for <git@vger.kernel.org>; Thu, 07 Feb 2008 02:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=XT4xvW9JHHovCEB7pP4MdmERIUYe0xRsLyOFsSz5z9E=;
        b=WxmdyFdJ5+gBRTnNbC4b0i66ULS7T/w39wSS8cY28e0jtuhvJv9Cakd3vLL5VmVkZrXfmVi8jZfRq2LG0EpgyQfCMrDqKQKTSKtB/dgVKHv0B9Ay/q2yG6fP1Zo7UwsGHoQbe/X1RXLLeUEsA+eSFz92vk17gzGPWXD35j7MIio=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=Y2aHPzg0zU6BCMSBgIvV21Sd+nanUAPrTmBu9UiRETp4AJl4Lb/riJjgkVvAc5jAi1NEOEtAiFz+/uaI6SkBeFhqehMB0UavCR/cDqevSPpVeaYcEUhLu9Y/iypfqaskMUSc4vpk3szveukR92k2diOADTThKqSUQNVoeVyICcw=
Received: by 10.114.159.1 with SMTP id h1mr4842002wae.122.1202380369853;
        Thu, 07 Feb 2008 02:32:49 -0800 (PST)
Received: from localhost.localdomain ( [83.8.207.33])
        by mx.google.com with ESMTPS id c14sm28621307nfi.6.2008.02.07.02.32.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Feb 2008 02:32:48 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m17AWA4t020273;
	Thu, 7 Feb 2008 11:32:21 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m17AVsfU020269;
	Thu, 7 Feb 2008 11:31:54 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <7vbq6tset4.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72922>

Junio C Hamano <gitster@pobox.com> writes:

> * jk/noetcconfig (Wed Feb 6 05:11:53 2008 -0500) 2 commits
>  + fix config reading in tests
>  + allow suppressing of global and system config
> 
> * lh/gitdir (Mon Feb 4 21:59:21 2008 +0100) 4 commits
>  - git-submodule: prepare for the .git-file
>  - Add tests for .git file
>  - Document the .git-file
>  - Add platform-independent .git "symlink"
> 
> Seems to have funny interaction with Jeff King's test script
> updates.

I think that gitdir is a very good idea, but needs further testing.
 
> * ph/describe-match (Mon Dec 24 12:18:22 2007 +0100) 2 commits
>  + git-name-rev: add a --(no-)undefined option.
>  + git-describe: Add a --match option to limit considered tags.

This looks nice. I'd like also to have some kind of --pretty=<format>
(or --format=<format>) for git-describe, and a way to limit both
git-name-rev and git-describe to only *signed* commits.

With this it would be fairly easy in generating git.spec file
from git.spec.in to check if we are on tagged release and use
pre-compiled manpages if it is the case. Although perhaps option
(default?) to use pre-compiled manpages (even if they are outdated
a bit) instead of requiring asciidoc toolchain would be better;
this would make SRPM size larger, as it would contain manpages.
 

> * nd/dashless (Wed Nov 28 23:21:57 2007 +0700) 1 commit
>  - Move all dashed-form commands to libexecdir
> 
> Scheduled for 1.6.0.  I am not sure if we should merge this to
> 'next' before 1.5.5.  Most active people will be on 'next' and
> if we have this there, the resulting 1.5.5 release might end up
> having issues that come from differences this one introduces.

Perhaps we should first generate libexecdir separate from bindir,
and put helper scripts there (the *--* scripts), to not pollute
PATH with commands which are never meant to be called directly
by user.
 
> * bf/remote-head (Sun Dec 23 20:52:32 2007 -0500) 1 commit
>  . git-remote: make add -f guess HEAD, as clone does
> 
> I might have carefully looked at this in the past but I do not
> recall if there were issues.  Need re-reviewing and help from
> the list is appreciated.

I'd rather below get implemented, so there isn't any guessing
involved.
 
> * jc/git-symref (Tue Dec 11 16:42:46 2007 -0800) 1 commit
>  . PARK: show-symref protocol extension.

What are the plans on git-clone builtinification (and cleaning up
clone progress and error messages[*1*])?

[*1*] http://texagon.blogspot.com/2008/02/let-play-git.html
-- 
Jakub Narebski
Poland
ShadeHawk on #git
