From: Junio C Hamano <gitster@pobox.com>
Subject: Re: .gitmodules containing SSH clone URLs should fall back to HTTPS when SSH key is not valid/existent
Date: Thu, 29 May 2014 11:49:53 -0700
Message-ID: <xmqqbnugbesu.fsf@gitster.dls.corp.google.com>
References: <CA+OJ3uv0XqeodTCzeauUrH9FjzknBupMd5kxh+3qgyji5TwOzA@mail.gmail.com>
	<53871B8D.40608@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Leonard <johanatan@gmail.com>, git@vger.kernel.org,
	John Albietz <inthecloud247@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu May 29 20:50:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq5P2-0000dh-Ao
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 20:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbaE2SuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 14:50:06 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56751 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750940AbaE2SuE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 14:50:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B3EFA19B95;
	Thu, 29 May 2014 14:49:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bhifl9C5W8clSyiT0YP2m23pJ9w=; b=eyd/ed
	YMck9KlN4/ARLocBGkqfC21I50EGbR8lp7wM7mjaPqUo9t42b7KR7ipuFWmrg+93
	fyClyjmPAS9y/LRbMx2LNdCcVwGo00y7k6xvoOWcbG9Nn6xqLRH/QBe4mGE51E9A
	XzHxrwRO7CJf5oeZfzgxmJTgl6uDUznoOgDGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aUx+S482MAd/f1Ee5xKy3FnssAtFJW1y
	4OLa1sAysU3DVDQthVigr1OIcdRRNs2zxDSnq2pABtxG8zMBjrgawtlLyGXEvYnp
	LOj/Q/CBxO/Dmayv8ALjZbCZmEXUS0bWXGCIXVq0Hb2SexPuZM8CREoLvRLySMT5
	QV7srF/Jw48=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A8C3D19B94;
	Thu, 29 May 2014 14:49:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C563A19B8F;
	Thu, 29 May 2014 14:49:54 -0400 (EDT)
In-Reply-To: <53871B8D.40608@web.de> (Jens Lehmann's message of "Thu, 29 May
	2014 13:35:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0634FD02-E762-11E3-A55C-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250397>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 29.05.2014 04:07, schrieb Jonathan Leonard:
>> The title pretty much says it all.
>
> But you do not give much information about your special use
> case.

Perhaps "git grep insteadOf Documentation/" is all that is needed?
