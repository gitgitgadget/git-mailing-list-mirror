From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/10] test-lib: add helper functions for config
Date: Thu, 18 Aug 2011 14:10:13 -0700
Message-ID: <7v1uwi8ikk.fsf@alter.siamese.dyndns.org>
References: <20110818045821.GA17377@sigill.intra.peff.net>
 <20110818050114.GB2889@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 19 00:24:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuB0U-0003Jb-8u
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 00:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754885Ab1HRWX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 18:23:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42003 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754737Ab1HRWX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 18:23:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4A714359;
	Thu, 18 Aug 2011 18:23:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=lifz4lNGa0DI/p7lOSUdRlY1/SA=; b=aVNOAEi+1FQE4Nwsgcj7
	7dIgOC3gQOygt4MukxAKHmmA+l2n3W1E/X3Kk5NumIkajGbeIbD3EyzXr05M3zZm
	hb5O0FeMFHrO3+bzudjdwd7GhQNnpugCNvvdUDyUzyNaP7NiqtAfqd9IYvvT8Ga0
	frgGFRmCXKy+EYemay+dqGA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=mTf04icU9uuJGT2R2FGLxfw+FQaOxMiyoz3mJXWxCObRxD
	VteX+7rx8pkeHlrtF73ToyXVonWNlOZP9ung+GM6VTwBfSEyx4wnX5736izygpAB
	OlWgrl5EAbi8fY8+L2X3woKD71MMM2LLbguP6Ou7JEj0pYQzEWw0c8B9ZZejU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DAECD4358;
	Thu, 18 Aug 2011 18:23:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 563884355; Thu, 18 Aug 2011
 18:23:56 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C314E706-C9E8-11E0-A1DC-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179642>

Thanks.

> ...
> +# Unset a configuration variable, but don't fail if it doesn't exist.
> +test_unconfig () {
> +	git config --unset-all "$@"
> +	config_status=$?
> +	case "$config_status" in
> +	5) # ok, nothing to usnet
> +		config_status=0
> +		;;

Will queue with 's/nothing to usnet/nothing to unset/'.
