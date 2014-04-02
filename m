From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-parse: fix typo in example on manpage
Date: Wed, 02 Apr 2014 10:32:37 -0700
Message-ID: <xmqqk3b7vdqi.fsf@gitster.dls.corp.google.com>
References: <1396380443-61239-1-git-send-email-l.s.r@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 03 12:49:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeT8-0000xS-W1
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 12:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbaDBRcm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Apr 2014 13:32:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44754 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932387AbaDBRcl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Apr 2014 13:32:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71E9A787B9;
	Wed,  2 Apr 2014 13:32:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xvVvEzRNr+8L
	TmBin8sWfQ9v30A=; b=ppQiJIF1sWNj0Q8/qsBgLHcQRyYN5jE/X07ioz7i2ool
	j7Efjh+Z8ZVmG9+Ft536ft7zveYQ5gJANRTXjkXm9hr3QcRRUfitveSUW7alyWc/
	V0omrsQhjB4u5SXb1/n1VVTShYl63a7BP3mBFpg4RaAovzP08bwJaq9PFADIu9w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Nfax+v
	MYBbKNdfH3be8BebrRBdZpNrVODSxG7VnUb3cjGuERCqYhBos23bbKUx5dfAiZrl
	Ez8Fbubn9LJcM1lhx17tFl8ZGbfimFUL3x3zn4RIoLomiE8To20VzPixVGTIoczP
	Rc5AVpF3obe350wSW7W+vMmb4rhs3+zixGEho=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F4BE787B8;
	Wed,  2 Apr 2014 13:32:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 83ECF787B5;
	Wed,  2 Apr 2014 13:32:39 -0400 (EDT)
In-Reply-To: <1396380443-61239-1-git-send-email-l.s.r@web.de>
 (=?utf-8?Q?=22Ren=C3=A9?=
	Scharfe"'s message of "Tue, 1 Apr 2014 21:27:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C9D39FA0-BA8C-11E3-93F0-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245696>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> ---
>  Documentation/git-rev-parse.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks; I'll forge your Sign-off ;-)

>
> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-=
parse.txt
> index e05e6b3..377d9d7 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -363,7 +363,7 @@ usage: some-command [options] <args>...
>      -h, --help            show the help
>      --foo                 some nifty option --foo
>      --bar ...             some cool option --bar with an argument
> -    --bar <arg>           another cool option --baz with a named arg=
ument
> +    --baz <arg>           another cool option --baz with a named arg=
ument
>      --qux[=3D<path>]        qux may take a path argument but has mea=
ning by itself
> =20
>  An option group Header
