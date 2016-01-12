From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] completion: add missing branch.*.rebase values
Date: Tue, 12 Jan 2016 15:54:43 -0800
Message-ID: <xmqqfuy2s69o.fsf@gitster.mtv.corp.google.com>
References: <cover.1452612112.git.johannes.schindelin@gmx.de>
	<cf10b421435e456c0dce15e547bb748081919b08.1452612112.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 13 00:54:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ8m2-0005Xy-RS
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 00:54:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971AbcALXyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 18:54:46 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62721 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750915AbcALXyp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 18:54:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C35223BAA3;
	Tue, 12 Jan 2016 18:54:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4aoWVl6UZsMskWsLEwZNFnySQiE=; b=Bu/6xM
	4XSkj+k9XpXSvRJQjKfst3+tpKByvfIjR+2lz5CJ1c5zcG5oEv54ipwSJ6W3v18d
	U6cfrAQ7cBGjgeK1Ekp47Q4CqmMAKdNzQlTc7N1u+27IN46CoDmPH/4l564T2sWM
	P/tq6q8FuM87zrAetJJ1ouBgpz3MKtMdK81hs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ru+78rdjgVjJfl8cWcSebpNW0LV34Kpo
	w1m4hglAmiEw2jI80sIp+zyCbAgVxUT56kTxdT2UB48urdgWNkplzed5mdS3Zx5f
	vTAlLEkad8ANPMurvhUNEaLN46yDtnUa9+bcHnzMckIGriBtr6nljNrQZMHd/cra
	UIJlGhLvYVQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B94383BAA2;
	Tue, 12 Jan 2016 18:54:44 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3C9393BAA0;
	Tue, 12 Jan 2016 18:54:44 -0500 (EST)
In-Reply-To: <cf10b421435e456c0dce15e547bb748081919b08.1452612112.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Tue, 12 Jan 2016 16:22:21 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DA85FAC2-B987-11E5-984F-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283856>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index ab4da7f..51f5223 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1809,7 +1809,7 @@ _git_config ()
>  		return
>  		;;
>  	branch.*.rebase)
> -		__gitcomp "false true"
> +		__gitcomp "false true preserve interactive"
>  		return
>  		;;
>  	remote.pushdefault)

OK, thanks.
