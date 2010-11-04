From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: fix misnested -l and --contains in
 git-tag synopsis
Date: Thu, 04 Nov 2010 12:37:40 -0700
Message-ID: <7vmxpovq0r.fsf@alter.siamese.dyndns.org>
References: <1288783029-11226-1-git-send-email-philip@foolip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Philip =?utf-8?Q?J=C3=A4genstedt?= <philip@foolip.org>
X-From: git-owner@vger.kernel.org Thu Nov 04 20:37:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE5dD-0000o7-Qc
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 20:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776Ab0KDThu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Nov 2010 15:37:50 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62731 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560Ab0KDTht convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Nov 2010 15:37:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5A396391F;
	Thu,  4 Nov 2010 15:37:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/zmVzmBOOmLA
	HTimngEc8Ir5Scc=; b=R2wo9Td34PQGAORVSqDvYLf2kcJvo6z4g1gm5Zs+F1B+
	TEKwH5VCANKSIYWiF08Wenfs6wDuMZko8jAeT9QtcFdLgpUiyABdC42QT0WTmGyS
	2wC31zVAeDkyFsBhYAeIwZog+jC9xMmh48ZGSrtq5aC9cLr7VZpICe7kbUZOTcM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=oS4nyF
	xzRtJYN325cWYOBq7IgQXbU42z2b+Sbe1N+QGXN/Ypzpssdh0XaV0OFMUEdaky8i
	AWULDrommgjbdk4Rgeq/Hwwr9ZsxQgvPNDDheUlPlrtJWxgI0weyq0UGtX34XFrs
	fkhi3trkPN8779f1D28iJ9Q+/UxcU4SiSMTkc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3A7A0391D;
	Thu,  4 Nov 2010 15:37:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 34AED391A; Thu,  4 Nov 2010
 15:37:42 -0400 (EDT)
In-Reply-To: <1288783029-11226-1-git-send-email-philip@foolip.org> ("Philip
 =?utf-8?Q?J=C3=A4genstedt=22's?= message of "Wed\,  3 Nov 2010 12\:17\:09
 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FFD86A76-E84A-11DF-BA7E-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160752>

Philip J=C3=A4genstedt <philip@foolip.org> writes:

> This has been broken since the --contains option was added in
> commit 32c35cfb1e9c8523b9d60e5095f1c49ebaef0279
>
> Signed-off-by: Philip J=C3=A4genstedt <philip@foolip.org>
> ---
>  Documentation/git-tag.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index 31c78a8..8ad89d7 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -12,7 +12,7 @@ SYNOPSIS
>  'git tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]
>  	<tagname> [<commit> | <object>]
>  'git tag' -d <tagname>...
> -'git tag' [-n[<num>]] -l [--contains <commit>] [<pattern>]
> +'git tag' [-n[<num>]] -l [<pattern>] [--contains <commit>]
>  'git tag' -v <tagname>...

I do not think there is any "mis" nor "nesting" here.  The -l option ca=
n
be used to tell the command to operate in "list tags" mode, and in that
mode it can use a pattern to limit the output (with or without --contai=
ns
<commit>).  All of these are supported:

    git tag -l --contains v1.7.0 v\*
    git tag -l v\*
    git tag --contains v1.7.0 -l v\*
    git tag -l v\* --contains v1.7.0

IOW, <pattern> is _not_ an optional argument to the -l option.  In fact=
, I
think we should support more than one patterns, even though currently t=
his
seems to silently ignore k\*:

    git tag --contains v1.7.0 -l v\* k\*

As I tend to consider that "limit by pattern" is like pathspecs (in thi=
s
case, it is _not_ a pathspec, though), having the pattern at the end lo=
oks
the most natural, but it may be just me.  And that is why I think we ou=
ght
to accept and apply more than one patterns here.

I would further say that "git tag -l <pattern> --contains <commit>" sho=
uld
be an error, even though the command currently seems to take it; perhap=
s
parameter reordering is in effect?  I didn't look closely enough.
