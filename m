From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] RelNotes: correct name of versionsort.prereleaseSuffix
Date: Thu, 23 Apr 2015 11:29:28 -0700
Message-ID: <xmqqmw1y3dh3.fsf@gitster.dls.corp.google.com>
References: <1429792070-22991-1-git-send-email-mhagger@alum.mit.edu>
	<1429792070-22991-4-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Apr 23 20:29:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlLsW-0003Hw-It
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 20:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030404AbbDWS3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2015 14:29:32 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61726 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030389AbbDWS3a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2015 14:29:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 57EC94B63E;
	Thu, 23 Apr 2015 14:29:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H9OKfAjMAfeYfQSfSxfW37R9K+0=; b=kihr2d
	CKDyEHnkhn+SMEjzV5rc+E/cyz7C7lSHGt9l5pBIDU2m01vpdyzZmPFAsn2/xcuz
	TAyYylorNrtmt873jBOy2ZtkETBHOkDwhE0LowOGMErCNs00/CBs3VplLcecMVyU
	ZpsJmsscF+UX5wUtON7PMQ1ZpiNXLHjxzFBMU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ppJmKEGF2aAvIO+kQ336y9nTbz2XE7PV
	TdDDowtZKUZUzq5tsmkd8eFN7bmccR8bbRU880cpgwIjUSzbwwmcn2fJ3dykcuFd
	bkiuDYoPOgIFpswA/sTGSXpQasle8MSE0a9jpzQy21vH7me40e84wq7jhaaI3NF0
	yxIQKBePy08=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5138C4B63D;
	Thu, 23 Apr 2015 14:29:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C7B3D4B63C;
	Thu, 23 Apr 2015 14:29:29 -0400 (EDT)
In-Reply-To: <1429792070-22991-4-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Thu, 23 Apr 2015 14:27:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ADF63EC0-E9E6-11E4-823E-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267700>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---

Thanks.


>  Documentation/RelNotes/2.4.0.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/RelNotes/2.4.0.txt b/Documentation/RelNotes/2.4.0.txt
> index a0ee37d..c02de8d 100644
> --- a/Documentation/RelNotes/2.4.0.txt
> +++ b/Documentation/RelNotes/2.4.0.txt
> @@ -109,8 +109,8 @@ UI, Workflows & Features
>     "cd ''" which silently behaves as a no-op.
>     (merge 6a536e2 kn/git-cd-to-empty later to maint).
>  
> - * The versionsort.prerelease configuration variable can be used to
> -   specify that v1.0-pre1 comes before v1.0.
> + * The versionsort.prereleaseSuffix configuration variable can be used
> +   to specify that v1.0-pre1 comes before v1.0.
>  
>   * A new "push.followTags" configuration turns the "--follow-tags"
>     option on by default for the "git push" command.
