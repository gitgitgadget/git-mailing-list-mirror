From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/13] remote-hg: general updates
Date: Tue, 02 Apr 2013 13:47:11 -0700
Message-ID: <7v4nfobqy8.fsf@alter.siamese.dyndns.org>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
 <7vip44d7x0.fsf@alter.siamese.dyndns.org>
 <CAMP44s1kMrXBgg8tA+1-OtxHV4cqbQ3NfqpRF6AabDWR7fQvRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 22:47:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN87V-00089F-BJ
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 22:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761060Ab3DBUrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 16:47:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49058 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752642Ab3DBUrX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 16:47:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F23F12101;
	Tue,  2 Apr 2013 20:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LXfIBuDisAPMprtJFpuS7ZrM/6k=; b=NYfbkN
	gmFOAJUXdmqxW42gzdTbrbI9WKGLnnq8J2tXKYaA4LkoYKJqXJTzTjUDcFaWHtEd
	sNBhE5BdJGHgNufzcrwk0Tv7K3QWxARZQBzvj0oLXCbG8dt6iPUdpkCK03er2W8p
	Da4L3mQZzE4Fe/kyuHe7Ztt8TdH3CwbZMh7yc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hyq3SCHZXChJZJ71V+T5MYxr0I7sVp/A
	wHo5dcr4ZB9OY8ozur51BBArF1ZSPCecNbEPcj/gdNJ2/pdmXDL7gpgk+qS2dnaB
	iuwLIqpyZrl6mVEKQ48IbLftpfvReAVcFMjbP83oGYxfxfqVWKJJynsXgqehqxfF
	TH4YG3/+4x0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2785112100;
	Tue,  2 Apr 2013 20:47:23 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 87901120FD; Tue,  2 Apr
 2013 20:47:22 +0000 (UTC)
In-Reply-To: <CAMP44s1kMrXBgg8tA+1-OtxHV4cqbQ3NfqpRF6AabDWR7fQvRQ@mail.gmail.com> (Felipe
 Contreras's message of "Tue, 2 Apr 2013 14:27:38 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 84AAD7AC-9BD6-11E2-8511-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219883>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Tue, Apr 2, 2013 at 1:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>>> Fortunately it seems to be working for the most part, but there are some
>>> considerable issues while pushing branches and tags.
>>
>> Do you have a plan in mind what to do about "some considerable
>> issues"?
>
> Yes, they should be fixed now with this series :) I'm still waiting
> for the people that reported those issues to confirm, but in my tests
> they do work.

Ah, I just misread the original to mean "This fixes pushes but still
has (or even adds new) considerable issues that need to be worked
out", hence my question.

>> I could queue these on 'pu' and do the same, and wait until you say
>> "now it is ready, let's go to 'next'" (and same for 'master').
>
> That might help. However, please drop the patch "don't update
> bookmarks unnecessarily", I did not intend to push that one, and I
> would like the rest of the patches to be tested before pushing that
> one out.

OK, then let's do that.

Thanks.
