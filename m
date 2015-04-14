From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git + SFC Status Update
Date: Tue, 14 Apr 2015 12:30:23 -0700
Message-ID: <xmqq7fte33u8.fsf@gitster.dls.corp.google.com>
References: <20150413115613.GA4589@peff.net>
	<CAD0k6qT9Sj4VQ+4PKvXmwwfuZHFoGXNmAMGxTiorx81E0U11xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 21:30:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yi6XX-0007FD-Hd
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 21:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854AbbDNTa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 15:30:27 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52605 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751761AbbDNTaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 15:30:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C74DE496A9;
	Tue, 14 Apr 2015 15:30:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rYvc4rrgrbCRJQZDWJRbN3fHnwo=; b=nuWdhZ
	xoge73Jl8CgER6tettPMH5VptonDFdqtj7GmYhbgqumo7C8hphz5JKHpKpw/mLz6
	QK2mwlW/MccRtYfCs+I3fcqE1cMpfO3niCCILNkBjM3qaiB255c51k7i4d6ynE8C
	lSxXKOD3+mo5oXDr2qdW8B6baxZ8vZ43082n4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pbq0DAIcoeNL2neXlCWxtba/Q/5JA2M0
	BlHas114TzQIVnKhj7Z45vQNBvgcImX/b77aDeKp9tb1ht5qannhSG6QyD2kDKeN
	5XRCjSWhmlvhoThhhupCLMLGuX1MtjyT93Zm7A986g6omZfP6rgSb7slYNzgwXuP
	ghORa8l3xIU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C0806496A8;
	Tue, 14 Apr 2015 15:30:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4812A496A7;
	Tue, 14 Apr 2015 15:30:24 -0400 (EDT)
In-Reply-To: <CAD0k6qT9Sj4VQ+4PKvXmwwfuZHFoGXNmAMGxTiorx81E0U11xg@mail.gmail.com>
	(Dave Borowitz's message of "Tue, 14 Apr 2015 15:00:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B27B866E-E2DC-11E4-9799-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267158>

Dave Borowitz <dborowitz@google.com> writes:

> On Mon, Apr 13, 2015 at 7:56 AM, Jeff King <peff@peff.net> wrote:
>> # Money: How much do we have?
>>
>>  - $19,059.25 (USD)
>>
>> // Disclaimer: this is not necessarily up-to-the-minute, as
>> // SFC's reports to us sometimes lag a bit. And also because
>> // I am fairly inexperienced using the `ledger` program, so
>> // it's possible I've misinterpreted the results. However, we
>> // shouldn't have any serious outstanding expenses, so this
>> // is close to correct.
>
> If I recall correctly, Scott said onstage that some/all of the
> conference proceeds would be going directly into this fund. So this
> might need to be revised upward by 50-100% sometime soon :)

I think you misheard it.  The above is money earmarked for Git at
SFC; the admission for GitMerge were going to SFC general fund
without earmarked for us, IIUC.
