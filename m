From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] show-branch: fix indentation of usage string
Date: Tue, 20 Jan 2015 16:13:54 -0800
Message-ID: <xmqqoaptyoql.fsf@gitster.dls.corp.google.com>
References: <CANYiYbGL4A+ut8NjKmq6U8ADVf2M9Lq-5DOG3qxbKBp5srtrJQ@mail.gmail.com>
	<1421782228-24005-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, kuleshovmail@gmail.com, jn.avila@free.fr,
	worldhello.net@gmail.com
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 01:14:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDivs-0002dI-BA
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 01:14:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348AbbAUAN6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2015 19:13:58 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54093 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751585AbbAUAN4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jan 2015 19:13:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C7F9632E24;
	Tue, 20 Jan 2015 19:13:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ksZi1vc1PJRX
	cyBoCP5kfr3iNtA=; b=qlUBxJw7jnyyU1CEhC0We+m64YCTRhz4ykSA4OM7bjdP
	ypSdXiRK+hFXp/0yxWqyhZwccC1GlkHVfMetfPwpsYgdCq08OvDgBUQ0dRt5P1O2
	kTCeCqlwWphodzEr5nVuN5/H68xRH8Twu0a6fKkf0enTAGFX3rYTwX1fLrNqJsA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Ev+FgY
	2xiZhZGl+aFn4I1ePxq4MthAH/CMLS0lhJoBJhb59OvJHQHqm4uP5Tp1VTY/vzsu
	Qh+RfAZmn4Awb8UvQ9V/OtZR1U3HaGQeUisrwep2nRohEtj2bT7uDEa1doEUoQ2D
	i3XDF4rG+pzH584nHj3nrogouHUucFP7f9/O0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BEEE032E22;
	Tue, 20 Jan 2015 19:13:55 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 43DD632E20;
	Tue, 20 Jan 2015 19:13:55 -0500 (EST)
In-Reply-To: <1421782228-24005-1-git-send-email-ralf.thielow@gmail.com> (Ralf
	Thielow's message of "Tue, 20 Jan 2015 20:30:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 63287926-A102-11E4-9962-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262705>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> Noticed-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
> Jiang Xin <worldhello.net@gmail.com> wrote:
>> 2015-01-18 23:53 GMT+08:00 Jean-No=C3=ABl AVILA <jn.avila@free.fr>:
>> Yes, it's wrong to using mixed tabs and spaces in the message. It co=
mes
>> from commit v2.0.5-5-g9990273, and it should be fixed.
>
> This also breaks the indentation of the command output.
>
>  builtin/show-branch.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/show-branch.c b/builtin/show-branch.c
> index 691eeda..365228a 100644
> --- a/builtin/show-branch.c
> +++ b/builtin/show-branch.c
> @@ -7,9 +7,9 @@
> =20
>  static const char* show_branch_usage[] =3D {
>      N_("git show-branch [-a|--all] [-r|--remotes] [--topo-order | --=
date-order]\n"
> -       "		       [--current] [--color[=3D<when>] | --no-color] [--sp=
arse]\n"
> -       "		       [--more=3D<n> | --list | --independent | --merge-ba=
se]\n"
> -       "	       [--no-name | --sha1-name] [--topics] [(<rev> | <glob=
>)...]"),
> +       "		[--current] [--color[=3D<when>] | --no-color] [--sparse]\n=
"
> +       "		[--more=3D<n> | --list | --independent | --merge-base]\n"
> +       "		[--no-name | --sha1-name] [--topics] [(<rev> | <glob>)...]=
"),
>      N_("git show-branch (-g|--reflog)[=3D<n>[,<base>]] [--list] [<re=
f>]"),
>      NULL
>  };

Thanks.
