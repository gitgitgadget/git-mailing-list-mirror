From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: Add git ignore as builtin
Date: Mon, 17 Nov 2014 13:38:03 -0800
Message-ID: <xmqq8uj9y0ck.fsf@gitster.dls.corp.google.com>
References: <CA+mQAOXPZSv2B8tVfC=4eJ7X_2j8Di4BkuE=z43=U2+VNpdQQg@mail.gmail.com>
	<CA+mQAOU_UnPuSk0f9d1sUnxBj8M4zEX7bwa4Dw_z_PJV3Lp4LA@mail.gmail.com>
	<loom.20141117T010932-213@post.gmane.org>
	<20141117205957.GB15880@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ryan Jacobs <ryan.mjacobs@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 17 22:38:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqTzx-0005PE-E4
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 22:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbaKQViJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 16:38:09 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56366 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751547AbaKQViI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 16:38:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C0C31F78E;
	Mon, 17 Nov 2014 16:38:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MUcOn02ydM15JnTmRmgD/KWrzzo=; b=q6po0H
	33AqFmQl/hdVz5nfEdvLgqraAu3zeFxy/ZtF5kPMXDVj6BEeSnqT8IjGHvL3XohH
	+y64x5SRS31ffr62u6mfyOk0l3DjVC5NImDAiUhQykirtB+KWPYC/uhN2rn82/gX
	q2HGvq57FYeyOXAe9CK0zIqQs3Gp0Gfv+JVdM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hfTjFZxBQbd2EgY9X50mLAQfpIp4kizA
	wn+kWXszldeW01HqK9+UZJHIGueNJobdVtWvKpPjUdO/DOVsPQsB6OOnmnO//lgW
	JlOU+6iq6WZBrTexiUfBiqi2MvZlkBURTb5+yWpzZ+jne/Ji2YbyZkc9aDZ1xC7H
	RdbgjyUpczU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 73AFD1F78D;
	Mon, 17 Nov 2014 16:38:07 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ED7F61F78C;
	Mon, 17 Nov 2014 16:38:06 -0500 (EST)
In-Reply-To: <20141117205957.GB15880@peff.net> (Jeff King's message of "Mon,
	17 Nov 2014 15:59:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 04A7CFD8-6EA2-11E4-AD92-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Nov 17, 2014 at 12:12:25AM +0000, Ryan Jacobs wrote:
>
>> Alberto Fanjul Alonso <albertofanjul <at> gmail.com> writes:
>> 
>> 
>> > git ignore <whatever> adds <whatever> to .git/info/exclude
>> 
>> This should be "git exclude" not "git ignore".
>> Difference between the two: http://stackoverflow.com/questions/10066749/git-
>> excludes-vs-ignores
>
> I am not sure that the name difference is all that meaningful. Yes, we
> call the repo-wide file .git/info/exclude and the in-tree ones
> .gitignore, but I do not know if the distinction is more than historical
> accident.

It is merely a historical accident.
