From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: add some crossrefs between manual pages
Date: Tue, 11 Nov 2014 14:51:29 -0800
Message-ID: <xmqqppct5p1q.fsf@gitster.dls.corp.google.com>
References: <1415737027-44589-1-git-send-email-max@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, spearce@spearce.org, jrnieder@gmail.com
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Tue Nov 11 23:51:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoKHg-0000zE-VZ
	for gcvg-git-2@plane.gmane.org; Tue, 11 Nov 2014 23:51:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473AbaKKWvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2014 17:51:33 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57103 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752265AbaKKWvc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2014 17:51:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 824C01D9F1;
	Tue, 11 Nov 2014 17:51:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P206/gO0Zsu3IsxJXseWGIV9sOU=; b=GOSVLY
	eZ7TtYLdK6/UJK1e/Sa5f/pwMjZ1gFhv49/pby4ga+ewo/mVm4YuxGYcGv6vdV26
	hdVeakkgP2cPjYN1xHn8av+ckVofx8LnvLyyACGjnU1SdBlDNqUsrdVl+Cy8UzWl
	zTJjlyuyjF2yYMGpkM0G4ZQv/y9+EwiiCPVcI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NDfmyA0D9Cb7YechFoVfIChqFDVDRr/0
	AO1duVZsFpZJFIexBoGHfIX6CKx3RpYW7VEe3Fha6X/h3NNvBZZuX+HWMj6Fo2vG
	0EqthUPnT+/02gjvbOElZdJ81IQe9EHiDD6glca2/hw92ZHF3SY8MH1xDVKUzniJ
	u0Uc0yS3nto=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 794741D9F0;
	Tue, 11 Nov 2014 17:51:31 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ED5D91D9EF;
	Tue, 11 Nov 2014 17:51:30 -0500 (EST)
In-Reply-To: <1415737027-44589-1-git-send-email-max@quendi.de> (Max Horn's
	message of "Tue, 11 Nov 2014 21:17:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 472A9A18-69F5-11E4-BFF4-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Max Horn <max@quendi.de> writes:

> I did this because I was browsing the remote helper docs online quite a bit,
> and was wishing for some more direct links between the pages. While I can
> manyally edit the URL, it seems logical to offer these links directly.

> diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
> ...
> +linkgit:git-fast-import[1]

> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
> ...
> +linkgit:git-fast-export[1]

Makes sense to have these pair refer to each other.

> diff --git a/Documentation/git-remote-ext.txt b/Documentation/git-remote-ext.txt
> ...
> +linkgit:gitremote-helpers[1]

> diff --git a/Documentation/git-remote-fd.txt b/Documentation/git-remote-fd.txt
> +linkgit:gitremote-helpers[1]

Likewise.  git-remote-* are instances of gitremote-helpers.

> diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
> index 64f7ad2..8edf72c 100644
> --- a/Documentation/gitremote-helpers.txt
> +++ b/Documentation/gitremote-helpers.txt
> @@ -452,8 +452,14 @@ SEE ALSO
>  --------
>  linkgit:git-remote[1]
>  
> +linkgit:git-remote-ext[1]
> +
> +linkgit:git-remote-fd[1]
> +
>  linkgit:git-remote-testgit[1]

Makes sense.

> +linkgit:git-fast-import[1]

This looks somewhat out of place; fast-import is not the only or
even the primary way to do a remote-helper, is it?
