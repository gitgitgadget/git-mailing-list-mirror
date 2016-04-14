From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Partition SubmittingPatches doc into two files
Date: Thu, 14 Apr 2016 15:16:59 -0700
Message-ID: <xmqq7ffzg7j8.fsf@gitster.mtv.corp.google.com>
References: <0102015416d52ae9-da060607-a742-4efc-8b40-98301c2bb261-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Roberto Tyley <roberto.tyley@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 00:17:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqpa6-0002Gz-Ny
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 00:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420AbcDNWRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 18:17:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56052 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752024AbcDNWRE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 18:17:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F080A13E7B;
	Thu, 14 Apr 2016 18:17:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5bIfOZG/MG3hCZhrL6Km1woG4Qo=; b=fXnOSv
	fQ8bpGJaHoRJGGvpgbdPpJW1bkiSpcg091QFeqCxtY26RnRHV0QoGkVVpU1906Bs
	He9pTyPrZ03MWida+jrzrVMPGwcA7Q1Zgd7oEMkrDJUhjkwi8sPNsyWn272o8ziR
	IxBmgC5RgCgmj6UuRnzJT8+z4PuIoCL+nOaaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f4WIpJNn0dPmovIveFflLi0skwjI5j/r
	MbapFhwUzOHnuyYJRh/9bkMC7ph5sXjMwDqkGEXHYtgxuqGJ1WpKbMqvIzGj5UYm
	JvCE6kdpVPg/F4YueWA8VBdikDS8E1Eh205bQRnJd7o/uE9/RvUOfpCYgPyUt08A
	FOAOfOUyqqw=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E818C13E7A;
	Thu, 14 Apr 2016 18:17:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4BB1C13E79;
	Thu, 14 Apr 2016 18:17:01 -0400 (EDT)
In-Reply-To: <0102015416d52ae9-da060607-a742-4efc-8b40-98301c2bb261-000000@eu-west-1.amazonses.com>
	(Roberto Tyley's message of "Thu, 14 Apr 2016 22:12:29 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9C5BC042-028E-11E6-92DE-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291572>

Roberto Tyley <roberto.tyley@gmail.com> writes:

> Subject: Re: [PATCH 1/2] Partition SubmittingPatches doc into two files

That violates the first paragraph of "(2) Describe your changes
well."

	SubmittingPatches: separate parts specific to mailed-in	patches

or something like that, to

 - Prefix with the "area";
 - Summarize what you did in a way that makes it clear why.

> No editorial changes in this commit, the text that is transferred into the
> second file is unchanged apart from minor chunk re-ordering.
>
> The split is based on:
>
> * Information needed for all users, whether using `git send-email` or
>   submitGit (ie good commit practice, mailing list etiquette)
> * Information needed just for `git send-email`/MUA users (generating the
>   right kind of diff, avoid MIME & PGP, send-email & MUA specific hints)
> ---

Violates "(5) Sign your work"?
