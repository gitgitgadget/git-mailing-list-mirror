From: Junio C Hamano <gitster@pobox.com>
Subject: Re: l10n: the maintaince of git-po repo
Date: Tue, 28 Feb 2012 21:34:03 -0800
Message-ID: <7v1upew6d0.fsf@alter.siamese.dyndns.org>
References: <CANYiYbGS_cFTHT1Pkafi9dmzedqezTq8k1tPkYur0b2St_c43Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
	<avarab@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 29 06:34:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2cB4-0002lh-RI
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 06:34:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640Ab2B2FeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 00:34:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57526 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750773Ab2B2FeG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 00:34:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFFD77C3C;
	Wed, 29 Feb 2012 00:34:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LClEAeNiwHuMkA5FhnUBZFShXNo=; b=oiVLfw
	Srk0oKDmJrpYsPmRu0IiUCpH8YxKVsoqcBPDzI/LVVimNph0AhPyaawDGgBYw+tN
	lYlxFFooBVaVIoq3z789xA85POjiRiG2KTH/Ly36rXlklUoYem6PGlJE9MSSn9KG
	OpKpOCf3gh6erFP5EhMxCbSRrD8hX4iNXzvKg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SFj6y8eGkZZNMbWnXLQ4ug9/VyAarAi+
	SylByIs4EYr9a3ukFeJRq7VYgrkUyE3v/e8X21cBLIVxAp1dYPj/YpuQGpd5Jbhb
	eUmOUBQQoKhiKD8PyAxHlKqjUC6pP303c0OMlpR+ybkW7cPJyj29wui6d0+hKp0O
	LvoCsxbkUd8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6C377C3B;
	Wed, 29 Feb 2012 00:34:05 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0630E7C3A; Wed, 29 Feb 2012
 00:34:04 -0500 (EST)
In-Reply-To: <CANYiYbGS_cFTHT1Pkafi9dmzedqezTq8k1tPkYur0b2St_c43Q@mail.gmail.com> (Jiang
 Xin's message of "Wed, 29 Feb 2012 01:40:09 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FE6433B0-6296-11E1-A619-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191811>

Jiang Xin <worldhello.net@gmail.com> writes:

> I'm looking forward to the next git release with Chinese l10n, so that
> I can start to rewrite my book on Git. ;-)

For people who don't know, Jiang kindly sent me an autographed copy of his
book https://plus.google.com/u/0/108182106411180467879/posts/XX2CewgxSAb I
can only read the command examples, but the book seems to have a good
coverage of modern Git, judging from the table of contents.

> The maintaince of the git-po and git-po-zh_CN repositories so far:
>
> git-po repository
> -----------------
> Location   : https://github.com/gotgit/git-po
> Fork from  : https://github.com/git/git
> Description: This is the Git l10n master repo, and is used to coordinate
>              works of l10n teams. L10n team leaders send pull requests
>              to this repo, while other l10n contributors should wok on
>              the language specified repository created by the l10n team
>              leader.

Thanks.  I took a look.

I'll comment on the changes as if they came in the patch form here, to ask
for sanity checks from the list members.

>  Makefile      |    1 -
>  po/.gitignore |    1 -
>  po/git.pot    | 3494 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  po/zh_CN.po   | 3671 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 7165 insertions(+), 2 deletions(-)
>  create mode 100644 po/git.pot
>  create mode 100644 po/zh_CN.po
> 
> 
> diff --git a/Makefile b/Makefile
> index cf2c40b..be1957a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2635,7 +2635,6 @@ dist-doc:
>  
>  distclean: clean
>  	$(RM) configure
> -	$(RM) po/git.pot
>  
>  profile-clean:
>  	$(RM) $(addsuffix *.gcda,$(addprefix $(PROFILE_DIR)/, $(object_dirs)))

The file is no longer a generated file but is tracked, and should not be
removed upon distclean.  Good.

> diff --git a/po/.gitignore b/po/.gitignore
> index 4caa631..796b96d 100644
> --- a/po/.gitignore
> +++ b/po/.gitignore
> @@ -1,2 +1 @@
> -/git.pot
>  /build

Likewise, it is not ignored anymore. Good.

> diff --git a/po/git.pot b/po/git.pot
> new file mode 100644
> index 0000000..efcda39
> --- /dev/null
> +++ b/po/git.pot
> @@ -0,0 +1,3494 @@
> +# SOME DESCRIPTIVE TITLE.
> +# Copyright (C) YEAR THE PACKAGE'S COPYRIGHT HOLDER
> +# This file is distributed under the same license as the PACKAGE package.

Should the above placeholder lines left as they are, or should they be
updated to name "Git" as the "PACKAGE" with "SOME DESCRIPTIVE TITLE"?

If the answer is "latter", I think we would need to apply a similar update
to po/git-gui.pot for git-gui package.

On the other hand, I think the placeholder lines below should stay as they
are.

> +# FIRST AUTHOR <EMAIL@ADDRESS>, YEAR.
> +#
> +#, fuzzy
> +msgid ""
> +msgstr ""
> +"Project-Id-Version: PACKAGE VERSION\n"
> +"Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
> +"POT-Creation-Date: 2012-02-28 09:17+0800\n"
> +"PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
> +"Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
> +"Language-Team: LANGUAGE <LL@li.org>\n"
> +"Language: \n"
> +"MIME-Version: 1.0\n"
> +"Content-Type: text/plain; charset=CHARSET\n"
> +"Content-Transfer-Encoding: 8bit\n"
> +"Plural-Forms: nplurals=INTEGER; plural=EXPRESSION;\n"
> +
> +#: advice.c:34
> +#, c-format
> +msgid "hint: %.*s\n"
> +msgstr ""
> ...
