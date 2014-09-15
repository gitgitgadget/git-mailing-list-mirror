From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] t1503: test rev-parse --verify --quiet with deleted reflogs
Date: Mon, 15 Sep 2014 15:32:37 -0700
Message-ID: <xmqqk3544ire.fsf@gitster.dls.corp.google.com>
References: <1410808059-1459-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Fabian Ruch <bafain@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 00:32:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTepC-0000u2-J6
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 00:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758922AbaIOWcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 18:32:42 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64929 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755058AbaIOWck (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 18:32:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0853C3B32C;
	Mon, 15 Sep 2014 18:32:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=velmbFVY2CJbm/ZvY+7H8bwPkdw=; b=T+6Z8X
	YHJGCPc3df3CyzjqpSGfPqX84cesQ7Z7YxvYL+zvGScpyeTnjZlGezb5NQI/X/om
	YN+giPmtAx8LUXqT2pEsKGlD/eJ05VyBRzI4tfSbCtrFxu/ElTCVCdYtrYSZ2NYT
	DA60MGzfhbw8kwUercVr5TKIVwIGaQgFCOPKI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F//Lcc2VoMNl73lK1Xb7B5LcCaPtueil
	d4IVLruOxBni7r1YCV+3BPJ1TniqFsgbSrheoIIwHlmWQbCCfBHvpoFN6H6fHYrp
	2TtHkwQamBKWW2urT+CBwSeLRXAOMN97TQhpNpqu03ltTnY6XrzlOA0deCPN9dY0
	AOqsXAL3K/s=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F26023B32B;
	Mon, 15 Sep 2014 18:32:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7095C3B32A;
	Mon, 15 Sep 2014 18:32:39 -0400 (EDT)
In-Reply-To: <1410808059-1459-1-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Mon, 15 Sep 2014 12:07:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 332FDFC2-3D28-11E4-89BF-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257112>

David Aguilar <davvid@gmail.com> writes:

> Ensure that rev-parse --verify --quiet is silent when asked
> about deleted reflog entries.
>
> Helped-by: Fabian Ruch <bafain@gmail.com>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> Differences since last time:
>
> This goes back to the original approach of using "git update-ref"
> plumbing instead of "git branch" when testing deleted reflogs.

Is this 1/3 (the first one in the series) supposed to pass without
no other patches, either in the series or something outside?
