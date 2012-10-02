From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] RelNotes/1.8.0: various typo and style fixes
Date: Tue, 02 Oct 2012 10:17:17 -0700
Message-ID: <7vd310aj4y.fsf@alter.siamese.dyndns.org>
References: <0a88dc3dd202903b2fbb2d32079767e45a72bb9e.1349188433.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Oct 02 19:17:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ66A-0000cr-BF
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 19:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223Ab2JBRRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 13:17:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37361 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751373Ab2JBRRU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 13:17:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFF527FF2;
	Tue,  2 Oct 2012 13:17:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hzmUMgXS9BbG67ZOLf/TQK6eoz0=; b=IYQHJR
	YRAl805AeNlj3Qp/WSYqTv19IptNgJNfzfsJYeVlyPkVx3ElB46YVTX4DUgNaSh6
	Q0l6FlaU10yXTT8xNQTOkHi5GJPqWr9iJG/3x2f6dyYBUKek+qrdOsyJ5ERDA9Tu
	i3lhzgww1eZv1M6JsjoA6Mpf+9J75ic4z5ZaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hb1kp4HZQzIM+TvstBu/S/BEpct/7yIv
	NcQ1Hkm15YpnTyM4t3dpC3bCALFs5aiOg3sKS/6QyoMVtmhPGIpiEhQs00ZzKHl4
	JLdENUNH6Od6YoJoE4Wt2yjihKqTVLhA6FMrifMRUBXkzq88YFDLi7PncZjPGXuG
	kXR2tStG/Zo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD6967FF1;
	Tue,  2 Oct 2012 13:17:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 378C07FF0; Tue,  2 Oct 2012
 13:17:19 -0400 (EDT)
In-Reply-To: <0a88dc3dd202903b2fbb2d32079767e45a72bb9e.1349188433.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Tue, 2 Oct 2012 16:35:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 05511ABC-0CB5-11E2-85C2-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206822>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> Just trying to make it clearer, and threw in an article or two.
> Also, tried to make the use of tenses a bit more uniform.

Thanks.

>  Documentation/RelNotes/1.8.0.txt | 48 ++++++++++++++++++++--------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/Documentation/RelNotes/1.8.0.txt b/Documentation/RelNotes/1.8.0.txt
> index cc460a4..a17f893 100644
> --- a/Documentation/RelNotes/1.8.0.txt
> +++ b/Documentation/RelNotes/1.8.0.txt
> @@ -4,11 +4,11 @@ Git v1.8.0 Release Notes
>  Backward compatibility notes
>  ----------------------------
>  
> -In the next major release, we will change the behaviour of the "git
> +In the next major release, we will change the behavior of the "git
>  push" command.  When "git push [$there]" does not say what to push, we
> -have used the traditional "matching" semantics (all your branches were
> +have used the traditional "matching" semantics so far (all your branches were
>  sent to the remote as long as there already are branches of the same
> -name over there).  We will use the "simple" semantics, that pushes the
> +name over there).  We will now use the "simple" semantics, that pushes the
>  current branch to the branch with the same name only when the current
>  branch is set to integrate with that remote branch.  There is a user
>  preference configuration variable "push.default" to change this, and

"so far" sounds fine but "will now" feels a bit overkill.

All the rest looked good.  Thanks.
