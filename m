From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation/git-stash.txt: Adjust SYNOPSIS command syntaxes
Date: Fri, 01 Feb 2008 18:30:18 -0800 (PST)
Message-ID: <m3tzks6qfm.fsf@localhost.localdomain>
References: <7ihp802o.fsf@blue.sea.net> <m37iho9b70.fsf@localhost.localdomain>
	<1w7w966m.fsf@blue.sea.net> <m33asc94xn.fsf@localhost.localdomain>
	<k5lo716v.fsf@blue.sea.net> <m3y7a46vmf.fsf@localhost.localdomain>
	<tzks5d8d.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sat Feb 02 03:31:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JL89u-0002lz-NT
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 03:31:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758269AbYBBCaY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 21:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756543AbYBBCaY
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 21:30:24 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:21320 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758140AbYBBCaW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 21:30:22 -0500
Received: by ug-out-1314.google.com with SMTP id z38so849934ugc.16
        for <git@vger.kernel.org>; Fri, 01 Feb 2008 18:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=7rqNKBUGuprmvQl8GyjNTsJa8cftgFIZqHJS97CUAqk=;
        b=BADNqN7MJiWpda+Zqirvma9icmPwON+aIZyEkFq903979Q1pxIvQmc7OGq2zfOwBXK0LEv1C5oeoJ4THmXpiT9Ss1V9BYZ+oZQISVwFToMOzJrwgaQJ9lGW1nD+dFCGpmdKtsfA9XNn8du16SGA0RQV6VYDGiLnZw1iP2exgLyI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=g/FKHr07ODdMBPitwKfRp6UlD2CDgIjBnu/04OzhNTaq8jbfl/4ROfkPqp+ZLpsxOxEmg1fIOEBwbrQGNRsfk1j9EdLZiU9pQLyYI8AyVruWtxhIoRjJlGTs8aO9Ei9hrIHMVN9wXpYgOLR8jyg1Y00KuIKtTmlk5vryByy0AZY=
Received: by 10.67.30.13 with SMTP id h13mr6195016ugj.45.1201919420491;
        Fri, 01 Feb 2008 18:30:20 -0800 (PST)
Received: from localhost.localdomain ( [83.8.228.251])
        by mx.google.com with ESMTPS id 28sm4414071ugc.21.2008.02.01.18.30.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 01 Feb 2008 18:30:18 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m122UA6H023775;
	Sat, 2 Feb 2008 03:30:12 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m122U5VW023771;
	Sat, 2 Feb 2008 03:30:05 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <tzks5d8d.fsf@blue.sea.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72211>

Jari Aalto <jari.aalto@cante.net> writes:

> * Fri 2008-02-01 Jakub Narebski <jnareb@gmail.com>
> * Message-Id: m3y7a46vmf.fsf@localhost.localdomain
> > It seems that I was mistaken about that. Junio suggestion of following
> > others example and using "{}" curly brackets for grouping alternate
> > choices is IMHO a good solution.
> 
> That is another common syntax which I presented previously.

Well, at least rpm and cpio manpages uses it.
 
> > The traditional manpages use /italics/ (usually rendered as
> > _underlined_ text on terminals) to denote placeholders (user supplied
> > input).
> 
> That does not matter. The text should stand out as it it in environment,
> which do not render termcap or other terminal capabilities.

Nevertheless it would be nice if our AsciiDoc configuration generated
italics or underline for manpage, and italics for HTML output for
placeholders, *in addition* to using angle parentheses (angle braces)
as delimites for placeholder parameters.

> > From http://www.linux.com/articles/34212
> 
> Here are the POSIX/Susv guidelines for the manual pages, I've marked the
> relevant points with **....**. We were both right: Angles mean required
> and grouping.

Errr... as far as I understand angles means placeholders, i.e. user
supplied input. You can use "[<file>...]" for optional placeholder;
everything which is not inside brackets is required.

> I think Git's manual pages should follow standard notation. E.g. the
> use of parentheses should be replaced with curly braces.

It is used quite frequently in git manpages. Using parentheses to
delimit required alternate parts seems quite sensible. 

Examples of usage:

  'git-branch' (-m | -M) [<oldbranch>] <newbranch>
  'git-branch' (-d | -D) [-r] <branchname>...
  'git-commit' ... [(-c | -C) <commit> | -F <file> | -m <msg> | --amend]
  'git-name-rev' ... ( --all | --stdin | <committish>... )
  'git-show-branch' (-g|--reflog)[=<n>[,<base>]] [--list] [<ref>]
  'git-update-ref' [-m <reason>] (-d <ref> <oldvalue> | [--no-deref] <ref> <newvalue> [<oldvalue>])

and even stranger

  'git-ls-files' ... (--[cached|deleted|others|ignored|stage|unmerged|killed|modified])\*

Note that in the POSIX/SUSV below parentheses / curly braces are not
mentioned.

> -----------------------------------------------------------------------
> http://www.opengroup.org/onlinepubs/009695399/utilities/xcu_chap01.html#tag_01_11
> 
> 12.1 Utility Argument Syntax
> http://www.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap12.html#tag_12_01
> 
>     [...]
> 
>     4. Frequently, names of parameters that **require** substitution by
>     actual values are shown with embedded underscores. Alternatively,
>     parameters are shown as follows:
> 
>         <parameter name>
> 
>     The angle brackets are used for the symbolic grouping of a phrase
>     representing a single parameter and conforming applications shall
>     not include them in data submitted to the utility.

This means that <param> denotes placeholder: parameter that requires
**subsititution** (this part should be emphasized!). Such parameter
might have multi-word name. Such parameter might be required, but
might be optional.
 
>     [...]
>     7. Arguments or option-arguments enclosed in the '[' and ']'
>     notation are **optional** and can be omitted. Conforming applications
>     shall not include the '[' and ']' symbols in data submitted to the
>     utility.
> 
>     8. Arguments separated by the '|' vertical bar notation are
>     **mutually-exclusive.**

Note that is natural that '[' and ']' also are limits of mutualy
exclusive parameters: "cmd [ A | B ]" means "cmd" or "cmd A" or "cmd B".
It is not specified explicitely, but IMHO is quite natural. And it is
what is used in different manpages, see examples I have provided in my
previous post in this subthread.

>     9. Ellipses ( "..." ) are used to denote that one or **more**
>     occurrences of an option or operand are allowed. When an option or
>     an operand followed by ellipses is enclosed in brackets, **zero** or
>     more options or operands can be specified.
> 
>         utility_name [-g option_argument]...[operand...]

Note that one is not followed strictly, and one should take note of
that. For example to make sure that everybody knows that it is zero or
more one would use [<param>...], and to make use that it is one or
more one would use "<param> [<param>...]", just to be sure.

I'm not for or against any form.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
