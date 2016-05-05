From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 19/19] untracked-cache: config option
Date: Thu, 05 May 2016 15:49:16 -0700
Message-ID: <xmqqk2j886j7.fsf@gitster.mtv.corp.google.com>
References: <1462484831-13643-1-git-send-email-dturner@twopensource.com>
	<1462484831-13643-20-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 00:49:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayS5I-0001vZ-5X
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 00:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757142AbcEEWtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 18:49:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58858 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755447AbcEEWtT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 18:49:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EB53019B16;
	Thu,  5 May 2016 18:49:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RWW/r3zyA/NrGb0a0O3RYTvk6c8=; b=R+VQp8
	pVhjvwRgYEGR+jg78mvLxYq/+IIJUE5eM8i+zdFSNgbkWatNEop9yn8qrKaH3qo9
	uEcq3WzsNa+5ApfGLQKK7AqeSTm0OxQKj9Zctfj47rCzbG4WDcaEWNtbHdGaeTqg
	mLe4DmcgEXxN/CuSHbknRRJMloa1JONJ0GYI0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DgJn4UphDN4iu3xdz1t8YCqd68YKhOd5
	YMOM24Tboa/dbItRABeTAFOHjyqbJCVz6qQiV8r30Wp2XgQsCLeZNlNJZcBP+k9X
	8TCXxfBR6osKR8m7ayLpFNE6LhTe+3RN9QYyj945KFzHxN6GKzdovrQFy2Y5MWKM
	AKfLGf8mV1M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E412519B15;
	Thu,  5 May 2016 18:49:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 70D0E19B14;
	Thu,  5 May 2016 18:49:18 -0400 (EDT)
In-Reply-To: <1462484831-13643-20-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Thu, 5 May 2016 17:47:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 99AA43EC-1313-11E6-853E-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293718>

David Turner <dturner@twopensource.com> writes:

> +	if (!git_config_get_bool("index.adduntrackedcache", &untracked) &&
> +	    untracked &&
> +	    !istate->untracked)
> +	    add_untracked_cache(&the_index);

The body is indented with HT + 4 spaces, replace it with two HTs.
