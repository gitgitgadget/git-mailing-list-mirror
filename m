From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [RFC] Embedding asciidoc manpages in the cg scripts
Date: Wed, 11 May 2005 23:32:17 +0200
Message-ID: <20050511213217.GG22686@pasky.ji.cz>
References: <20050511014445.GA14377@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 23:25:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVyhM-0007FZ-6L
	for gcvg-git@gmane.org; Wed, 11 May 2005 23:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVEKVcb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 17:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVEKVcb
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 17:32:31 -0400
Received: from w241.dkm.cz ([62.24.88.241]:4290 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261249AbVEKVcT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 May 2005 17:32:19 -0400
Received: (qmail 6177 invoked by uid 2001); 11 May 2005 21:32:17 -0000
To: Jonas Fonseca <fonseca@diku.dk>
Content-Disposition: inline
In-Reply-To: <20050511014445.GA14377@diku.dk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, May 11, 2005 at 03:44:45AM CEST, I got a letter
where Jonas Fonseca <fonseca@diku.dk> told me that...
> Index: cg-add
> ===================================================================
> --- 1cfa9d5a4f751f8ddd8b9a40758b8d6d0141264e/cg-add  (mode:100755)
> +++ uncommitted/cg-add  (mode:100755)
> @@ -1,14 +1,36 @@
>  #!/usr/bin/env bash
>  #
> -# Add new file to a GIT repository.
> -# Copyright (c) Petr Baudis, 2005
> +# CG-ADD(1)
> +# =========

This is really awful - it carries no interesting information whatsoever
since that is pretty obvious from the fact that it is in file called
cg-add.

>  #
> +# NAME
> +# ----
> +# cg-add - add files to a GIT repository

Half of this is useless, too.

I think you should just keep the first paragraph of the files as it is
now. Don't touch it, just parse it.

> +#
> +# SYNOPSIS
> +# --------

No need for this heading either.

> +USAGE="cg-add FILE..."
> +#
> +# DESCRIPTION
> +# -----------
>  # Takes a list of file names at the command line, and schedules them
>  # for addition to the GIT repository at the next commit.
> +#
> +# The command will fail if one of the given files does not exist.
> +#
> +# cg-add is part of Cogito, an SCM-like toolkit for managing GIT trees.

Useless.

> +#
> +# OPTIONS
> +# -------
> +# No options.

The rest of DESCRIPTION and OPTIONS looks fine.

I'd just expect you to be much less intrusive in the in-file comments
and do more work when processing the stuff. I'm commenting on how it
looks inside of the sources - do whatever is necessary when processing
it to generate a proper-looking manpage from it.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
