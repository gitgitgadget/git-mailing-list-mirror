From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] Improve remote-helpers documentation
Date: Mon, 22 Mar 2010 12:25:19 -0700
Message-ID: <7v39zscg68.fsf@alter.siamese.dyndns.org>
References: <f3271551003220954s38ed80f2vde1a287d05ef4ad5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 20:25:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtnFx-0006cu-2l
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 20:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755364Ab0CVTZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 15:25:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39338 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754779Ab0CVTZg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 15:25:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D9A1A406A;
	Mon, 22 Mar 2010 15:25:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xowk/lWWkJyLCfSrAfNvcHtjbmw=; b=HogkOc
	gI3heDpexfwcqE7NHWMUH+6LLbEXbDFmjuM59Nh0QI6Zgvzf/rakks0zvbJssVug
	7nhdJRaU8qhfT2DgC7Q9A34jce1jRC/Hg+hCynkIYJbrUKZR6AGra3oVjnpbzDtb
	0RM1H0hqWxwZSftyH5Zgti8rHwbt3/xQCk1CM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oDO6FFXaa5rpLeHArubjfdn6RX+xMFKk
	YJwtBeUnCpHlTGLP7z0dU6YX1dkrF7zvgvGcgzu7U6FyMZQ6VJnl3rmbwBQJhkwJ
	wqsl6ZoyMPBTO1scdAvmeSbrneK5/KdXOBNGeCi7BsUBTB3PDO5HpzE6x4yDw++5
	W2hu0pwMKmo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9860DA405B;
	Mon, 22 Mar 2010 15:25:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D579A4051; Mon, 22 Mar
 2010 15:25:21 -0400 (EDT)
In-Reply-To: <f3271551003220954s38ed80f2vde1a287d05ef4ad5@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Mon\, 22 Mar 2010 22\:24\:07 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AC6C220C-35E8-11DF-8817-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142959>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> Acked-by: Daniel Barkalow <barkalow@iabervon.org>
> ---
> Cosmetic change since v4: The capabilities fetch, option, push,
> connect, and import are presented in a more elegant manner.

I know Daniel already Acked this, but pretending to be a total novice to
remote-helper, I am not entirely happy with the new text.

> diff --git a/Documentation/git-remote-helpers.txt
> b/Documentation/git-remote-helpers.txt
> index 1b5f61a..990d302 100644
> --- a/Documentation/git-remote-helpers.txt
> +++ b/Documentation/git-remote-helpers.txt
> @@ -3,7 +3,7 @@ git-remote-helpers(1)
>
>  NAME
>  ----
> -git-remote-helpers - Helper programs for interoperation with remote git
> +git-remote-helpers - Helper programs for interacting with remote repositories

s/for interacting/to interact/; would be shorter.

>  SYNOPSIS
>  --------
> @@ -13,10 +13,23 @@ DESCRIPTION
>  -----------
>
>  These programs are normally not used directly by end users, but are
> -invoked by various git programs that interact with remote repositories
> -when the repository they would operate on will be accessed using
> -transport code not linked into the main git binary. Various particular
> -helper programs will behave as documented here.
> +invoked by various git programs that interact with remote
> +repositories.  For a program to qualify as a remote helper, it must
> +implement a subset of the capabilities documented here, and conform to
> +the remote helper protocol.

It would be sufficient and easier to read if we did this:

  s/For a program to qualify as a remote helper, it/A remote helper/

> +Remote helpers are spawned as binaries by
> +the main git programs and interact using text streams, without
> +linking.

Here, "without linking" sticks out like a sore thumb.  Without linking to
what?  libgit.a?

I think the most important thing you are trying to say is that one does
not have to modify or relink git itself to add a new helper, because the
helper runs as a separate process.  The binaryness (as opposed to "text"
or "script") is not important here at all.  So how about saying it in a
more direct way?  Perhaps...

	When git needs to interact with a remote repository served by a
	remote helper, git spawns the helper as an independent process and
	interacts with it over "helper protocol" (this way, adding a new
	helper does not require re-linking the main git program with it).

I also think textness of the helper protocol is secondary; the more
important thing you need to say is how this independent process interacts
with the launching git process.  Phrases like "over pipe", "reads commands
from its standard input", "writes the status and/or result to its standard
output", are likely to be the ones you would want in your description.

> +The curl helper is one such program. It is invoked via
> +'git-remote-http', 'git-remote-https', 'git-remote-ftp', or
> +'git-remote-ftps', and implments the capabilities 'fetch', 'option',
> +and 'push'.

This description made me go "huh?".  A natural first question is: if _the_
helper is _one_ such program, why does it have so many names, iow why
isn't it 'git-remote-curl' with different underlying transport given as an
option?

I am not suggesting to change the design and implementation here, but
trying to see a way to reduce confusion from the documentation.  The
current design gives many names for the same implementation but that is
just an implementation detail---the design principle Ilari took is the
other way around.  There are bunch of helpers (http helper, https helper,
ftp helper,...) and they _happen_ to share the same implementation that
uses curl.  So it would be clearer to say:

	git comes with a "curl" family of remote helpers (http, https,
	ftp, and ftps helper).  They implement the capabilities 'foo',
	'bar', and 'baz'.

> +The curl helper essentially helps in transporting native
> +git objects.

I am not happy with this description.  Doesn't any remote helper transport
git objects in the end?  I think you are trying to describe one aspect of
the difference between "curl" family and "fast-import" family, namely, the
"curl" family of helpers do not transport the git object with the "import"
command of the "text stream" protocol.  They do that on their own instead
of using a fast-import stream, but that is an implementation detail that
is not important in this early part of the DESCRIPTION section.

I would suggest dropping this sentence; at least drop "essentially" and
"native".  The former only invites "do they do something more than that,
and if so what are they?" question without giving any extra information to
the readers.  The latter is misleading (fast-import stream could be used
to transfer native objects by a helper that uses git-fast-export using
"import" command of the "text stream" protocol, no?).

In this 'DESCRIPTION' section, one thing that is missing is the overall
"why? what for?" of a helper.  The only word we have seen is "interact
with", and the reader wouldn't know that by "interacting with a remote
repository", you mean that the things you want to achieve with these
helpers are:

 - learning what refs the other side has;

 - transferring objects from remote to local that are reachable from (some
   of) these refs and that are missing from local repository (i.e. fetch);

 - transferring objects from local to remote that are missing from the
   remote repository that are necessary to update refs at the remote
   repository to point at a different value (i.e. first part of push); and

 - updating the refs at the remote repository (i.e. latter part of push);

To a reader who has not learned the above, "essentially helps in
transporting native..." sounds nothing more than a gibberish.

> +As opposed to native git objects, remote helpers can also provide a
> +fast-import stream through the 'import' capability. This makes them
> +especially useful when native interoperability with a foreign
> +versioning system is desired.

Likewise.  Use of fast-import stream is an implementation detail of how
objects are transferred (or in the case of foreign interface, synthesized
on the fly).

I would suggest that you first talk about a bit higher level "purpose"
(the four-bullet points above might be a good start) to clear the
"remote-helper: why and what for?" question, before starting to describe
"git comes with a "curl" family".
