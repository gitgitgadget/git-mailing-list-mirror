From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 06/11] fixup! log: document use of multiple commit
 limiting options
Date: Fri, 14 Sep 2012 10:23:28 -0700
Message-ID: <7vipbg5xin.fsf@alter.siamese.dyndns.org>
References: <7vfw6l9x7i.fsf@alter.siamese.dyndns.org>
 <a22139a2cd54d1fa1b5bebc447540f7c54bf305a.1347615361.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 14 19:23:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCZcC-0003Ol-MV
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 19:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758037Ab2INRXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 13:23:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33230 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752642Ab2INRXb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 13:23:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 24C9D8DED;
	Fri, 14 Sep 2012 13:23:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hs1+eeCyH/51J422CzE8JAeG1ME=; b=hcKKeJ
	+ShSvMYdw5Nl3dDVfNR7p6LKGlzSo/A7JH4JnkRBqBDwgSmyUP2dF///tQWNuTUF
	P9HLT4B6R0Otlq6Y0lu+AQFVmjUyvD9QBlH1a+3RIXT6um8RgMeQbyc04VGz4b6m
	6dz5oBj5p5pZcPML3ohvr2NZW4dvIIDov6Pv8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TC9MlcBi5NiwkyCbiUNJjmX4obYhMbWb
	vOzbwg60dAhaThoOB6GsAO7Fig24boLBSTvB6OyMyOwCHztgRQ4Vv/klZIN0ikZA
	fpv/FwFihlKoN06/oOByt2RIGHa3+MpQW01CENb2V5btXu/+22343Vl0a4wsRinx
	xeoc7VheaIU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 113D18DEC;
	Fri, 14 Sep 2012 13:23:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E7C58DEA; Fri, 14 Sep 2012
 13:23:30 -0400 (EDT)
In-Reply-To: <a22139a2cd54d1fa1b5bebc447540f7c54bf305a.1347615361.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Fri, 14 Sep 2012 11:46:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E711F166-FE90-11E1-B130-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205510>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Here are a few typo fixes.
>
> There is a mix of single and back ticks already before this patch,
> i.e. ` vs. ' -- I thought we had guidelines for this but don't find them
> at the moment.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  Documentation/rev-list-options.txt | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Thanks, will squash in.

In general:

 - we want to use `exactly this` when writing an item that the user
   has to exactly spell as in the text, e.g. subcommand names.

 - from the older days, we use <angle bracket as placeholder> in
   synopsis section and in "git subcmd -h" output, and in the body
   text, we tend to write like '<this>' to italicise in the
   documentation.

I personally find the <angle> somewhat ugly in the documentation,
but we cannot just drop them as the "man -Tascii" would suffer if we
did so.

>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 57d6c90..c828408 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -6,12 +6,12 @@ special notations explained in the description, additional commit
>  limiting may be applied.
>  
>  Using more options generally further limits the output (e.g.
> -"--since=<date1>" limits to commits newer than <date1>, and using it
> -with "--grep=<pattern>" further limits to commits whose log message
> -has a line that match <pattern>), unless otherwise noted.
> +`--since=<date1>` limits to commits newer than `<date1>`, and using it
> +with `--grep=<pattern>` further limits to commits whose log message
> +has a line that matches `<pattern>`), unless otherwise noted.
>  
>  Note that these are applied before commit
> -ordering and formatting options, such as '--reverse'.
> +ordering and formatting options, such as `--reverse`.
>  
>  --
>  
> @@ -47,7 +47,7 @@ endif::git-rev-list[]
>  	Limit the commits output to ones with author/committer
>  	header lines that match the specified pattern (regular
>  	expression).  With more than one `--author=<pattern>`,
> -	commits whose author match any of the given patterns are
> +	commits whose author matches any of the given patterns are
>  	chosen (similarly for multiple `--committer=<pattern>`).
>  
>  --grep=<pattern>::
> @@ -55,7 +55,7 @@ endif::git-rev-list[]
>  	Limit the commits output to ones with log message that
>  	matches the specified pattern (regular expression).  With
>  	more than one `--grep=<pattern>`, commits whose message
> -	match any of the given patterns are chosen (but see
> +	matches any of the given patterns are chosen (but see
>  	`--all-match`).
>  
>  --all-match::
