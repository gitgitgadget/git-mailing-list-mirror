From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] Spaces not allowed in directory names in .git/info/attributes
Date: Wed, 25 May 2016 14:56:36 -0700
Message-ID: <xmqqmvndztrf.fsf@gitster.mtv.corp.google.com>
References: <CAO8RVveOwrS6+pTnHY36d1Nk_B_VJD022W9i8STnNb-KyMkqNg@mail.gmail.com>
	<xmqqmvng8qle.fsf@gitster.mtv.corp.google.com>
	<CACsJy8DXW-K-iNO65yuzMLPZS_8+R1gsQgNftwei1XUZNxhicg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Nathan Collins <nathan.collins@gmail.com>,
	git <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 25 23:56:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5gnE-0006NW-Bj
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 23:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbcEYV4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 17:56:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59107 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750732AbcEYV4k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 17:56:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A5D0C1EC11;
	Wed, 25 May 2016 17:56:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/69bm3opAK680/rrCcs5ebgTy30=; b=UrcFsh
	1XGFcCjEZzca3UYDcW1pRgwmNPk2zZ9nR4gFhfuoaUmicd9dVTVy0y/AO3GOBKFc
	o2nSsmnox65CM5Rfs/RH8vMjT4NdCDzkdP7BklbcwhqN0CayV7kP+q8vo+27vhfX
	nUMul6t+YgfjdjuH3hKyxuhR17HsiMwqZF5As=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Eow1TmOVIhIQb8BRg2qI96Ft/pBzpXr2
	JA2aV0phRngLw9mqLLdjkBMLgslqxs4hy4Iuc12+qMN5LE2sylltjpWW9m8PMjn7
	ywgzD9vw/g8xaXThvWZpvXZMthokRS64NW59P6fJXvbDWORAI0C3rBp13tvfg1jG
	qdy8HeVOdR4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E57F1EC10;
	Wed, 25 May 2016 17:56:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2394B1EC0F;
	Wed, 25 May 2016 17:56:38 -0400 (EDT)
In-Reply-To: <CACsJy8DXW-K-iNO65yuzMLPZS_8+R1gsQgNftwei1XUZNxhicg@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 24 May 2016 08:37:33 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8E3B898E-22C3-11E6-8C6E-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295592>

Duy Nguyen <pclouds@gmail.com> writes:

> Maybe bring back [1] (cquoting paths) and optionally optionally with
> backslash escaping? The conclusion at the end of that thread seems to
> be "ok, we may break rare setups, we just need to be upfront about
> it". Another option is the pathspec way: match quotes literally as
> well.
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/160597/focus=160720

I coaxed the ancient patch that was done in the 1.7.2 timeperiod and
will push out the result near the tip of jc/attr topic that has been
cooking in 'pu'.

Thanks.
