From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: Add missing git svn commands
Date: Mon, 19 May 2008 22:21:36 -0700
Message-ID: <7vej7x8s9r.fsf@gitster.siamese.dyndns.org>
References: <48320380.6090200@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, normalperson@yhbt.net
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Tue May 20 07:22:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyKJ8-0002Va-2o
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 07:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753758AbYETFVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 01:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753701AbYETFVu
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 01:21:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60333 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753173AbYETFVt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 01:21:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3718A3E88;
	Tue, 20 May 2008 01:21:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 048813E87; Tue, 20 May 2008 01:21:40 -0400 (EDT)
In-Reply-To: <48320380.6090200@isy.liu.se> (Gustaf Hendeby's message of "Tue,
 20 May 2008 00:47:28 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A525F4AA-262C-11DD-BB61-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82464>

Gustaf Hendeby <hendeby@isy.liu.se> writes:

> Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>
> ---
>
> I sent this one out about a week ago and haven't heard anything about 
> it.  Did it just get lost in the noise, or is it just not 
> interesting/incorrect in some way?

It's severely whitespace damaged isn't it?

> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index f4ba105..c02f220 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -189,10 +189,10 @@ All arguments are passed directly to `git blame'.
>   	independently of git-svn functions.
>
>   'create-ignore'::
> -
>   	Recursively finds the svn:ignore property on directories and
>   	creates matching .gitignore files. The resulting files are staged to
> -	be committed, but are not committed.
> +	be committed, but are not committed. Use -r/--revision to refer to a
> +	specfic revision.
>
>   'show-ignore'::
>   	Recursively finds and lists the svn:ignore property on
> @@ -216,6 +216,19 @@ All arguments are passed directly to `git blame'.
>   	argument.  Use the --url option to output only the value of the
>   	'URL:' field.
>
> +'proplist'::
> +	Lists the properties stored in the Subversion repository about a
> +	given file or directory.  Use -r/--revision to refer to a specific
> +	Subversion revision.
> +
> +'propget'::
> +	Gets the Subversion property given as the first argument, for a
> +	file.  A specific revision can be specified with -r/--revision.
> +
> +'show-externals'::
> +	Shows the Subversion externals.  Use -r/--revision to specify a
> +	specific revision.
> +
>   --
>
>   OPTIONS
> -- 
> 1.5.5.1.328.g4377c
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
