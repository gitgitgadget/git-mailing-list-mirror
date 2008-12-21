From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2008, #03; Sun, 21)
Date: Sun, 21 Dec 2008 11:03:42 -0800 (PST)
Message-ID: <m363ldcpv9.fsf@localhost.localdomain>
References: <7vr641pvid.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Simon Schubert" <corecode@fs.ei.tum.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 21 20:06:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LETde-00056r-AJ
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 20:06:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbYLUTDp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 14:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbYLUTDp
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 14:03:45 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:19003 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbYLUTDp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 14:03:45 -0500
Received: by ey-out-2122.google.com with SMTP id 22so178481eye.37
        for <git@vger.kernel.org>; Sun, 21 Dec 2008 11:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=hSdgfA+6MFbSFDSAa+5y252Y8ZpHH207mGRWzTvzN5M=;
        b=bSYw69TVWXxrGTVJaxrz2s9/MTgBOF3OE3/7i32PdY4ttH7Xkv95rKPEjPi7vOsEWM
         ErLlQDUM/9dJyYjU7+NGFs0YXsU0gy7xeI7D3Z7Ex4Geid0orkoS1FD5HYZT22FfVncP
         XnIYLHH4IncIX5NTqwwn7NhBOV4nQyxnybxZY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=upeo0ra2igSb/uXMTnIaZ29l+m9xVyXtTosyx/1Rx+lf/mZVLedNa29+ZFpIiIz1ps
         Q0KcBwNVQJmmUewA7QV68j9WVIZCmys3D7OdPhTRNxghCSgcAIeLzSUYkBhJipTzp4Fd
         Y7uT4KCQud3INViJWOs5Cxs/fwULWuhVj6dM8=
Received: by 10.66.220.12 with SMTP id s12mr5814542ugg.22.1229886223248;
        Sun, 21 Dec 2008 11:03:43 -0800 (PST)
Received: from localhost.localdomain (abww40.neoplus.adsl.tpnet.pl [83.8.246.40])
        by mx.google.com with ESMTPS id 40sm12955222uge.51.2008.12.21.11.03.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Dec 2008 11:03:42 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBLJ3e7P017112;
	Sun, 21 Dec 2008 20:03:40 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mBLJ3cKP017109;
	Sun, 21 Dec 2008 20:03:38 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vr641pvid.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103707>

Junio C Hamano <gitster@pobox.com> writes:

> ----------------------------------------------------------------
> [New Topics]
> 
> * mk/gitweb-feature (Mon Dec 15 22:16:19 2008 -0800) 1 commit
>  - gitweb: unify boolean feature subroutines

The last version, I assume? IMHO it is a good change.
 
> * js/notes (Sat Dec 20 13:06:03 2008 +0100) 4 commits
>  - Add an expensive test for git-notes
>  - Speed up git notes lookup
>  - Add a script to edit/inspect notes
>  - Introduce commit notes

Nice to see it resurrected.
 
> * jn/gitweb-blame (Thu Dec 11 01:33:29 2008 +0100) 3 commits
>  - gitweb: cache $parent_commit info in git_blame()
>  - gitweb: A bit of code cleanup in git_blame()
>  - gitweb: Move 'lineno' id from link to row element in git_blame
> 
> I've briefly looked at the resurrection of Ajaxy blame that comes on top
> of this series and it looked promising.

There are a few issues to test and to resolve with Ajaxy blame
(blame_incremental):
 * does it work correctly with browsers other than Mozilla 1.17.2
   and Konqueror 3.5.3?
 * what gives better performance, and better visible performance
   on the client side: onreadystatechange or setInterval (and what
   interval)?
 * is it better to do more work on the server side, and for example
   send JSON with ready commits data; it is better to enable autoflush
   if sending raw "git blame --incremental" output?
 * the 'how long it took to generate page' patch should be decoupled,
   improved, and send separately...
 
> * sc/gitweb-category (Fri Dec 12 00:45:12 2008 +0100) 3 commits
>  - gitweb: Optional grouping of projects by category
>  - gitweb: Split git_project_list_body in two functions
>  - gitweb: Modularized git_get_project_description to be more generic

I think it is not yet finished, but it looks nice.
 
> * gb/gitweb-patch (Thu Dec 18 08:13:19 2008 +0100) 4 commits
>  - gitweb: link to patch(es) view in commit(diff) and (short)log view
>  - gitweb: add patches view
>  - gitweb: change call pattern for git_commitdiff
>  - gitweb: add patch view
> 
> Updated series.

I'd have to review resend series, but I think it would get Ack from
me.

> * cc/bisect-replace (Mon Nov 24 22:20:30 2008 +0100) 9 commits
> * nd/narrow (Sun Nov 30 17:54:38 2008 +0700) 17 commits
> * jc/clone-symref-2 (Sat Nov 29 23:38:21 2008 -0800) 7 commits
> * jc/clone-symref (Sat Nov 29 23:38:21 2008 -0800) 6 commits

Those are interesting...

> * jc/apply (Sun Sep 7 14:36:24 2008 -0700) 1 commit
>  . WIP

Uh?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
