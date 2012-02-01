From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] i18n: git-commit whence_s "merge/cherry-pick" message
Date: Wed, 01 Feb 2012 15:46:20 -0800
Message-ID: <7vpqdy15ir.fsf@alter.siamese.dyndns.org>
References: <1328116830-61290-1-git-send-email-worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, avarab@gmail.com
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 00:46:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsjsh-0003jT-Pr
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 00:46:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160Ab2BAXqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 18:46:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54141 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752952Ab2BAXqW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 18:46:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2658B73DB;
	Wed,  1 Feb 2012 18:46:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0iU4rMUpYLnQHWIitDu6wY8v8a0=; b=Sd5S5K
	4E+m6CfPWLADUSYeTKO65SbY4bDD1Of0YlTrDirzDbtMUXwBPxBSlHkkkjuyn4Lg
	+xwQ7+NFTXACXfKpCtqM8Cq6UhinyIkXqU/NpWf+5/iIBx2OcfxuWbJHFh30FGaf
	+Jsg+jRofDSP3bROQ+PWtp5rQWffZNFfPaCAs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AP/zrDsg4kDI6fQyLNrfX9F7fN/iUWob
	UTeCnNjJTbXNX3yd8uJ5w28SQQXqjPFsYzMWxgTNxJnE/PzK+7PwH5vM8IsQLrFc
	24vRaoXP0/RBFQ/SvsbHZc6685YvLRH3McHKFussURum5Oi0IjKxJll8vRYRZymH
	Cu0cnJ+0veg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D63073DA;
	Wed,  1 Feb 2012 18:46:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A186773D9; Wed,  1 Feb 2012
 18:46:21 -0500 (EST)
In-Reply-To: <1328116830-61290-1-git-send-email-worldhello.net@gmail.com>
 (Jiang Xin's message of "Thu, 2 Feb 2012 01:20:30 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F1B37AB8-4D2E-11E1-BF65-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189558>

Jiang Xin <worldhello.net@gmail.com> writes:

> Mark the "merge/cherry-pick" messages in whence_s for translation.
> These messages returned from whence_s function are used as argument
> to build other messages.
>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> ---
>  builtin/commit.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index eba137..663e1 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -202,10 +202,10 @@ static const char *whence_s(void)
>  	case FROM_COMMIT:
>  		break;
>  	case FROM_MERGE:
> -		s = "merge";
> +		s = _("merge");
>  		break;
>  	case FROM_CHERRY_PICK:
> -		s = "cherry-pick";
> +		s = _("cherry-pick");
>  		break;
>  	}

builtin/commit.c: In function 'whence_s':
builtin/commit.c:206: error: assignment discards qualifiers from pointer target type
builtin/commit.c:209: error: assignment discards qualifiers from pointer target type

I'll squash the following in.  Thanks.

 builtin/commit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 663e1fd..470b4a4 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -196,7 +196,7 @@ static void determine_whence(struct wt_status *s)
 
 static const char *whence_s(void)
 {
-	char *s = "";
+	const char *s = "";
 
 	switch (whence) {
 	case FROM_COMMIT:
