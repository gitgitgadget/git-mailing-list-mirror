From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] remote.c: provide per-branch pushremote name
Date: Tue, 31 Mar 2015 14:41:15 -0700
Message-ID: <xmqqfv8kq1z8.fsf@gitster.dls.corp.google.com>
References: <20150331173339.GA17732@peff.net>
	<20150331173727.GD18912@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 31 23:41:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd3uY-0007Zr-25
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 23:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753277AbbCaVlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 17:41:21 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60288 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752085AbbCaVlS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 17:41:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A0B8145C60;
	Tue, 31 Mar 2015 17:41:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DvkPJ4LAkv9VS0Ra6wbHJuK8rGQ=; b=OTiD6Y
	RcTALqDgb5VZnGmwEADcYqAIENzAYoVEv0RJvDSs7bFYEl5HyfJ1Sez8bvC4cqbJ
	wU3h/Mph2VnBp3AZeX7N96DQmWYblTsJRzAVMnDwwI2YtkLWvD6gvvA05JK4Jj7Q
	jsDhYil5z5dsCbobS0pn8TRo3aOxZdVyosBuI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yXq78nCnHZdYkbHb8dtJ4SNSMgqoaQBp
	ULzrOL6/wTfHRYMaAba0xrs+SlTac/uwxhGONCdCWD8UF/3LrO33VMwx4+PlgVOm
	fuR6YIxO+7qW5MJsbM1+94Eft8iUlDgpVEyOgMWRd+ZqcqCNXw/bOVCL+DPEbWY5
	rvd+QBVMwxw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9935B45C5F;
	Tue, 31 Mar 2015 17:41:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 22DB145C5E;
	Tue, 31 Mar 2015 17:41:17 -0400 (EDT)
In-Reply-To: <20150331173727.GD18912@peff.net> (Jeff King's message of "Tue,
	31 Mar 2015 13:37:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A95C8E82-D7EE-11E4-BC84-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266560>

Jeff King <peff@peff.net> writes:

> Let's make this more like the fetch-remote config. We'll
> record the pushremote for each branch, and then explicitly
> compute the correct remote for the current branch at the
> time of reading.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  remote.c | 41 +++++++++++++++++++++++------------------
>  remote.h |  2 ++
>  2 files changed, 25 insertions(+), 18 deletions(-)

Very nicely done.  Thanks.
