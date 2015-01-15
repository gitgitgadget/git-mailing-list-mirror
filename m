From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] init-db: remove unused include
Date: Thu, 15 Jan 2015 11:11:53 -0800
Message-ID: <xmqqiog77tae.fsf@gitster.dls.corp.google.com>
References: <1421322451-1852-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 20:12:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBppo-0001db-KD
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 20:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271AbbAOTL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 14:11:56 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55885 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751417AbbAOTL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 14:11:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F6872E1A1;
	Thu, 15 Jan 2015 14:11:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z5ATK/6amCsLOSsjP0nGKJc1YlY=; b=etMdhA
	ahZMI2dwmoQclG2TQEs4HuPti6s/keqgMYmRbN5kUV1afJHawnnoRsxXliZsi7s8
	URmgGxVkaFbDifCoWPE1i5e66tagaCHMlgUsHhJwD6KKjuFLx3CcQSAMuBvKntiV
	Ub2+0CXhyjrFgLocrvbz6z7RSFSvFhR0V1ya8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VxYwPcCE/G3EjW9LqOns0yD+E17yaBed
	OMIeKE9G+CVRgOnsn52MW8uWb4QQUE75OjKZ/vAcbKDiVtoZqZMjCnFvHOvJyHTu
	EswD5Wk1BkonFAI2COrmjFmmPGJcJlDe/83b21wOqDJ7IQAAza64n0K2CTKnBVdn
	Fa3/3GrVGkU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 667CF2E1A0;
	Thu, 15 Jan 2015 14:11:55 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E0BA42E19C;
	Thu, 15 Jan 2015 14:11:54 -0500 (EST)
In-Reply-To: <1421322451-1852-1-git-send-email-kuleshovmail@gmail.com>
	(Alexander Kuleshov's message of "Thu, 15 Jan 2015 17:47:31 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5E7A3ADE-9CEA-11E4-90F9-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262502>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> "cache.h" removed, because it's already included at "builtin.h"
>
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---

Let's put this on hold.

$ git grep --all-match -l -e cache\\.h -e builtin\\.h -- \*.c

shows us there are tons, not just this one.

Also I'd like to see this discussion simmer a bit more:

  http://thread.gmane.org/gmane.comp.version-control.git/262454/focus=262499

>  builtin/init-db.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 280454a..8edef87 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -3,7 +3,6 @@
>   *
>   * Copyright (C) Linus Torvalds, 2005
>   */
> -#include "cache.h"
>  #include "builtin.h"
>  #include "exec_cmd.h"
>  #include "parse-options.h"
