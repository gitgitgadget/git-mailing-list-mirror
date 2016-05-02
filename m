From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix typo 'In such these cases'
Date: Mon, 02 May 2016 11:46:29 -0700
Message-ID: <xmqqa8k8ti0q.fsf@gitster.mtv.corp.google.com>
References: <572703EC.20405@renenyffenegger.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Nyffenegger <mail@renenyffenegger.ch>
X-From: git-owner@vger.kernel.org Mon May 02 20:46:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axIre-0005Es-6p
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 20:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754975AbcEBSqe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2016 14:46:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54686 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754812AbcEBSqd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2016 14:46:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DCCB116E87;
	Mon,  2 May 2016 14:46:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vqQPxywRZH3t
	aZYUpuOjncGglLA=; b=UTaAgJnp7E5WOz915PSSHjPwZJLXVyfxQSy16SuoEC0j
	mp+OuPYfwGIg4Z74o42vN7tQephbXeD26hIMYJAbUTxye2fUfRAUMbVLA0DGjHU3
	xvWsTYvgp09CnisFBKYogXMIHI5o7WAqzyjN2YHFUTRHSUuyuRxbWSlpJDz0Yng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=UaJ/+Q
	SOy3lNzgHdPWzOtJpit8bpkuVuwbk+kwYshs0HK5xdFmJHbipxBuv3RagLPCN4Sm
	qJAt4msYTVZq7wc79ECyGtrXEtRVGFRhHhUEl+AxJU5y+mUhqycVWKIofrEwYmVt
	bbFsu4UMdyobfknQZUHqu+wZfqxhGljy6HgTs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D34AC16E86;
	Mon,  2 May 2016 14:46:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5377316E85;
	Mon,  2 May 2016 14:46:31 -0400 (EDT)
In-Reply-To: <572703EC.20405@renenyffenegger.ch> (=?utf-8?Q?=22Ren=C3=A9?=
 Nyffenegger"'s message
	of "Mon, 2 May 2016 09:38:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2FBE759A-1096-11E6-B480-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293266>

Ren=C3=A9 Nyffenegger <mail@renenyffenegger.ch> writes:

> From 5e2b47833c8d434784fa1a797cfd6a087df10dc8 Mon Sep 17 00:00:00 200=
1
> From: =3D?UTF-8?q?Ren=3DC3=3DA9=3D20Nyffenegger?=3D <rene.nyffenegger=
@adp-gmbh.ch>
> Date: Mon, 2 May 2016 09:19:46 +0200
> Subject: [PATCH] Documentation: Fix typo 'In such these cases'

=46or the next time, remember that these four lines are usually not
meant to go to the body of the e-mail.

> Fix "In such these cases, ..." to "In such cases, ..."
> in Documentation/glossary-content.txt

Wow.  It is an ancient typo in 9290cd58 (Added definitions for a few
words:, 2006-05-03) that survives to the day.

Thanks.  Will queue.

> Signed-off-by: Ren=C3=A9 Nyffenegger <mail@renenyffenegger.ch>
> ---
>  Documentation/glossary-content.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/glossary-content.txt b/Documentation/gloss=
ary-content.txt
> index cafc284..9ceca05 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -145,7 +145,7 @@ current branch integrates with) obviously do not =
work, as there is no
>  	A fast-forward is a special type of <<def_merge,merge>> where you h=
ave a
>  	<<def_revision,revision>> and you are "merging" another
>  	<<def_branch,branch>>'s changes that happen to be a descendant of w=
hat
> -	you have. In such these cases, you do not make a new <<def_merge,me=
rge>>
> +	you have. In these cases, you do not make a new <<def_merge,merge>>
>  	<<def_commit,commit>> but instead just update to his
>  	revision. This will happen frequently on a
>  	<<def_remote_tracking_branch,remote-tracking branch>> of a remote
