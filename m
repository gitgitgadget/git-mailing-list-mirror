From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] README.md: don't call git stupid in the title
Date: Tue, 23 Feb 2016 13:37:52 -0800
Message-ID: <xmqqwppvxg3z.fsf@gitster.mtv.corp.google.com>
References: <1456249229-30454-1-git-send-email-Matthieu.Moy@imag.fr>
	<1456249229-30454-5-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqegc31br3.fsf@gitster.mtv.corp.google.com>
	<vpqmvqrf8w5.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, emma.westby@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Feb 23 22:38:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYKed-0004Cp-UP
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 22:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755439AbcBWVh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 16:37:56 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51537 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755423AbcBWVhz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 16:37:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4E11F46902;
	Tue, 23 Feb 2016 16:37:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MdfWnE4rUWPZcvUb/YGtkcq/Exc=; b=bZ7wtB
	8g1z+yPAp1iby1xuztTFSMPqoiFwqktF6x1ndae/si51nz3Jk8bOP8XjYwKfC3oR
	D7rWjPUGzuFtQUtTvAykPjCo0D8D8EFvb6ftibYTaWu6pieC0cJrWKjhn6fPCc+s
	3urs91f3PkgHyB1cX9EMo0KEchVixO3DnElyI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MNWvr8OH84ibryzbNE20Q1/hEbXGH6aE
	NtFNTDTZgT1LKprprhGa0f4zUx0qqdAYvqIAUstCwq6AyX1NoG6Ay+FSNm0Unx/Y
	Y/7zBTZ52lwqgAeBk87VP9wMmzk2O0vvcChENDDTlYR4VjgPPLZQkeVYlMsDKAZ4
	stxRAy3LkVU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 45AD946900;
	Tue, 23 Feb 2016 16:37:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 99A67468FD;
	Tue, 23 Feb 2016 16:37:53 -0500 (EST)
In-Reply-To: <vpqmvqrf8w5.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	23 Feb 2016 21:51:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B1F6797E-DA75-11E5-A3EC-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287129>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Having said that, I agree with the spirit of 4/5 and 5/5; but it is
>> sad that this line is not resurrected by 5/5 in some way.
>
> Do you mean something like this:
>
> diff --git a/README.md b/README.md
> index 40de78e..b1c89bd 100644
> --- a/README.md
> +++ b/README.md
> @@ -41,7 +41,8 @@ list.  The discussion following them give a good reference for
>  project status, development direction and remaining tasks.
>  
>  The name "git" was given by Linus Torvalds when he wrote the very
> -first version. He described it as (depending on your mood):
> +first version. He described the tool as "the stupid content tracker"
> +and the name as (depending on your mood):

Exactly.
