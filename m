From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2009, #05; Mon, 16)
Date: Tue, 17 Feb 2009 02:17:30 -0800 (PST)
Message-ID: <m3wsbps708.fsf@localhost.localdomain>
References: <7vfxid8phr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 11:19:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZN2g-0004IG-AR
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 11:19:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbZBQKRe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 05:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbZBQKRd
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 05:17:33 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:58387 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbZBQKRc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 05:17:32 -0500
Received: by fxm13 with SMTP id 13so6588658fxm.13
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 02:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=+KxOvpuSLF97d2L2Ei/3W8exr4SNCcTVX52NrHSb29s=;
        b=jyMuUjUZs3t0/xW8VzwMbPoYx7US0oqwYLdXSKfswVs4Dv6xkDtJI41+RINyehPMsb
         pW6Q4GbO6FGAmgafrnJiwZN/U/0aSzWPrAebgkDa1euPPfVFcHFPdxgg+ng5S38NFQFS
         2D4eVbk3Q4IcWP2ZnCvz6pfdQGZ3LrjWkC3G8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=CuSlh2P1sR6b09ky9pfcLze/zDVtL69ZZ0NuQ/luZUfciYEfk7TB8gImGT6vKaz935
         cN3YqdPG0ZM2JaOYR6vU3ltDv9hS3KAr1JmUVXyzmb2k5xcunZKMRIrHLZ/Xe7eroVtQ
         nFg4ingaDel2TaA+bncllY4dFIVDNnR9kIOwY=
Received: by 10.223.108.15 with SMTP id d15mr98401fap.105.1234865850797;
        Tue, 17 Feb 2009 02:17:30 -0800 (PST)
Received: from localhost.localdomain (abwe74.neoplus.adsl.tpnet.pl [83.8.228.74])
        by mx.google.com with ESMTPS id k10sm3974063nfh.23.2009.02.17.02.17.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Feb 2009 02:17:30 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n1HAGu7L010415;
	Tue, 17 Feb 2009 11:17:07 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n1HAGebI010411;
	Tue, 17 Feb 2009 11:16:40 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vfxid8phr.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110349>

Junio C Hamano <gitster@pobox.com> writes:

> ----------------------------------------------------------------
> [New Topics]
> 
> * gb/gitweb-base (Sun Feb 15 10:18:36 2009 +0100) 1 commit
>  - gitweb: fix wrong base URL when non-root DirectoryIndex
> 
> Should this go in 1.6.2-rc2?

Isn't it in master already?

> 
> * tr/gcov (Sun Feb 15 23:25:45 2009 +0100) 8 commits
>  - Test git-patch-id
>  - Test rev-list --parents/--children
>  - Test log --decorate
>  - Test fsck a bit harder
>  - Test log --graph
>  - Test diff --dirstat functionality
>  - Test that diff can read from stdin
>  - Support coverage testing with GCC/gcov

Hmmmm... wouldn't it be nice to have more tests?

> 
> * jc/add-p-unquote (Mon Feb 16 22:43:43 2009 -0800) 1 commit
>  - git-add -i/-p: learn to unwrap C-quoted paths

It might be considered bugfix, but IIRC it is still cooking,
so perhaps it wouldn't be absolutely ready for 1.6.2

> 
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
> I thought recent tig discussion may blow new life into it, but is this
> unneeded?  If so I'd rather revert it (or discard after 1.6.2).

It would be nice to have for gitweb... especially if it is a merge
commit that gets the blame (which I guess should happen only for 'evil
merge' case).

> 
> * db/foreign-scm (Sun Jan 11 15:12:10 2009 -0500) 3 commits
>  - Support fetching from foreign VCSes
>  - Add specification of git-vcs helpers
>  - Add "vcs" config option in remotes
> 
> The "spec" did not seem quite well cooked yet, but in the longer term I
> think something like this to allow interoperating with other SCMs as if
> the other end is a native git repository is a very worthy goal.

I wonder what are the limitations: I guess that importer has to be
incremental (and probably store additional info, or at least cache
it).  IIRC the example was for Perforce; much more interesting would
be to have example for Subversion, I guess.

> 
> * cc/replace (Mon Feb 2 06:13:06 2009 +0100) 11 commits
>  - builtin-replace: use "usage_msg_opt" to give better error messages
>  - parse-options: add new function "usage_msg_opt"
>  - builtin-replace: teach "git replace" to actually replace
>  - Add new "git replace" command
>  - environment: add global variable to disable replacement
>  - mktag: call "check_sha1_signature" with the replacement sha1
>  - replace_object: add a test case
>  - object: call "check_sha1_signature" with the replacement sha1
>  - sha1_file: add a "read_sha1_file_repl" function
>  - replace_object: add mechanism to replace objects found in
>    "refs/replace/"
>  - refs: add a "for_each_replace_ref" function
> 
> I think the code is much cleaner than the first round, but I am not
> convinced it is doing the right thing in the connectivity traverser.  
> Independent review sorely needed.

This is certainly something that it would be nice to have.

> 
> * sc/gitweb-category (Fri Dec 12 00:45:12 2008 +0100) 3 commits
>  - gitweb: Optional grouping of projects by category
>  - gitweb: Split git_project_list_body in two functions
>  - gitweb: Modularized git_get_project_description to be more generic
> 
> Design discussion between Jakub and Sebastien seems to have stalled, but
> Jakub seems to be taking this over.

The fact that discussion stalled is largely my fault as reviewer
wanting for this series to do too much 'by the way' changes, and
preparation for further changes.

I don't know when I would have time to actively work on this, but I
have it in my repository, so it wouldn't vanish

  git://repo.or.cz/git/jnareb-git.git gitweb/category
  http://repo.or.cz/w/git/jnareb-git.git?a=shortlog;h=refs/heads/gitweb/category

> 
> * jc/fsck (Fri Jan 30 02:33:47 2009 -0800) 4 commits
>  - fsck: three levels of validation
>  - verify-pack: add --quick
>  - verify_pack(): allow a quicker verification for a pack with
>    version 2 idx
>  - pack-check.c: minor formatting fix to match coding style
> 
> J6t has a good point that if this had any value then medium level should
> replace the default.  I am tempted to actually dropping this as a failed
> experiment.

I recall that medium level wasn't that much faster, isn't it?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
