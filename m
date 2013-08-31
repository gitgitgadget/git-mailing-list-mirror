From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] add: trivial style cleanup
Date: Fri, 30 Aug 2013 20:37:11 -0700
Message-ID: <xmqqhae6wmxk.fsf@gitster.dls.corp.google.com>
References: <1377899810-1818-1-git-send-email-felipe.contreras@gmail.com>
	<1377899810-1818-6-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 31 05:37:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFc00-0003kr-Tw
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 05:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753917Ab3HaDhP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 23:37:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36625 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752530Ab3HaDhO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 23:37:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DA0C33784;
	Sat, 31 Aug 2013 03:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G5i6NFF/EGoIxV9oj+bFP6vvMrU=; b=tKtaDM
	5um8uAYSUAI3FHozG2iCQGH5CMYGyvw6jHVV4IjKTOp1FQYrleE8Np651wIAO9yl
	O2qEpgsl5r/toCnIaYcLpVSN4Cjwy9l0zUOHiqhqhdcokzXWykuJI1eQPqQU4Lli
	bm+dVHzCZ0IILQDHdwLaC0n3oHkwLfKUVErzo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=csR9iV14DdiVfrt1KUi9+nEMp0n7iHgz
	I/S7zrNRWorkOnch2egi1r9eNW2ATo9IZAjVy9FjtBCtLC5ORLisAwxUUbgWZrbA
	3mfwq1D8tSequmQQIqS+ZFlypQyeIJjro2M0zYXTTQhovoLAfbFkeSj/LTNwmlK7
	w6kpEyK+4zc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EC3133783;
	Sat, 31 Aug 2013 03:37:13 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E82E73377F;
	Sat, 31 Aug 2013 03:37:12 +0000 (UTC)
In-Reply-To: <1377899810-1818-6-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Fri, 30 Aug 2013 16:56:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9FA6043A-11EE-11E3-94FA-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233495>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/add.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index 8266a9c..a1e1e0e 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -336,7 +336,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
>  	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
>  
>  	if (read_cache() < 0)
> -		die (_("Could not read the index"));
> +		die(_("Could not read the index"));
>  
>  	init_revisions(&rev, prefix);
>  	rev.diffopt.context = 7;
> @@ -347,11 +347,11 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
>  	DIFF_OPT_SET(&rev.diffopt, IGNORE_DIRTY_SUBMODULES);
>  	out = open(file, O_CREAT | O_WRONLY, 0666);
>  	if (out < 0)
> -		die (_("Could not open '%s' for writing."), file);
> +		die(_("Could not open '%s' for writing."), file);
>  	rev.diffopt.file = xfdopen(out, "w");
>  	rev.diffopt.close_file = 1;
>  	if (run_diff_files(&rev, 0))
> -		die (_("Could not write patch"));
> +		die(_("Could not write patch"));
>  
>  	launch_editor(file, NULL, NULL);
>  
> @@ -364,7 +364,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
>  	child.git_cmd = 1;
>  	child.argv = apply_argv;
>  	if (run_command(&child))
> -		die (_("Could not apply '%s'"), file);
> +		die(_("Could not apply '%s'"), file);
>  
>  	unlink(file);
>  	free(file);

Good. These often bothered me.
