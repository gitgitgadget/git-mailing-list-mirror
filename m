From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2009, #03; Sat, 07)
Date: Sat, 07 Feb 2009 15:54:54 -0800 (PST)
Message-ID: <m3iqnlvm29.fsf@localhost.localdomain>
References: <7vk581syj1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?iso-8859-15?q?S=E9bastien_Cevey?= <seb@cine7.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 00:56:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVx29-0000Yx-8f
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 00:56:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753753AbZBGXy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 18:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753658AbZBGXy6
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 18:54:58 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:27211 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753095AbZBGXy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 18:54:58 -0500
Received: by fg-out-1718.google.com with SMTP id 16so814721fgg.17
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 15:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=puCxo/Mwqxo8PpqPMHx/Hro0R15nvnJGZnqu8ljs+w0=;
        b=AyLzhvNqLMGhMosLo2EemkXQfDXEbgDhz6hh0gH9pswdt6CfcH5A+NOodQrFRykecR
         uSax6WBa1aSm3Ga9e+WVmjvsHldGA0dBYErIaJePgFh1OrblQLi1OXPOa7nT58yGQlsd
         B9pxvDqMoIaTTu5/6xjR3kbma8kXFpyX+96pk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=D75MGaqD4111xv9ixhKZv/hZKjoP3IkaFL0A9uEVCa6cL5KtE0QJByw7EVADyzZt8I
         OJzqkPKYW3z/c/+3Cr5Ugy6AMdROMydNN2k9CKxnCQVxY/fAJKLfXP43jRH216ey7xCg
         4/WpYkUn3Z5EbeI+YbhA8cWr3Rm4HpjHA9wDY=
Received: by 10.86.4.14 with SMTP id 14mr110957fgd.76.1234050895417;
        Sat, 07 Feb 2009 15:54:55 -0800 (PST)
Received: from localhost.localdomain (abwm89.neoplus.adsl.tpnet.pl [83.8.236.89])
        by mx.google.com with ESMTPS id e20sm8059539fga.56.2009.02.07.15.54.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Feb 2009 15:54:54 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n17Nu0pa031998;
	Sun, 8 Feb 2009 00:56:01 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n17NtwVX031995;
	Sun, 8 Feb 2009 00:55:58 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vk581syj1.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108902>

Junio C Hamano <gitster@pobox.com> writes:

> ----------------------------------------------------------------
> [New Topics]
> 
> * jn/gitweb-committag (Fri Feb 6 10:12:41 2009 +0100) 1 commit
>  + gitweb: Better regexp for SHA-1 committag match

The v1, with adding word boundary only, isn't it?
 
> ----------------------------------------------------------------
> [Stalled and may need help and prodding to go forward]
> 
> * jc/blame (Wed Jun 4 22:58:40 2008 -0700) 2 commits
>  + blame: show "previous" information in --porcelain/--incremental
>    format
>  + git-blame: refactor code to emit "porcelain format" output
> 
> This gives Porcelains (like gitweb) the information on the commit _before_
> the one that the final blame is laid on, which should save them one
> rev-parse to dig further.  The line number in the "previous" information
> may need refining, and sanity checking code for reference counting may
> need to be resurrected before this can move forward.
> 
> Recent tig discussion may blow new life into it.  Let's see.

I think that in gitweb we can simply relax admissible (valid) values
for 'h'/'hb'/'hbp' parameters (currently checked by validate_refname)
and allow combination of ^, ^<n>, and ~<n> suffixes, and simply resolve
them only if user click on the link (perhaps using redirect like for
generic 'object' view).

The "previous" information doesn't solve the problem what was
the line number of line before change... but it might help tig.
 
> * sc/gitweb-category (Fri Dec 12 00:45:12 2008 +0100) 3 commits
>  - gitweb: Optional grouping of projects by category
>  - gitweb: Split git_project_list_body in two functions
>  - gitweb: Modularized git_get_project_description to be more generic
> 
> Design discussion between Jakub and Sebastien seems to have stalled.

I tried to redo the patches, but 2nd do not apply using "git am -3"
because of changes in gitweb.  Sebastien, could you resend this series,
marking it as [PATCHv3 n/3 (resend)] or something like that (unless you
would modify them)?
 
> ----------------------------------------------------------------
> [Actively cooking]
>
> * js/valgrind (Thu Feb 5 22:03:00 2009 +0100) 9 commits
>  + valgrind: do not require valgrind 3.4.0 or newer
>  + test-lib: avoid assuming that templates/ are in the GIT_EXEC_PATH
>  + Tests: let --valgrind imply --verbose and --tee
>  + Add a script to coalesce the valgrind outputs
>  + t/Makefile: provide a 'valgrind' target
>  + test-lib.sh: optionally output to test-results/$TEST.out, too
>  + Valgrind support: check for more than just programming errors
>  + valgrind: ignore ldso and more libz errors
>  + Add valgrind support in test scripts

This would help finding bugs in feature freeze, wouldn't it?

> ----------------------------------------------------------------
> [Graduated to "master"]
> 
> * js/notes (Tue Jan 13 20:57:16 2009 +0100) 6 commits
>  + git-notes: fix printing of multi-line notes
>  + notes: fix core.notesRef documentation
>  + Add an expensive test for git-notes
>  + Speed up git notes lookup
>  + Add a script to edit/inspect notes
>  + Introduce commit notes

Nice!

-- 
Jakub Narebski
Poland
ShadeHawk on #git
