From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Makefile: Improve wording in a comment
Date: Thu, 05 Feb 2015 11:17:44 -0800
Message-ID: <xmqqr3u4kw13.fsf@gitster.dls.corp.google.com>
References: <CAHGBnuPnwE8K81C_9W65Jk1FMU==gMODOKvGYBbgNRNbvx_bag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>, normalperson@yhbt.net,
	amyrick@apple.com
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 20:17:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJRw0-0007Bm-JN
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 20:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbbBETRs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 14:17:48 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59259 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751431AbbBETRr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 14:17:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E2BA4356AC;
	Thu,  5 Feb 2015 14:17:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mLCC0T8xYtGzUwKe8nX9SG/qGB0=; b=hL8UpM
	E/QFIP0QNxUiAVltBOSXq/Y85V6eV4ZHbQpPm9joE/3eSFf8kMuEKfhpZ9cwBy+p
	Wx9la67l3Y6y08SmYvk89hUDeeSZE11JPM+Mzz2fF5GW0d6dOg8Kx3cFpnwsMwe2
	SIS8LRcnCK9tQvsAcTq3sOFne3uzQm2LKoN4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BAHypQNEGuY7NvMYKkfSRkoYnI5ziBBI
	8sIHfgAfj5Z7aiMDR/4Q3B3JaW4yqOtevohQr8UBT82VmZt/kaPAMQADgoeOwqEJ
	auwQFzQwrgvSF1f5JyYe/BO6x2Bjy04iRG1GubfAJ6bXs/1rJAjIoswStd4N9V8H
	6BbtKLMA2EM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D24FC356AA;
	Thu,  5 Feb 2015 14:17:46 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 54528356A9;
	Thu,  5 Feb 2015 14:17:46 -0500 (EST)
In-Reply-To: <CAHGBnuPnwE8K81C_9W65Jk1FMU==gMODOKvGYBbgNRNbvx_bag@mail.gmail.com>
	(Sebastian Schuberth's message of "Thu, 5 Feb 2015 14:26:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AA9E0CF6-AD6B-11E4-A3C8-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263386>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---

Is that an improvement?  Is the plural of "dup" (used as an
abbreviation of "duplicate") "dupes" not "dups"?

>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index c44eb3a..6f8ae23 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2447,7 +2447,7 @@ check-docs::
>          esac; \
>      done ) | sort
>
> -### Make sure built-ins do not have dups and listed in git.c
> +### Make sure built-ins do not have dupes and are listed in git.c
>  #
>  check-builtins::
>      ./check-builtins.sh
