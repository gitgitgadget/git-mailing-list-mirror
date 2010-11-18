From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2010, #02; Wed, 17)
Date: Thu, 18 Nov 2010 06:00:23 -0800 (PST)
Message-ID: <m3mxp668cy.fsf@localhost.localdomain>
References: <7v1v6je9g8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 18 15:00:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ52P-0001Tx-Sf
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 15:00:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758020Ab0KROA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 09:00:27 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:63263 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756852Ab0KROA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 09:00:26 -0500
Received: by ewy8 with SMTP id 8so1920221ewy.19
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 06:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=18mje8wqfGR4uFaOBgfeuPQzgaEOnZEzCSFro2tX2zA=;
        b=rx+rfKusPCgmY3hMIEei2HqT8DDweDU9Na97gMENY4MqLLwbL4fQg6HPi32mkbFJ8p
         P+vvGlDM6GG0GUV3H0UWvzKNBJkRDxLASDC+qPEJ/ktUqkxGqqw79EB7VcBa6tDCa+GQ
         rq5hqQsC6oblTmR5V36GXy41VYQodJhoVYGtw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=yDXAHheoAIhtK6Zfo2f//UatDxU+6HeKQtM6Cgv3QcHN1lvwVdUsUz3JmcF2myZqIx
         LwdFmpZV+fyEES6OqVEPL1wPZmUOyetCudFvNAlBwfeozgXWDDk1Fdo7EdkFkZXl7VrP
         ybAkntC1hldaOOVlMn/DiVckmuZRZfjqg+8zU=
Received: by 10.213.4.12 with SMTP id 12mr3729123ebp.39.1290088824531;
        Thu, 18 Nov 2010 06:00:24 -0800 (PST)
Received: from localhost.localdomain (abva111.neoplus.adsl.tpnet.pl [83.8.198.111])
        by mx.google.com with ESMTPS id w20sm408904eeh.18.2010.11.18.06.00.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Nov 2010 06:00:23 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oAIDxdxm020829;
	Thu, 18 Nov 2010 14:59:49 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oAIDxAvK020815;
	Thu, 18 Nov 2010 14:59:10 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7v1v6je9g8.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161668>

Junio C Hamano <gitster@pobox.com> writes:

> --------------------------------------------------
> [Graduated to "master"]
 
> * bg/maint-gitweb-test-lib (2010-10-20) 1 commit
>   (merged to 'next' on 2010-11-05 at 0ead869)
>  + t/gitweb-lib: Don't pass constant to decode_utf8

> * jn/gitweb-test (2010-09-26) 4 commits
>   (merged to 'next' on 2010-11-05 at 90b3adf)
>  + gitweb/Makefile: Include gitweb/config.mak
>  + gitweb/Makefile: Add 'test' and 'test-installed' targets
>  + t/gitweb-lib.sh: Add support for GITWEB_TEST_INSTALLED
>  + gitweb: Move call to evaluate_git_version after evaluate_gitweb_config
>  (this branch is used by jh/gitweb-caching.)

Thanks.


Sidenote: recently sent

  gitweb: selectable configurations that change with each request

practically reverts

  gitweb: Move call to evaluate_git_version after evaluate_gitweb_config

Just FYI.

> --------------------------------------------------
> [New Topics]

> * gb/gitweb-remote-heads (2010-11-11) 11 commits
>  - git instaweb: enable remote_heads
>  - gitweb: group remote heads by remote
>  - gitweb: provide a routine to display (sub)sections
>  - gitweb: refactor repository URL printing
>  - gitweb: remotes view for a single remote
>  - gitweb: allow action specialization in page header
>  - gitweb: nagivation menu for tags, heads and remotes
>  - gitweb: separate heads and remotes lists
>  - gitweb: git_get_heads_list accepts an optional list of refs
>  - gitweb: introduce remote_heads feature
>  - gitweb: use fullname as hash_base in heads link
> 
> Acked by Jakub.  Will merge to next.

Thanks.
 
> * jn/gitweb-time-hires-comes-with-5.8 (2010-11-09) 1 commit
>  - gitweb: Time::HiRes is in core for Perl 5.8
> 
> Looked reasonable.  Will merge to next.

Thanks. With or without improvement to commit message?
 
> --------------------------------------------------
> [Stalled]

> * jh/gitweb-caching (2010-11-01) 4 commits
>  . gitweb: Minimal testing of gitweb caching
>  . gitweb: File based caching layer (from git.kernel.org)
>  . gitweb: add output buffering and associated functions
>  . gitweb: Prepare for splitting gitweb
> 
> Temporarily ejected while I shuffled jn/gitweb-testing; will queue the
> latest back in pu or perhaps in next.

The advantage of 'gitweb: File based caching layer (from git.kernel.org)'
is that it is tested in real-life on heavy load (assuming that 
git.kernel.org uses the same version as is/would be in pu/next).

The disadvantage is that it is seriously messy code.  Something that I
wanted to improve in my rewrite.  This is only minimal fixup.


I am thinking about splitting main 'gitweb: File based caching layer
(from git.kernel.org)' patch in two, separating moving test for
$caching_enabled out of cache_fetch to separate commit (largest change
to original J.H. submission), but leaving hardening "do 'cache.pl';"
and replacing 0/1 valued $cache_enable with boolean valued 
$caching_enabled.

Because currently new tests in t9501 and t9502 (examining status and
output of gitweb with caching enabled) do not pass, I am thinking
about adding new configuration know turning off "Generating..." page.

BTW. should I forge J.H. signoffs, and add mine?

> * tr/config-doc (2010-10-24) 2 commits
>  . Documentation: complete config list from other manpages
>  . Documentation: Move variables from config.txt to separate file
> 
> This unfortunately heavily conflicts with patches in flight...

Would creating a script for generating contents of 'Documentation:
Move variables from config.txt to separate file', including it either
in commit message or in comments, help this issue?

There is also problem with 'Documentation: complete config list from
other manpages' in that it needs (at least in one version) for all
config sections to be marked as such (see discussion in thread).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
