From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] Ignore git-subtree
Date: Tue, 01 Jan 2013 13:44:40 -0800
Message-ID: <7vk3rw8to7.fsf@alter.siamese.dyndns.org>
References: <1357012655-24974-1-git-send-email-greened@obbligato.org>
 <1357012655-24974-8-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Schubert <mschub@elegosoft.com>
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Tue Jan 01 22:45:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tq9dt-0001xj-Fu
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 22:45:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514Ab3AAVon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 16:44:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51438 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752460Ab3AAVom (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 16:44:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B69D9B46;
	Tue,  1 Jan 2013 16:44:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4bFg7k2GiFgy8Bg0uazTSe67NTk=; b=GKmsgX
	RQTb5ybboJNXdAIjkNNn4UeMC9Cl3FbbHbbo2EaEmLIEqjNOQWp7oBx2vYMaxZPE
	pr+wjjIcpr9arqtdh/3Zz+ne+Xt75brtyNSXl3l9OvrZMUpG8DxnNjMVn6E2C223
	j8P3W/rF9C1p5deVRIwwqJnz+/QrzwMscjrEw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L1+k5J2Y4FqIugMazPh/ddhbsf0V0Sr7
	J8R3gWrs2POzQuqXvbeRjFdlR/uHELgPMHoDe6A4rd+4rcjHZ+qSLDzXAetZc9Cw
	nsBvG+b6X85WwRsq0bP86VQ9FKVLwopL5crVmpZH7Raj55Ar7n/p6GI9u+Rfkppq
	LseLpHtJ79s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D13A9B45;
	Tue,  1 Jan 2013 16:44:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 649609B42; Tue,  1 Jan 2013
 16:44:41 -0500 (EST)
In-Reply-To: <1357012655-24974-8-git-send-email-greened@obbligato.org> (David
 A. Greene's message of "Mon, 31 Dec 2012 21:57:34 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 72CB73C8-545C-11E2-9894-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212454>

"David A. Greene" <greened@obbligato.org> writes:

> From: Michael Schubert <mschub@elegosoft.com>
>
> Add the git-subtree command executable to .gitignore.
>
> Author:    Michael Schubert <mschub@elegosoft.com>
>
> Signed-off-by:    Michael Schubert <mschub@elegosoft.com>
>
> Signed-off-by: David A. Greene <greened@obbligato.org>
> ---

Seems sensible; I think I have this already in my tree.

>  contrib/subtree/.gitignore |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/contrib/subtree/.gitignore b/contrib/subtree/.gitignore
> index 7e77c9d..91360a3 100644
> --- a/contrib/subtree/.gitignore
> +++ b/contrib/subtree/.gitignore
> @@ -1,4 +1,5 @@
>  *~
> +git-subtree
>  git-subtree.xml
>  git-subtree.1
>  mainline
