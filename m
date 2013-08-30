From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Fix the author initials in blame for non-ASCII names
Date: Fri, 30 Aug 2013 11:05:04 -0700
Message-ID: <xmqqppsvyrzj.fsf@gitster.dls.corp.google.com>
References: <20130829163935.GA9689@ruderich.org>
	<1377851821-5412-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Simon Ruderich <simon@ruderich.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 30 20:05:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFT4n-0002yq-E9
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 20:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756845Ab3H3SFa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Aug 2013 14:05:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37642 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756699Ab3H3SFI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Aug 2013 14:05:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EABF3C8B8;
	Fri, 30 Aug 2013 18:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0M6BBqkeWmWJ
	XNWMWZFs7Imbmws=; b=uCU/XimpYWmAUMJQNmwkos4RxAUS5sypxwpn+vFzRoMW
	uF8bslC3LWWox3r9dgsddPsI1U0GcjNJtRyHuQVDhQ5+BMULpj4HkA2xIHGc9w27
	Z/OhwLmrCHKMJ0ImSIOPtjNayNtLc2QLZ+QZdMLfYWgz8DrnNWEtywodcUJwi64=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wYy+Pp
	SHurv2HMP9aO4nbD7JK4usKBTnqEBfUviBfid/4s0mkGvq+DcpJ+qacIhf6EBZyb
	q7k9MljyfplfbUsqk+vgRO1nPkZnucy0N8sHmS8+wL/7jx0z60DtQFoIGkZtx35v
	dAytfJdUOzDNHwmCWvPb1aiMPgCTH1WJpzN4M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 813BA3C8B7;
	Fri, 30 Aug 2013 18:05:07 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C692F3C8B3;
	Fri, 30 Aug 2013 18:05:06 +0000 (UTC)
In-Reply-To: <1377851821-5412-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 30 Aug
 2013 08:37:01 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B3AD3B92-119E-11E3-A1F1-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233447>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Acked-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
> Tested-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Tested-by: Simon Ruderich <simon@ruderich.org>
> ---
>  gitweb/gitweb.perl | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index f429f75..ad48a5a 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -6631,6 +6631,7 @@ sub git_blame_common {
>  			$hash_base, '--', $file_name
>  			or die_error(500, "Open git-blame --porcelain failed");
>  	}
> +	binmode $fh, ':utf8';
> =20
>  	# incremental blame data returns early
>  	if ($format eq 'data') {


[Fri Aug 30 17:48:17 2013] gitweb.perl: Global symbol "$fh" requires
explicit package name at /home/gitster/w/buildfarm/next/t/../gitweb/git=
web.perl line 6634.
[Fri Aug 30 17:48:17 2013] gitweb.perl: Execution of /home/gitster/w/bu=
ildfarm/next/t/../gitweb/gitweb.perl aborted due to compilation errors.
