From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/6] Improve tag checking in fsck and with transfer.fsckobjects
Date: Wed, 10 Sep 2014 14:07:44 -0700
Message-ID: <xmqq7g1bgp5r.fsf@gitster.dls.corp.google.com>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info>
	<alpine.DEB.1.00.1409101552250.990@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 10 23:08:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRp7I-0002jU-22
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 23:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385AbaIJVHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 17:07:48 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56138 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751971AbaIJVHr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 17:07:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1E454388B8;
	Wed, 10 Sep 2014 17:07:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DWZUaIuYxJ/u2BhnF6MU1mF/n9c=; b=Wi2GJ7
	4AwlL5jg8L8/Fi9uX9XrZlwwpbp4DL8lRx+AAc7dSqYetu8laon204xecsowHZBt
	cfG/SnFqbeFaaEwhDheNrPqhxL9vqQ87SpD1W5Q/MDESsDUfuDGXmWgMfObCYRa7
	Qbm5YouarunE8hoBI4H8bQ/y2VHebjP2WsH9k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mQrXnD8+C81Qb7FIzGUkyqnJyP6w/R6Q
	nMnqviztu6o7FbZzA+kRs9xYmuQ7UQvJjx6GyoDFUDa40SvSvXUsjwNDvFjrdVWL
	svggfsD4vm/DNQjw3L8+brbvuIt/XUS2ZWtyUIseVqzOdM4KGM5hMsPJv1/hy9Ej
	9LHpz2Ww0TQ=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 13F38388B7;
	Wed, 10 Sep 2014 17:07:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 908D1388B6;
	Wed, 10 Sep 2014 17:07:46 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.1409101552250.990@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Wed, 10 Sep 2014 15:52:33 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 83889980-392E-11E4-8B98-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256766>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This patch series introduces detailed checking of tag objects when calling
> git fsck, and also when transfer.fsckobjects is set to true.
>
> To this end, the fsck machinery is reworked to accept the buffer and size
> of the object to check, and for commit and tag objects, we verify that the
> buffers contain an end of header (i.e. an empty line) to guarantee that our
> checks do not run beyond the buffer.

Overall they looked sensible and I am trying to queue them on 'pu'
for today's pushout.

Thanks.
