From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rename {git- => git}remote-helpers.txt
Date: Thu, 31 Jan 2013 14:13:10 -0800
Message-ID: <7vy5f9dmrt.fsf@alter.siamese.dyndns.org>
References: <7v1ud1gke7.fsf@alter.siamese.dyndns.org>
 <3f26b82599aa2a45897d345c851fab4751c55810.1359669205.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Max Horn <max@quendi.de>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Jan 31 23:13:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U12O3-0007TM-FR
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 23:13:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755962Ab3AaWNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 17:13:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56862 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755768Ab3AaWNN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 17:13:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72F44CB53;
	Thu, 31 Jan 2013 17:13:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xs2m7jH8lU7qUTmA0zbPCQPpUNQ=; b=RqE9tA
	m8Hn+k6I817QJTJUN0iDgQQ9Rrl7jXedIvRqZHzHrrb5IgIj61d04E5jynJt2wEj
	6kX2FZmfzaBuWcwNStQBQjwFIUNOy2TqXTOop14PNmdnnZKGOYqCM9s0Oj8hg45T
	QPXjLOmqZyAvTyQiiu++pn6SJycxqG9GLch/M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DJD4yRsk2WucA/yQen1aMblJY+1gnMab
	QVbVlBzFCRUpJ0qUd9KBPcNtAUP85ZgFE8MDX+zoMMaHmnpgzYUg7qcyuL+FNRBi
	KTkW81xz74UB02SHmpneTzPVkph8G7koZ+6pB/OA+QG3rlYqCXfizK17rXos12++
	f0hboRKBFsc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66B9BCB52;
	Thu, 31 Jan 2013 17:13:12 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B52CCCB51; Thu, 31 Jan 2013
 17:13:11 -0500 (EST)
In-Reply-To: <3f26b82599aa2a45897d345c851fab4751c55810.1359669205.git.john@keeping.me.uk>
 (John Keeping's message of "Thu, 31 Jan 2013 21:59:50 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 669FDDCE-6BF3-11E2-8625-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215175>

John Keeping <john@keeping.me.uk> writes:

> When looking up a topic via "git help <topic>", git-help prepends "git-"
> to topics that are the names of commands (either builtin or found on the
> path) and "git" (no hyphen) to any other topic name.
>
> "git-remote-helpers" is not the name of a command, so "git help
> remote-helpers" looks for "gitremote-helpers" and does not find it.
>
> Fix this by renaming "git-remote-helpers.txt" to
> "gitremote-helpers.txt".
>
> Signed-off-by: John Keeping <john@keeping.me.uk>
>
> ---
> Changes since v1:
>
> - add gitremote-helpers.txt to the Makefile since it is no longer caught
>   by git-*.txt.
>
> - add a simple git-remote-helpers.html to help people following links to
>   the old name.

Doesn't "make clean" remove the placeholder file?

>  Documentation/.gitignore                           |  1 +
>  Documentation/Makefile                             |  4 +-
>  Documentation/git-remote-helpers.html              | 55 ++++++++++++++++++++++
>  Documentation/git-remote-testgit.txt               |  2 +-
>  ...it-remote-helpers.txt => gitremote-helpers.txt} |  6 +--
>  Documentation/urls.txt                             |  2 +-
>  6 files changed, 63 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/git-remote-helpers.html
>  rename Documentation/{git-remote-helpers.txt => gitremote-helpers.txt} (99%)
>
> diff --git a/Documentation/.gitignore b/Documentation/.gitignore
> index 2c8b2d6..5f479b8 100644
> --- a/Documentation/.gitignore
> +++ b/Documentation/.gitignore
> @@ -1,5 +1,6 @@
>  *.xml
>  *.html
> +!git-remote-helpers.html
>  *.[1-8]
>  *.made
>  *.texi
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index fe6709c..4ccb828 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -1,7 +1,7 @@
>  MAN1_TXT= \
>  	$(filter-out $(addsuffix .txt, $(ARTICLES) $(SP_ARTICLES)), \
>  		$(wildcard git-*.txt)) \
> -	gitk.txt gitweb.txt git.txt
> +	gitk.txt gitweb.txt git.txt gitremote-helpers.txt
>  MAN5_TXT=gitattributes.txt gitignore.txt gitmodules.txt githooks.txt \
>  	gitrepository-layout.txt gitweb.conf.txt
>  MAN7_TXT=gitcli.txt gittutorial.txt gittutorial-2.txt \
> @@ -13,7 +13,7 @@ MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
>  MAN_XML=$(patsubst %.txt,%.xml,$(MAN_TXT))
>  MAN_HTML=$(patsubst %.txt,%.html,$(MAN_TXT))
>  
> -DOC_HTML=$(MAN_HTML)
> +DOC_HTML=$(MAN_HTML) git-remote-helpers.html
>  
>  ARTICLES = howto-index
>  ARTICLES += everyday
> diff --git a/Documentation/git-remote-helpers.html b/Documentation/git-remote-helpers.html
> new file mode 100644
> index 0000000..0c5ec27
> --- /dev/null
> +++ b/Documentation/git-remote-helpers.html
> @@ -0,0 +1,55 @@
> +<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
> +    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
> +<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
> +<head>
> +<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
> +<title>git-remote-helpers(1) - Document Moved</title>
> +<style type="text/css">
> +/* Cut-down styles from asciidoc.css. */
> +
> +/* Default font. */
> +body {
> +  font-family: Georgia,serif;
> +}
> +
> +/* Title font. */
> +h1 {
> +  font-family: Arial,Helvetica,sans-serif;
> +}
> +
> +body {
> +  margin: 1em 5% 1em 5%;
> +}
> +
> +a {
> +  color: blue;
> +  text-decoration: underline;
> +}
> +a:visited {
> +  color: fuchsia;
> +}
> +
> +h1, h2, h3, h4, h5, h6 {
> +  color: #527bbd;
> +  margin-top: 1.2em;
> +  margin-bottom: 0.5em;
> +  line-height: 1.3;
> +}
> +
> +</style>
> +</head>
> +<body class="manpage">
> +<div id="header">
> +<h1>
> +Document Moved
> +</h1>
> +</div>
> +
> +<p>This document is now called <a
> +href="gitremote-helpers.html">gitremote-helpers</a>.</p>
> +
> +<p>Please let the owners of the referring site know so that they can update the
> +link you clicked to get here.</p>
> +
> +</body>
> +</html>
> diff --git a/Documentation/git-remote-testgit.txt b/Documentation/git-remote-testgit.txt
> index 612a625..f791d73 100644
> --- a/Documentation/git-remote-testgit.txt
> +++ b/Documentation/git-remote-testgit.txt
> @@ -23,7 +23,7 @@ The best way to learn more is to read the comments and source code in
>  
>  SEE ALSO
>  --------
> -linkgit:git-remote-helpers[1]
> +linkgit:gitremote-helpers[1]
>  
>  GIT
>  ---
> diff --git a/Documentation/git-remote-helpers.txt b/Documentation/gitremote-helpers.txt
> similarity index 99%
> rename from Documentation/git-remote-helpers.txt
> rename to Documentation/gitremote-helpers.txt
> index e36fdcb..0c91aba 100644
> --- a/Documentation/git-remote-helpers.txt
> +++ b/Documentation/gitremote-helpers.txt
> @@ -1,9 +1,9 @@
> -git-remote-helpers(1)
> -=====================
> +gitremote-helpers(1)
> +====================
>  
>  NAME
>  ----
> -git-remote-helpers - Helper programs to interact with remote repositories
> +gitremote-helpers - Helper programs to interact with remote repositories
>  
>  SYNOPSIS
>  --------
> diff --git a/Documentation/urls.txt b/Documentation/urls.txt
> index 539c0a0..3ca122f 100644
> --- a/Documentation/urls.txt
> +++ b/Documentation/urls.txt
> @@ -55,7 +55,7 @@ may be used:
>  
>  where <address> may be a path, a server and path, or an arbitrary
>  URL-like string recognized by the specific remote helper being
> -invoked. See linkgit:git-remote-helpers[1] for details.
> +invoked. See linkgit:gitremote-helpers[1] for details.
>  
>  If there are a large number of similarly-named remote repositories and
>  you want to use a different format for them (such that the URLs you
