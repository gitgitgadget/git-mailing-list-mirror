From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] gitolite now supports smart http
Date: Sun, 05 Sep 2010 23:28:01 -0700
Message-ID: <7vy6bfv11q.fsf@alter.siamese.dyndns.org>
References: <AANLkTikKt5srTvn3zh7ZQ54ii=3eDnxAxxy8njtSaz4y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	gitolite <gitolite@googlegroups.com>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 08:28:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsVBg-0001Va-Hs
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 08:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754Ab0IFG2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 02:28:11 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60191 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436Ab0IFG2K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 02:28:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A25DAD3AD8;
	Mon,  6 Sep 2010 02:28:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nqaTTkip0sIx2Y46hNeC4Ub/JiI=; b=P0qbXH
	W67weO41k2D/Tz2h++wJA/jUQDik+0MFduiEm778ZeAuc8Dwv6taQa4VkuoAQtC4
	pJXr77QrHlqHwuWNcb+a+i5fmmn+Nbm3oxEABB+MxBD4d9D2oCl3vkbDi5UKSI9p
	OkAcTFthUKMbIXYTNYVWDupycjWsW5lX9/mGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e2ge5HhK2nv2YeVdJPj4Hr7J9heaOUqz
	94twBBMZU07Fhgfdjg/LT48DmhZOhmsRL01scTWHCxmH0TpotjaVod2jasssr9Lx
	HV2hhB2b72HJ7HshuT1H/5VrJUT4AysrmR++5+Nsnz+8gLVA0pNv9LO1gxendbIY
	B9qVo55whkY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 61EA2D3AD6;
	Mon,  6 Sep 2010 02:28:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ABC01D3AD5; Mon,  6 Sep
 2010 02:28:02 -0400 (EDT)
In-Reply-To: <AANLkTikKt5srTvn3zh7ZQ54ii=3eDnxAxxy8njtSaz4y@mail.gmail.com>
 (Sitaram Chamarty's message of "Sun\, 5 Sep 2010 21\:07\:34 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E8E5416C-B97F-11DF-AFF5-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155535>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> With some caveats and limitations, we now have smart http support in gitolite.
>
> See http://github.com/sitaramc/gitolite/blob/pu/doc/http-backend.mkd
> for all the details.

Nice ;-)
