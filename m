From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitignore.txt: fix spelling of "backslash"
Date: Tue, 04 Nov 2014 14:47:58 -0800
Message-ID: <xmqqzjc6oa5d.fsf@gitster.dls.corp.google.com>
References: <CAHG0eJWMyps1DCO583+ShjH+hWW3dPbW++nZFo-n=hJgoNCtEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Ben North <ben@redfrontdoor.org>
X-From: git-owner@vger.kernel.org Tue Nov 04 23:48:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlmtV-00077R-Kd
	for gcvg-git-2@plane.gmane.org; Tue, 04 Nov 2014 23:48:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbaKDWsD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2014 17:48:03 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54226 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751129AbaKDWsB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2014 17:48:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B3D11BA7F;
	Tue,  4 Nov 2014 17:48:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KizA/XvoNGjyklCBm6ibWF3x5Gw=; b=ic5hzx
	irznd7qXAxqox7xppd8QFn6JqUKT1PzyfkvtrKZKTkD79Qqh220wE7PjhUj8HPy0
	dP+0W3A/bXeRM99vNtyBLy3DgtO5PuIVK5mCnpcTVSz5+65g7YKkmHRxxLoCFKhc
	lyQ52GI6gcPCfKW/gLWHTaqYEQGS13gOt8yko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ryYWEPh+abbsXVEQhEaC3TORrgnzEVS8
	BTm8ke/eN9M5IMj02e2qkElam7OozUlFVDe8l0cD+NlB26aZlkNVH7LsVfmzNznZ
	CzzzOm2Clvlz1LMNC9e/cp1dG4xoP0JZ/rSE81P92SdPDuu5fTLWrHlDg1YfJCTd
	FlsoJPHnIX4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D51B1BA7E;
	Tue,  4 Nov 2014 17:48:00 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 838081BA7C;
	Tue,  4 Nov 2014 17:47:59 -0500 (EST)
In-Reply-To: <CAHG0eJWMyps1DCO583+ShjH+hWW3dPbW++nZFo-n=hJgoNCtEg@mail.gmail.com>
	(Ben North's message of "Tue, 4 Nov 2014 22:18:33 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A0401546-6474-11E4-A1E3-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben North <ben@redfrontdoor.org> writes:

> Signed-off-by: Ben North <ben@redfrontdoor.org>
> ---
>  Documentation/gitignore.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
> index 8734c15..09e82c3 100644
> --- a/Documentation/gitignore.txt
> +++ b/Documentation/gitignore.txt
> @@ -77,7 +77,7 @@ PATTERN FORMAT
>     Put a backslash ("`\`") in front of the first hash for patterns
>     that begin with a hash.
>
> - - Trailing spaces are ignored unless they are quoted with backlash
> + - Trailing spaces are ignored unless they are quoted with backslash
>     ("`\`").
>
>   - An optional prefix "`!`" which negates the pattern; any

:-0  Thanks.
