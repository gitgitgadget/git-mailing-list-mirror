From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 10 Feb 2008 08:29:17 -0800 (PST)
Message-ID: <m3wspcg4hg.fsf@localhost.localdomain>
References: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org>
	<7vodavd9qw.fsf@gitster.siamese.dyndns.org>
	<7vbq6tset4.fsf@gitster.siamese.dyndns.org>
	<7vmyq9gk94.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 17:30:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOF3y-0004vZ-By
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 17:29:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbYBJQ3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 11:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbYBJQ3U
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 11:29:20 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:17729 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbYBJQ3T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 11:29:19 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1641391wah.23
        for <git@vger.kernel.org>; Sun, 10 Feb 2008 08:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=Ec7t4jvzGEaeirF94srIwmQXSRxEp6LcBP26o7fcGB0=;
        b=xsE7b8yOK7ncQGTiD2kCXHT3Vt7j+kf15c0C0F23zp2rQ+MX2tRQ39mVonLjqkrqwigTu+dKmTAvWiWmM4MBWmbgBX+PRwUKSXD9gad45jyqRg1H2oQBzv3kO4RFre1joXN8PVwgZf23/jVbzN3UahqVpZToFRFU1AlB+bl84Ec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=GpvemSvnQzJOMBuEd3iw7cDAzg6cm1jeVkMoJFQHQcz9Oq+h+lzaz1glVfU5320VODTuuk3/U4XwHEbCSphcX78T3zXu+pph7HX42k+T3EpdsGVYUL3aF1t47Faj/7xKDNJi/2K4xBOLr3Rh9AKMkNIrZLkgnaa8NofBqfjzaUA=
Received: by 10.114.156.1 with SMTP id d1mr9261803wae.68.1202660959322;
        Sun, 10 Feb 2008 08:29:19 -0800 (PST)
Received: from localhost.localdomain ( [83.8.255.105])
        by mx.google.com with ESMTPS id k30sm4778573ugc.53.2008.02.10.08.29.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 10 Feb 2008 08:29:17 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1AGT7jC030774;
	Sun, 10 Feb 2008 17:29:12 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1AGT0mo030770;
	Sun, 10 Feb 2008 17:29:00 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <7vmyq9gk94.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73365>

Junio C Hamano <gitster@pobox.com> writes:

> * br/gitweb (Fri Feb 8 14:38:04 2008 -0200) 1 commit
>  - gitweb: Use the config file to set repository owner's name.
> 
> Looked Ok.

I assume that you have squashed commits: chaning gitweb.perl and
adding to gitweb/README?

I'd rather hear from Pasky first, but well...
 
> * jc/submittingpatches (Sun Feb 3 17:02:28 2008 -0800) 3 commits
>  + Documentation/SubmittingPatches: What's Acked-by and Tested-by?
>  + Documentation/SubmittingPatches: discuss first then submit
>  + Documentation/SubmittingPatches: Instruct how to use [PATCH]
>    Subject header
> 
> These I think are sensible but they did not see much discussion,
> so they are parked here for now.

I thing first and last are good to go, while second could get
improved. This means I guess either resending second patch for further
discussion, or adding it as is, and wait for further improvements; it
is better than nothing.
 
> * jc/gitignore-ends-with-slash (Thu Jan 31 20:23:25 2008 -0800) 2 commits
>  + gitignore: lazily find dtype
>  + gitignore(5): Allow "foo/" in ignore list to match directory "foo"
> 
> This is redone after we had discussion on the list to properly
> make "foo/" match only with directories and "foo" with both
> files and directories without unnecessary lstat(2) calls.

Nice. I like it.
 
> * nd/dashless (Wed Nov 28 23:21:57 2007 +0700) 1 commit
>  - Move all dashed-form commands to libexecdir
> 
> Scheduled for 1.6.0.  I am not sure if we should merge this to
> 'next' before 1.5.5.  Most active people will be on 'next' and
> if we have this there, the resulting 1.5.5 release might end up
> having issues that come from differences this one introduces.

Perhaps git should build with separate libexecdir, and at first move
only helper scripts (*--*) there? We can then check what would break,
a little safer. Helper scripts are not meant to be called by user
anyway...

> * ab/pserver (Fri Dec 14 04:08:51 2007 +0000) 1 commit
>  - Authentication support for pserver
> 
> This needs careful security audit and a fix to its password
> database format.  Plaintext in .git/config is not acceptable.

Does git-cvsserver understand .netrc?

> * bf/remote-head (Sun Dec 23 20:52:32 2007 -0500) 1 commit
>  - git-remote: make add -f guess HEAD, as clone does
> 
> I might have carefully looked at this in the past but I do not
> recall if there were issues.  Need re-reviewing and help from
> the list is appreciated.

> * jc/git-symref (Tue Dec 11 16:42:46 2007 -0800) 1 commit
>  - PARK: show-symref protocol extension.

Do not the second cancels a bit of first?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
