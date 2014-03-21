From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: status, remove leftover statement about '#' prefix
Date: Fri, 21 Mar 2014 11:00:30 -0700
Message-ID: <xmqqvbv7tosh.fsf@gitster.dls.corp.google.com>
References: <20140321141006.GA2126@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dirk Wallenstein <halsmit@t-online.de>
X-From: git-owner@vger.kernel.org Fri Mar 21 19:00:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR3kD-0000rZ-RJ
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 19:00:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbaCUSAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 14:00:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36667 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750706AbaCUSAd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 14:00:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E23AE74E5A;
	Fri, 21 Mar 2014 14:00:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6CzFMuAV92CdSP6q/zi4x9Yz3bI=; b=QiIBz4
	O0BfLid6QCEd3Py7sWI3x/EJK8iwUt4aiadOgc3dT4olfA/0h/FxbmGzDAmduRC+
	4FjyaM0vJUyZWBxhv0yxA52fbh+L/USsNsQTnU9gMw7FjMKmmsDRJyWWtvYWCSPt
	CA0+fQFfmmy3Z0/iSj/eFdd/QU57H/3iQ+MQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s+dVbuVH9JS5dtRAN6oWhhkpJ8Z3snue
	F+drqT4wHUpnVYSCq92/3nffxjDrbM0wOU45ldpd+d7tRDlweUGT8mrewSUGsa1b
	W6k61DDkrP8P1MEdld3vP7MMtT+0jA8hW0e2332Yow5BAOefPyphSlZgk6xC55tY
	eg9ijut1CXc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D09D874E59;
	Fri, 21 Mar 2014 14:00:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1605A74E58;
	Fri, 21 Mar 2014 14:00:32 -0400 (EDT)
In-Reply-To: <20140321141006.GA2126@t-online.de> (Dirk Wallenstein's message
	of "Fri, 21 Mar 2014 15:10:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B1C9314A-B122-11E3-B43D-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244712>

Dirk Wallenstein <halsmit@t-online.de> writes:

> This hasn't been true since 2556b9962e7c0353d562b7bf70eed11d8f29d0b0
>
> Signed-off-by: Dirk Wallenstein <halsmit@t-online.de>
> ---

Good eyes.  Thanks.

>  Documentation/git-status.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
> index a4acaa0..def635f 100644
> --- a/Documentation/git-status.txt
> +++ b/Documentation/git-status.txt
> @@ -97,7 +97,7 @@ configuration variable documented in linkgit:git-config[1].
>  OUTPUT
>  ------
>  The output from this command is designed to be used as a commit
> -template comment, and all the output lines are prefixed with '#'.
> +template comment.
>  The default, long format, is designed to be human readable,
>  verbose and descriptive.  Its contents and format are subject to change
>  at any time.
