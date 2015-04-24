From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] status: document the -v/--verbose option
Date: Thu, 23 Apr 2015 18:44:58 -0700
Message-ID: <xmqq4mo62tb9.fsf@gitster.dls.corp.google.com>
References: <CAM=ud8zLDTYUp12BsVjWH5=8rg=HxbtdBxL2L9x=3+FQVJBqrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Pete Harlan <pchpublic88@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 03:45:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlSg8-0007gd-NS
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 03:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886AbbDXBpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2015 21:45:00 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62937 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751876AbbDXBpA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2015 21:45:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B3D344C635;
	Thu, 23 Apr 2015 21:44:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a+szy0zXvwAVZkbulX32fWL2sxs=; b=UsNY+a
	39AoZyLhTKkZD3k/naw8QQ+WUmfyzOVyVGaFjBDHvq12iD9APlwaDEDSPp8i6RK4
	4em1Y5ffauTV8GbkBWo9QQ03WNv81rKO4eXlZUH7eEkagq9aHfnRaxs2L/Bjem67
	8LLw0Yc0nn3n4DGTLBD2zFRARy9OmnLi2NRAM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v3ZQL/N1CrV5mH1DWXFaEpQF9vSxcF0P
	7FURCkh2ZR1Ve6xdcvzQ9kZTYiMuf/p/Kr6kW9xnAZAncVxBrJR/xdBuXIJGiHiS
	NpFCuEQDg48WufZ9MbsXvEEdeURJCBQHxYxFMhhFO3D4Tj5QHn3OD8cmepIGUnxN
	KT0TTib6gvo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ACFA24C634;
	Thu, 23 Apr 2015 21:44:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 320684C632;
	Thu, 23 Apr 2015 21:44:59 -0400 (EDT)
In-Reply-To: <CAM=ud8zLDTYUp12BsVjWH5=8rg=HxbtdBxL2L9x=3+FQVJBqrQ@mail.gmail.com>
	(Pete Harlan's message of "Thu, 23 Apr 2015 17:27:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 844AB46A-EA23-11E4-848D-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267718>

Pete Harlan <pchpublic88@gmail.com> writes:

> Junio writes:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>
>> > Document `git status -v`, including its new doubled `-vv` form.
>> >
>> > Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> >---
>>
>> Will queue on mg/status-v-v series, which did add description for
>> "commit -v", but "status -v" did not have the description to begin
>> with and we missed it.
> [...]
>> > +-v::
>> > +--verbose::
>> > + In addition to the names of files that have been changed, also
>> > + show the textual changes that are staged to be committed
>> > + (i.e., like the output of `git diff`). If `-v` is specified
>
> Should this be `git diff --cached`?
>
>> > + twice, then also show the changes in the working tree that
>> > + have not yet been staged (i.e., like the output of `git diff
>> > + --cached`).
>
> ...and should this just be `git diff`?
>
> --Pete
>
> (Sorry for not replying to the email; bit of a mess here in my setup.)

Duh!

I see "git commit" documentation does not have these extra "like the
output of..." bits.  Perhaps we can do without it for the sake of
both brevity and risk avoidance?

Will push out with --cached bit swapped for tonight on 'pu'.
