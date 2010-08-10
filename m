From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: Maildir ordering in git-mailsplit (was: Using mutt as a git
 maintainer)
Date: Tue, 10 Aug 2010 19:54:11 +0200
Message-ID: <20100810175411.GA13084@vidovic>
References: <20100806222847.GA4240@sceen.net>
 <20100807024337.GA15410@kytes>
 <20100807112159.GA12015@sceen.net>
 <m3eieao8uh.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Richard Braun <rbraun@sceen.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 19:54:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oit1t-0001lz-3i
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 19:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285Ab0HJRyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Aug 2010 13:54:16 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:57386 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932260Ab0HJRyP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 13:54:15 -0400
Received: by wwf26 with SMTP id 26so3961587wwf.1
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 10:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=qgK9cPC0dTP+bpaoyZxvogUTi1aXfidhDx4WHlCKXMs=;
        b=fAukleW1GKW8w2rGLJIkLPUZKLQwY6Eg3aCGsL4YvmAghOdibzrjADmJQKCRPfJfD5
         2CGjVb4AATc7dvivS7UsEhnyo09s0a1EIIlxHVhqjtrVnjHnVfGoQb8WE9v5cYg2PKQW
         RTcxnwapcKjcMA9/DBvE61UPpWSx/lPILYQcA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qBTi/VOxWmy28SvmZu6kGGcIKkNu7Zp9NB+Dpze5Ud2qMYjZrGJa8ZBMU1/TtGFZJy
         AOQi61nBe/rsVmI6aD1oeKHCmV5pQq8ba1zuRn1Z3Gt1gDllAN/3Q/uCOHtAHb5sdhl0
         9pWrCynnGRm3glyHlJNURuezmBbqT42rjcUgg=
Received: by 10.227.137.15 with SMTP id u15mr13617895wbt.129.1281462853795;
        Tue, 10 Aug 2010 10:54:13 -0700 (PDT)
Received: from vidovic (aqu33-8-83-155-187-36.fbx.proxad.net [83.155.187.36])
        by mx.google.com with ESMTPS id h3sm5693476wbb.3.2010.08.10.10.54.12
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Aug 2010 10:54:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m3eieao8uh.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153133>

The 07/08/10, Jakub Narebski wrote:
> Richard Braun <rbraun@sceen.net> writes:
> > 
> > I'm not sure about what depends on string-list.c, but based on the
> > output of a raw grep, it doesn't seem like a good idea to change the
> > way strings are sorted, especially if almost noone uses Maildir for
> > patch series. [...]

I do use maildir but never hit this problem (or never seen it, at least)
probably because I often purge the maildir "_patches" where I store
patch series.

> Would it be really that difficult to implement "version sort" in git
> (like 'ls -v' / 'ls --sort=version' does), using strverscmp (and
> provide fallback in compat/), and use it in git-am?

Yeah, it would be nice to fix this bug. I don't have time these days but
I'm marking this thread to look further later.

-- 
Nicolas Sebrecht
