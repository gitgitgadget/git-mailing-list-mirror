From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/3] t0302: test credential-store support for XDG_CONFIG_HOME
Date: Wed, 25 Mar 2015 09:17:34 -0700
Message-ID: <xmqqwq252grl.fsf@gitster.dls.corp.google.com>
References: <1427174429-5876-1-git-send-email-pyokagan@gmail.com>
	<1427174429-5876-3-git-send-email-pyokagan@gmail.com>
	<vpqbnjivi2n.fsf@anie.imag.fr>
	<CAPig+cQ-yLnjrsB1E-7=UXfGzuJHat6YtfS8EVRNP2dcjj_6TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 17:17:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yanzz-0006d2-Ac
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 17:17:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300AbbCYQRj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 12:17:39 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56854 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751593AbbCYQRh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 12:17:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EBFFE4126A;
	Wed, 25 Mar 2015 12:17:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nJqVXs9DC4Zlj6/I4S8RPzx01U8=; b=CT1LVM
	a9npuvx0uYuZhYyojlCnJyROxOmFiQu+j28yFrgvsE7IxCDInAJ8Hg6sk/Ne3uc/
	p7U3kXm+eFgM/nGizDcbvL1vFrYBCmqaTYBwU3jCfpFiRkeCK38KsYYiTSqLJHd7
	PVNdCA+5QI4xvXp56sX+FJNMOZD6AhPQ1BRmY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c5w/6Po1n4CCq/dE193o0fAfWTdTb3jV
	XOH8OjIE4tthpoLwdZ/JmGvQxngzp+Cihqqq5GzsqB7WcEykGSPLpxZ7bSMUIO/d
	VLuvsJStxJvbqc+by6snngcXRZyXGcfX2IIIb6YVGMhULgFTkd/eD0WcBLafuVFW
	3RWWVP/JdPs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E4D8741269;
	Wed, 25 Mar 2015 12:17:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1EBC641267;
	Wed, 25 Mar 2015 12:17:36 -0400 (EDT)
In-Reply-To: <CAPig+cQ-yLnjrsB1E-7=UXfGzuJHat6YtfS8EVRNP2dcjj_6TA@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 25 Mar 2015 02:54:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 730E7568-D30A-11E4-A551-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266283>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Mar 24, 2015 at 5:52 AM, Matthieu Moy
> ...
>> Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>
> With the POSIXPERM issue[1] addressed (if necessary), patch 3/3 is also:
>
> Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

THanks for a review.  Paul, the 3-patch series is already in 'next',
so please fix these up with a follow-up patch.

Thanks.
