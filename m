From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add missing -z to git check-attr usage text for
 consistency with man page
Date: Mon, 17 Sep 2012 13:45:23 -0700
Message-ID: <7vipbctm3g.fsf@alter.siamese.dyndns.org>
References: <1347881931-9129-1-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Mon Sep 17 22:45:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDiCF-0008BS-I7
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 22:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755594Ab2IQUp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 16:45:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60307 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752443Ab2IQUpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 16:45:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B7578431;
	Mon, 17 Sep 2012 16:45:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1WEZbN0oLpgyQY4M1/Jqg4C5eas=; b=yOiBcI
	aPfvImm7jTc36YQf71kYZGhHQa0gFZtVgq8YfJi97hQyXr7q8pcmmV8+1LuYQAa8
	nnvYQfj8O2ks3ESPFOfT1hqe408aOumz9X6QwTijZ/J2UxFXk7p+dAKli8K63rps
	NR28LbXKX6AA7Gv8VnWGhB0Vy5kfRhg6NPQUY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AKnZZ8eVKkK+rejkUtfHhiRe1SvyzFD4
	LTNzBWkLYaGj7kFbXBQAvdcWJA2JiAM0u4UCbKFYE4nl+legr91IZIHf6ou4jRbk
	kBp1a8fpYlWvW/M6w9Bs13vnUulTEcUtDtKUwbsFHxFnG+kOAmCy2pmF1HjpLKmI
	Ii7wBiOluBM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44A6D8430;
	Mon, 17 Sep 2012 16:45:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B38AC842B; Mon, 17 Sep 2012
 16:45:24 -0400 (EDT)
In-Reply-To: <1347881931-9129-1-git-send-email-git@adamspiers.org> (Adam
 Spiers's message of "Mon, 17 Sep 2012 12:38:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9B102268-0108-11E2-911F-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205744>

Adam Spiers <git@adamspiers.org> writes:

> Signed-off-by: Adam Spiers <git@adamspiers.org>
> ---
>  builtin/check-attr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/check-attr.c b/builtin/check-attr.c
> index e1ff575..075d01d 100644
> --- a/builtin/check-attr.c
> +++ b/builtin/check-attr.c
> @@ -9,7 +9,7 @@ static int cached_attrs;
>  static int stdin_paths;
>  static const char * const check_attr_usage[] = {
>  N_("git check-attr [-a | --all | attr...] [--] pathname..."),
> -N_("git check-attr --stdin [-a | --all | attr...] < <list-of-paths>"),
> +N_("git check-attr --stdin [-z] [-a | --all | attr...] < <list-of-paths>"),
>  NULL
>  };

I think this deserves to go to 'maint' that does not yet
have the i18n on this part, so I'll wiggle the patch to apply there
and merge it up.

Thanks.
