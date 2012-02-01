From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2012, #08; Tue, 31)
Date: Wed, 01 Feb 2012 12:37:50 -0800
Message-ID: <7v39au47dt.fsf@alter.siamese.dyndns.org>
References: <7vlion3tr5.fsf@alter.siamese.dyndns.org>
 <m3fweudaf6.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Bernhard R. Link" <brl+git@mail.brlink.eu>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 01 21:38:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsgwL-0008K2-GD
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 21:38:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588Ab2BAUhx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 15:37:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56234 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752039Ab2BAUhx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 15:37:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 367E65162;
	Wed,  1 Feb 2012 15:37:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QYN/Vj6hT35nA9kwDOmWc7yqUw4=; b=criYM2
	wjWEd1N+7jUUQq4yE3CDoaufsE92icPfik8dsOp2QlX/5pkVp0vFt+Vn19AlWc9S
	MMH2bHL9NRIBb77/xMKD4n02bYUx1khwNw7rwFJ189EyND/bQ86KnwtNgTLTYn3C
	wD0cvQZvMalnXJoWfv6GZN70DcHt9qQZFif64=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O2nuI71Rj/djnz7Xi2sY93em3OMN+Doh
	/tbWbc1l5kuuSpdmtXcVdIqgRCJdBbDM8MTW4CV5cV6JSRp6LI4XF6deqFa3HrCf
	IxMpx72VlAYL6N7ihDQCM12Asi3jKIUWx5r9OpeYaSxDmvTJSic/4ouRLvTGlWij
	+9KGIG325vQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E3CA5161;
	Wed,  1 Feb 2012 15:37:52 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AAE5C5160; Wed,  1 Feb 2012
 15:37:51 -0500 (EST)
In-Reply-To: <m3fweudaf6.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Wed, 01 Feb 2012 04:07:14 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9C7052A2-4D14-11E1-883D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189534>

Jakub Narebski <jnareb@gmail.com> writes:

> Hmmm... strange.  I have applied my patches on top of earlier version
> of project_filter commits:
>
>    - gitweb: Make project search respect project_filter
>    - gitweb: Improve projects search form
>    - gitweb: place links to parent directories in page header
>    - gitweb: add project_filter to limit project list to a subdirectory
>
> and all gitweb tests passes.
>
> I will investigate.

I am getting 

    7ad1b64084ff003f71fe749a3e5a74d071a193d8 is the first bad commit
    commit 7ad1b64084ff003f71fe749a3e5a74d071a193d8
    Author: Bernhard R. Link <brl+git@mail.brlink.eu>
    Date:   Mon Jan 30 21:05:47 2012 +0100

        gitweb: move hard coded .git suffix out of git_get_projects_list

*** t9502-gitweb-standalone-parse-output.sh ***
ok 1 - setup
ok 2 - snapshot: full sha1
ok 3 - snapshot: shortened sha1
ok 4 - snapshot: almost full sha1
ok 5 - snapshot: HEAD
ok 6 - snapshot: short branch name (master)
ok 7 - snapshot: short tag name (first)
ok 8 - snapshot: full branch name (refs/heads/master)
ok 9 - snapshot: full tag name (refs/tags/first)
ok 10 - snapshot: hierarchical branch name (xx/test)
ok 11 - forks: setup
ok 12 - forks: not skipped unless "forks" feature enabled
ok 13 - forks: forks skipped if "forks" feature enabled
not ok - 14 forks: "forks" action for forked repository
#
#               gitweb_run "p=foo.git;a=forks" &&
#               grep -q ">foo/foo-forked\\.git<" gitweb.body &&
#               grep -q ">fork of foo<"          gitweb.body
#
ok 15 - forks: can access forked repository
ok 16 - forks: project_index lists all projects (incl. forks)
# failed 1 among 16 test(s)

The output file gitweb.body has this in it:

<div class="page_body">
<br /><br />
404 - No forks found
<br />
</div>
<div class="page_footer">
