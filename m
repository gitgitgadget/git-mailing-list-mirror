From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 2/4] Add git-sequencer prototype documentation
Date: Tue, 01 Jul 2008 06:02:54 -0700 (PDT)
Message-ID: <m34p79hhy9.fsf@localhost.localdomain>
References: <1214879914-17866-1-git-send-email-s-beyer@gmx.net>
	<1214879914-17866-2-git-send-email-s-beyer@gmx.net>
	<1214879914-17866-3-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Tue Jul 01 15:04:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDfWs-0003bU-9e
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 15:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756093AbYGANDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 09:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757944AbYGANC7
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 09:02:59 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:16540 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757901AbYGANC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 09:02:57 -0400
Received: by nf-out-0910.google.com with SMTP id d3so583581nfc.21
        for <git@vger.kernel.org>; Tue, 01 Jul 2008 06:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=NDm881FHWc7H9tZYhTZMaTQKnrTsqLtM73ta8WW4uR0=;
        b=YwXeG4jRI6yjR5uJICbHPSm2R7sMX6YKVNx3pSBrj+Y4O5kE1LedTHLKo5+pDAfjys
         yrnjAmSSfZt4a0xSa1CxbJ/PZnkJ2a3WbnD7VKlvXZI2Vdup/Od+hxezfVVxqJZ0TCfo
         +HRPYCqUi0DUlmDfS5ekNG3IHYbXjEsOKIKt8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=R1xmWIx5oElU5W48zyLyZGzt7J/h1hnQ36u6XeRyTnwIBRvbEkMxqL3mm4PgWgM7ho
         eG6/cXcr0jyCj35TbWPfwHyW8QiQ6dfGZ5QLj2Bg98oACL18NbqgSoRviV6ZCUTI46UI
         sQt7uOTombUIdoIO2J67y8N1aIRR7/fzasnvc=
Received: by 10.210.142.6 with SMTP id p6mr5315111ebd.102.1214917375861;
        Tue, 01 Jul 2008 06:02:55 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.248.226])
        by mx.google.com with ESMTPS id y34sm8289995iky.10.2008.07.01.06.02.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Jul 2008 06:02:54 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m61D6epA029940;
	Tue, 1 Jul 2008 15:06:41 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m61D6cEn029937;
	Tue, 1 Jul 2008 15:06:38 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1214879914-17866-3-git-send-email-s-beyer@gmx.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87035>

Stephan Beyer <s-beyer@gmx.net> writes:

> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Daniel Barkalow <barkalow@iabervon.org>

Cc mentors?

> +git-sequencer will usually be called by another git porcelain, like
> +linkgit:git-am[1] or linkgit:git-rebase[1].

I hope that it could be also used by git-cherry-pick and git-revert,
so it would be possible to pick more than one commit...

> +In case of a conflict or request in the TODO file, git-sequencer will
> +pause. On conflict you can use git-diff to locate the markers (`<<<<<<<`)
> +and make edits to resolve the conflict.
> +
> +For each file you edit, you need to tell git the changes by doing
> +
> +    git add <file>
> +
> +After resolving the conflict manually and updating the index with the
> +desired resolution, you can continue the sequencing process with
> +
> +    git sequencer --continue

Does it run pre-commit hooks, for example checking for merge markers
(but also whitespace errors), and can those checks be disabled?

> +-B::
> +--batch::
> +	Run in batch mode. If unexpected user intervention is needed
> +	(e.g. a conflict or the need to run an editor), git-sequencer fails.
> ++
> +Note that the sanity check fails, if you use this option
> +and an instruction like `edit` or `pause`.

s/.$/ is in the TODO file./

> +--edit::
> +	Invoke editor to edit the undone rest of the TODO file.

Does it mean that editor will be invoked with only _unprocessed_
part of the TODO file?  It looks like it, but it might be not
obvious to some.

> +merge [options] <commit-ish1> <commit-ish2> ... <commit-ishN>::
> +	Merge commits into HEAD.

Nice.

"HEAD" mean last picked up / created commit, isn't it?

> ++
> +A commit can also be given by a mark, if prefixed with a colon.

"You can refer to commit by mark", perhaps?

> +	--standard;;
> +		Generates a commit message like 'Merge ... into HEAD'.
> +		See also linkgit:git-fmt-merge-msg[1].

Is it short for `--standard-message`?

> +pick [options] <commit>::
> +	Pick (see linkgit:git-cherry-pick[1]) a commit.
> +	Sequencer will pause on conflicts.
> ++
> +See the following list and 'GENERAL OPTIONS' for values of `options`:
> +
> +	-R;;
> +	--reverse;;
> +		Revert the changes introduced by pick <commit>.
> +
> +	--mainline=<n>;;
> +		Allows you to pick merge commits by specifying the
> +		parent number (beginning from 1) to let sequencer
> +		replay the changes relative to the specified parent.
> +		+
> +This option does not work together with `-R`.

Why?  I would have thought that it would work...

> +patch [options] <file>::
[...]
> +	-*;;
> +		Any other dash-prefixed option is passed to
> +		linkgit:git-apply[1].
> +		This is especially useful for flags like
> +		`--reverse`, `-C<n>`, `-p<n>` or `--whitespace=<action>`.

Do all options make sense?  What about `--index' and `--cached',
or about different no-apply options?

> +ref <ref>::
> +	Set ref `<ref>` to the current HEAD, see also
> +	linkgit:git-update-ref[1].

So this functions like "git reset --soft <ref>", isn't it?

> +squash [options] --from <mark>::
> +	Squash all commits from the given mark into one commit.
> +	There must not be any `merge` instructions between the
> +	`mark` instruction and this `squash --from` instruction.

Can you use <commit> instead of <mark> here?

> +	--include-merges;;
> +		Sanity check does not fail if you have merges
> +		between HEAD and <mark>.

How do you squash merges?  Creating merge with an union of parents,
excluding commits which got squashed?

It means

  ...a---b---c---d         ...[abcd]
            /        ==>        /
      ...x-/               ..x-/

but

  ...a---b---c---d          ...[abcd]
      \     /        ==>
       \-x-/ 

> +RETURN VALUES
> +-------------
> +* any other value on error, e.g.
> +  running git-sequencer on a bare repository.

Don't you enumerate those return values?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
