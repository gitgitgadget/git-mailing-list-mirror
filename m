From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] date.c: phrase a comment gender neutral
Date: Tue, 18 Nov 2014 12:03:48 -0800
Message-ID: <xmqq4mtwwa1n.fsf@gitster.dls.corp.google.com>
References: <1416338668-30683-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 21:03:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqp0F-000802-QV
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 21:03:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754568AbaKRUDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 15:03:52 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65187 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754213AbaKRUDv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 15:03:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DFF391E6E8;
	Tue, 18 Nov 2014 15:03:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NvCCb45U+bsLNj0qSwQVyJeVjkE=; b=fOs3sP
	NqxZvx8NrVXAvpl8uQzXzygbg2133JE/JcXhekrtuFyvYIV49kRserO1lK1a1d5Q
	9ZmCXxYl5ifzyEjoOwoWG03ISeQzU77WSTzEiD5NOMQno8BaXJSiyAmx6fVHAdup
	GHaA3NWUG8KO/ZHvGdQb/8YvsJOsMOnawwEi0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TfWulxD73I/HIj5AdDU0gIgLu/JTv3mE
	DZiUUdaHAOVlHXf9OO589hwOg5PIPr7jNz3k8Y43WXJC5lMvllppQ9E2z6tuNteA
	dVRP2An6eRVU5u/yuzc1gs5DyKInNGC9CQQCRbrZlSuiBHxU/BASPAoCj+aGhHur
	1RcePakgkN4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D738F1E6E7;
	Tue, 18 Nov 2014 15:03:51 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6165C1E6E6;
	Tue, 18 Nov 2014 15:03:51 -0500 (EST)
In-Reply-To: <1416338668-30683-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 18 Nov 2014 11:24:28 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0415B4E2-6F5E-11E4-AF52-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> When looking for suitable functions to print dates,
> I found this gem. Let's make it gender neutral as
> nowadays people get upset by this gender debate.

For some time I used to use "she/her" on Mondays, Wednesdays and
Fridays and "he/his" on other days to balance them, and you are
seeing the artifact of that.

Some people might feel that we would be better off using "they" all
the time, but IMO it's such a minor thing that once it _is_ in the
tree, it's not really worth the patch noise to go and fix it up.


>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  date.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/date.c b/date.c
> index 59dfe57..19fb439 100644
> --- a/date.c
> +++ b/date.c
> @@ -732,7 +732,7 @@ int parse_expiry_date(const char *date, unsigned long *timestamp)
>  		/*
>  		 * We take over "now" here, which usually translates
>  		 * to the current timestamp.  This is because the user
> -		 * really means to expire everything she has done in
> +		 * really means to expire everything they have done in
>  		 * the past, and by definition reflogs are the record
>  		 * of the past, and there is nothing from the future
>  		 * to be kept.
