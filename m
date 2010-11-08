From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/resend] Doc: git-push: Specify the default mode in the
 description
Date: Mon, 08 Nov 2010 12:48:16 -0800
Message-ID: <7vy693o833.fsf@alter.siamese.dyndns.org>
References: <1289222435-9610-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Mon Nov 08 21:48:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFYdp-00054q-Li
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 21:48:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754904Ab0KHUsY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Nov 2010 15:48:24 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40096 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754886Ab0KHUsX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Nov 2010 15:48:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 88FCD212D;
	Mon,  8 Nov 2010 15:48:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3ue01iljjjtB
	w0csMko7PgSGVrE=; b=oG/r9deKkcfvE0bScXRY16DMplupKPpdN8wm53r6DZ6z
	LS+jQnveExyqAqqz9JLTQBKYQTpR1WQ8JgwVinO+NSBQTr+ERq4gnVFCYVjgx9rs
	OOJ9IwOVtRKPbtc2JzExE9VjWLSK81fhO6EBwRhExQM1OLqq2AfV+xoWtWBjqho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fLqRAg
	OSjSYRqn32UrllHnxh9c+KGwQVS2sXE+EjvJXKb4I8mD6uvS3JCur2UeONJDR27O
	VP3BXKY/7wi8tMWtTla6XQIEnehsA5zp+cDrxRO0N7Slki2lJi8R3BUU9/+SeKAi
	xl9RSvyEEomdPMlfpPNgAyiUnlajAvT5P29kM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4F6F52129;
	Mon,  8 Nov 2010 15:48:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5AB3F2126; Mon,  8 Nov 2010
 15:48:20 -0500 (EST)
In-Reply-To: <1289222435-9610-1-git-send-email-santi@agolina.net> ("Santi
 =?utf-8?Q?B=C3=A9jar=22's?= message of "Mon\,  8 Nov 2010 14\:20\:35 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 86FF9818-EB79-11DF-A66C-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160988>

Santi B=C3=A9jar <santi@agolina.net> writes:

> Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
> ---
> Hi *,
>
>   just resend a patch that maybe was missed inside this thread:

No, I didn't miss it.

The new text says 'push "matching" branches' before explaining what it =
is,
only vaguely refers the reader to the next section by "see below" witho=
ut
telling which part of below the reader should look at.  In other words,=
 it
wastes two lines without adding two lines worth of additional informati=
on.

Saying "look for string 'default' below" might be an improvement ;-), b=
ut
then the reader can do that without being told to do so themselves, so.=
=2E.

> Subject:    possible bug when pushing with multiple remote repos.
> From:       Arnaud Mouiche
> Date:       2010-10-22 9:12:51
> http://marc.info/?i=3D1287738771.13348.34.camel%20()%20amolinux
>
> Santi
>
>  Documentation/git-push.txt |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index e11660a..9a2a93e 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -23,6 +23,8 @@ You can make interesting things happen to a reposit=
ory
>  every time you push into it, by setting up 'hooks' there.  See
>  documentation for linkgit:git-receive-pack[1].
> =20
> +The default operation mode if no explicit refspec is found is
> +to push "matching" branches, see below.
> =20
>  OPTIONS[[OPTIONS]]
>  ------------------
> --=20
> 1.7.3.2.337.gc40334
