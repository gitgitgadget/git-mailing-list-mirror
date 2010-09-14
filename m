From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] git-reset.txt: clarify branch vs. branch head
Date: Mon, 13 Sep 2010 17:35:29 -0700
Message-ID: <7v62y99n72.fsf@alter.siamese.dyndns.org>
References: <cover.1284365021.git.git@drmicha.warpmail.net>
 <4cb6432e6fc534231841ca8301b9022fa038946c.1284365021.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 14 02:35:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvJV1-0006bL-EM
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 02:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073Ab0INAfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Sep 2010 20:35:39 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37239 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908Ab0INAfi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 20:35:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F2387D6C85;
	Mon, 13 Sep 2010 20:35:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=04cLtCUMqLX8L7fNleRCJrrqErQ=; b=tUk/zaJmDoUKU+rTTE5FQRL
	vbJm6GXf2JVmXQQiXl05Z5DrRLwECvSvpF8wT5orRQuwgJ+mOQyA14EikMic3J3Q
	scaEIZXAl/4snxnm2MCF7LWk8+OXIscP9f2sDZI7nOdKXgO6ewHZDQKaP+xj/p9p
	91gEIvTQvm9ZhZsRKoSE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=a9/x8AWtJMeeQGebe0gpDlEeBxMOv+OrblUg3XlAUSqz/kV4W
	fWrQO2esQqk6soFby5mL2t0YULG+5ne9HNvYWVK7zMEfA0A3YCJPvL5NabNtd5+8
	P3+zBPLiIH06ZiKQCnp8qx/J16Ba1mMF7eZ1N0+08mBuAudFatpnOasvRc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B44F6D6C84;
	Mon, 13 Sep 2010 20:35:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F11F8D6C83; Mon, 13 Sep
 2010 20:35:30 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FCD3D300-BF97-11DF-BC99-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156156>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> @@ -36,7 +36,7 @@ This means that `git reset -p` is the opposite of `git add -p` (see
>  linkgit:git-add[1]).
>  
>  'git reset' [--<mode>] [<commit>]::
> -	This form points the current branch to <commit> and then
> +	This form sets the current branch head to <commit> and then
>  	updates index and working tree according to <mode>, which must
>  	be one of the following:

Perhaps "resets" or "moves" is even clearer?

In any case I think this is an improvement.
