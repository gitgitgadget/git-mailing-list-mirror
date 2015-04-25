From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clarify documentation on commit message strip
Date: Fri, 24 Apr 2015 21:36:32 -0700
Message-ID: <xmqqmw1w259r.fsf@gitster.dls.corp.google.com>
References: <1429905998-9089-1-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 06:36:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlrpX-0005e1-9W
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 06:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbbDYEgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2015 00:36:35 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62642 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751144AbbDYEge (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2015 00:36:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EA12A4CEAB;
	Sat, 25 Apr 2015 00:36:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2MPBOFoZmsdct+/fSLSrre6sufQ=; b=FxQdzs
	fZBVeCUIl1SfMuOZkoHNOZXnQw4kAAKNFyffaWHtYTgVVwctNquAGJmUDSWtIPST
	doIJu5f5NujyNaRQLj5oHlJPYzPZm3vffNLyHKSKU0ixeYeVaKYLHgqj5jb07FX7
	jloRph69qCF0OyLl79dLpKZQIiy+6qi1UwKw8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EPqagANX4DHRECWX6Yzz3qge59ZYwLYE
	ECoaGnqxte4yam1z2jTjd5pN2/DNeg7R3fVqA8rhMp600M7C7de3oP8H67pQfa1H
	aVJAZ55eM8Tvc2aWeZ0AE++S0a65RLF1oewoXa5aJvfqd3QkrZAw8bWj+zIYCyRN
	vLtpHaasdZ8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E2A7C4CEAA;
	Sat, 25 Apr 2015 00:36:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 601BD4CEA9;
	Sat, 25 Apr 2015 00:36:33 -0400 (EDT)
In-Reply-To: <1429905998-9089-1-git-send-email-iveqy@iveqy.com> (Fredrik
	Gustafsson's message of "Fri, 24 Apr 2015 22:06:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A68474A8-EB04-11E4-93D7-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267771>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index 617e29b..e31d828 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -180,8 +180,9 @@ OPTIONS
>  +
>  --
>  strip::
> -	Strip leading and trailing empty lines, trailing whitespace, and
> -	#commentary and collapse consecutive empty lines.
> +	Strip leading and trailing empty lines, trailing whitespace,
> +	#commentary, unified diff added with `-v` and collapse
> +	consecutive empty lines.

I'd prefer the description not to be _too_ explicit e.g. by
mentioning "unified diff", etc.

Personally I think it is sufficient to do s/#comment/comment/ to the
existing text, without doing anything else.  What is "commentary" to
be removed is fairly clear in the contents given to the user in the
editor.
