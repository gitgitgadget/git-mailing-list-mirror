From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] git-checkout(1) mention fate of extraneous files
Date: Sat, 17 Jan 2009 13:57:17 +0100
Message-ID: <200901171357.18005.markus.heidelberg@web.de>
References: <87k58u4vlq.fsf@jidanni.org>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Sat Jan 17 13:58:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOAkW-0000gE-9H
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 13:58:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757011AbZAQM4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 07:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756947AbZAQM4g
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 07:56:36 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:57854 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756939AbZAQM4f (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 07:56:35 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id 5610EFBD98CC;
	Sat, 17 Jan 2009 13:56:34 +0100 (CET)
Received: from [89.59.83.225] (helo=pluto)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LOAj4-0000rK-00; Sat, 17 Jan 2009 13:56:34 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <87k58u4vlq.fsf@jidanni.org>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+jBebEK5Qn/8O3mXm7fLIzaVvmXfHMndXSYdYK
	8NAvKMwCS5jnTCQghEpRgitmvOomHmr8YVW/FE/2hcn0ceRHXh
	s1PPPTPThKzpf8hjjsZw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106048>

jidanni@jidanni.org, 17.01.2009:
> Signed-off-by: jidanni <jidanni@jidanni.org>
> ---
>  Documentation/git-checkout.txt |   13 +++++++------
>  1 files changed, 7 insertions(+), 6 deletions(-)

> -When <paths> are not given, this command switches branches by
> -updating the index and working tree to reflect the specified
> -branch, <branch>, and updating HEAD to be <branch> or, if
> -specified, <new_branch>.  Using -b will cause <new_branch> to
> -be created; in this case you can use the --track or --no-track
> -options, which will be passed to `git branch`.
> +When <paths> are not given, this command switches branches by updating
> +the index and working tree to reflect the specified branch, <branch>,
> +and updating HEAD to be <branch> or, if specified, <new_branch>. (No
> +extraneous files present are deleted, use linkgit:git-clean[1] for a
> +pristine checkout.) Using -b will cause <new_branch> to be created; in
> +this case you can use the --track or --no-track options, which will be
> +passed to `git branch`.

Why do you reformat the whole paragraph? Just inserting your sentence
would give a much nicer diff for easier review, it's no difference for
asciidoc. Indeed to find the change, I just copied the old and new text
into two Vim windows, reformatted and diffed them.

Then you would get this

  Documentation/git-checkout.txt |   2 ++
  1 files changed, 2 insertions(+), 0 deletions(-)

Markus
