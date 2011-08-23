From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: Grammar correction, wording fixes and
 cleanup
Date: Tue, 23 Aug 2011 14:48:08 -0700
Message-ID: <7vliujre93.fsf@alter.siamese.dyndns.org>
References: <7vk4a5wc67.fsf@alter.siamese.dyndns.org>
 <1314060519-24035-1-git-send-email-bwalton@artsci.utoronto.ca>
 <1314134106.5186.64.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Tue Aug 23 23:48:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvypU-0004D0-Bn
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 23:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754745Ab1HWVsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 17:48:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55416 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752730Ab1HWVsK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 17:48:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4756C4A80;
	Tue, 23 Aug 2011 17:48:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pJaVzRo6PgHBCqTYjwouSf82Gos=; b=dJV0Tz
	eUwecKeYLhcpmhDT9AbMR9AvCZOtGN+aGoWi1x0RYu4qxc475LQdfn5MOqbTJ5DH
	OLH8BnjmncaZeQIS3rQG7DaOX5zJEY76lXFE0B53o0hxOe+dop3dLazXCHuq7m4u
	46DQWaWeutmbr2smn1Q78OYhJaFFzLQI0az6w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uVw4aLuTvwsNbsYWe9LBmwVl0vKWAg58
	+N62gVg51O7Tpmci0KYQAEqAOFtiOw3PBHUywZe8LtRnEeRZ7qj3g521Bk5dCf2t
	DJ9a2tM8kAGYKqQ7tgdQM/dx3Yc3wb1mu6aDy+BEwQ7Mrtn+4co2rCuzgJPT+Pm8
	ryQlTGGm2f4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FC7B4A7F;
	Tue, 23 Aug 2011 17:48:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B305E4A7E; Tue, 23 Aug 2011
 17:48:09 -0400 (EDT)
In-Reply-To: <1314134106.5186.64.camel@drew-northup.unet.maine.edu> (Drew
 Northup's message of "Tue, 23 Aug 2011 17:15:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 97A94EDA-CDD1-11E0-9818-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179974>

Drew Northup <drew.northup@maine.edu> writes:

> On Mon, 2011-08-22 at 20:48 -0400, Ben Walton wrote:
>
>> +. You could be using the `objects/info/alternates` or
>> +`$GIT_ALTERNATE_OBJECT_DIRECTORIES` mechanisms to 'borrow'
>>  objects from other object stores.  A repository with this kind
>>  of incomplete object store is not suitable to be published for
>> -use with dumb transports but otherwise is OK as long as
>> -`objects/info/alternates` points at the right object stores
>> -it borrows from.
>> +use with dumb transports but is otherwise OK as long as
>> +`objects/info/alternates` points to object stores containing the
>> +missing objects.
>
> Umm, I'm not prepared to call this an improvement. The objects aren't
> _missing_, they just aren't present in the most immediate object store.
> I'm a minimalist when it comes to this sort of edit and would have just
> excised the word "right" from the awkward segment.

Yeah, "points at the object stores it borrows objects from" sounds
readable and technically correct.
