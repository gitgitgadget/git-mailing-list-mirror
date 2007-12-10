From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Adding Git to Better SCM Initiative : Comparison
Date: Mon, 10 Dec 2007 09:21:26 -0800 (PST)
Message-ID: <m3zlwisbxx.fsf@roke.D-201>
References: <200712101357.49325.jnareb@gmail.com>
	<87ve76mwos.fsf@mid.deneb.enyo.de> <20071210165052.GA22327@pe.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Florian Weimer <fw@deneb.enyo.de>,
	Shlomi Fish <shlomif@iglu.org.il>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Chris Shoemaker <c.shoemaker@cox.net>
X-From: git-owner@vger.kernel.org Mon Dec 10 18:22:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1mKH-0008SC-5b
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 18:21:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752959AbXLJRVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 12:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752979AbXLJRVb
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 12:21:31 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:16145 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752959AbXLJRVa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 12:21:30 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1054871nfb
        for <git@vger.kernel.org>; Mon, 10 Dec 2007 09:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=UxI4uBQXObtPtWx+0u0nXvy52QPVzm5ua9DGUnSKKlQ=;
        b=Xb4hI+OIQdfNzbSMVyRnp1Q8ru29pGYV+USul9SBlDcw0EWNUpzUoI7aZi8h3gViReMeIw5Pw71tmtpzgUZphWnF2bWDC0EKlFvXVrF7z+Nz8Cg9QO8LxSpASClAT95gl4y/hVlBKnrkHXe3AB9c629DMv6oT5nf+tw5DJp0Q8o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=SAo6dgrw5Xy9ivmi4CdPet8DvlN+6aGg3bClJP20ISnK784rzk3Q3kK+aiKyQDpp2kpe7pOhCsy4KGu5/yEenT25BCkiNKJwNLrrUnL77QP/o6Bug7ZqgBPzbHRclIlXh4p4O+Z6gJ8tFoaXulOKbBjBT4t+MWc0f9++8VCs4+M=
Received: by 10.82.158.12 with SMTP id g12mr14179144bue.1197307288284;
        Mon, 10 Dec 2007 09:21:28 -0800 (PST)
Received: from roke.D-201 ( [83.8.241.16])
        by mx.google.com with ESMTPS id g1sm8634515muf.2007.12.10.09.21.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 10 Dec 2007 09:21:26 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lBAHLIgf029516;
	Mon, 10 Dec 2007 18:21:19 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lBAHLFAv029513;
	Mon, 10 Dec 2007 18:21:15 +0100
X-Authentication-Warning: roke: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <20071210165052.GA22327@pe.Belkin>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67739>

Chris Shoemaker <c.shoemaker@cox.net> writes:

> On Mon, Dec 10, 2007 at 03:49:39PM +0100, Florian Weimer wrote:
> > * Jakub Narebski:
> > 
> > > +                <s id="git">
> > > +                    Yes (or no depending on interpretation). Git
> > 
> > This should be "No." (same for copies below).
> 
> ISTM that people are stuck using less than helpful criteria for
> judging whether renames are supported.  Namely, in effect, they ask:
> "Does the user get to do extra work in order to get rename-detection?"
> 
> Let me humbly suggest an alternate, two-fold, very practical criteria
> that I actually care about as a user:
> 
> 1) If I edit file A, while another developer renames file A to B, and
> I merge my work with his, do I have to clean things up myself, or does
> everything Just Work?

The only thing Git doesn't implement _yet_ is when you have renamed
a directory, and another developer created a new file in the old
directory name. Currently Git creates new files in old directory.
Note however that moving files to other directory might need changes
in files: for example Java, or header files includes in C/C++. This
is not very common, though.

BTW. this issue is in TODO for "Better SCM : Comparison"
 * Add intelligent merging of renamed paths.

> 2) If I'm browsing the history of some code in a renamed file, does
> the history continue through the rename?

And Git does support it in both "git blame" (or "git gui blame"),
and in "git log" thanks to --follow option.

Note however that --follow cannot be used (yet?) with directories or
pathspecs. Not that other SCMs support wildcard pathspec limiting...

> By these criteria, git certainly does support renames.

That's why I wrote "Yes", adding "or no" (as suggested by Robin
Rosenberg) because it does it dofferently than other SCMs.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
