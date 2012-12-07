From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Improve remote helper documentation
Date: Fri, 07 Dec 2012 13:52:07 -0800
Message-ID: <7vehj1fs3c.fsf@alter.siamese.dyndns.org>
References: <1354038279-76475-1-git-send-email-max@quendi.de>
 <7v1uf1he6m.fsf@alter.siamese.dyndns.org>
 <A6FF9929-74F8-4F2F-BA0B-1B1086D4E7F5@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Fri Dec 07 22:52:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Th5qO-0000oz-6O
	for gcvg-git-2@plane.gmane.org; Fri, 07 Dec 2012 22:52:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755191Ab2LGVwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2012 16:52:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34623 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752543Ab2LGVwK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2012 16:52:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB30EACDB;
	Fri,  7 Dec 2012 16:52:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dHZLVi2lQlBxtBoDL+NKJMm8TNs=; b=xFrQoX
	pA4DBV7el5qzqJ3QC63zn5kJD+gGt6Lm7mqQeA6kfxGOs7dLl0XMAGND3OVzQ3qz
	S5gQE6QDsnniKCPJmlWybOllB0ufWPlPuo6OX8kbvHks6AzYGG/A7Kiko4Y2eGjN
	tao1R4NHiYefhlp/J07c+3cEUVhhm+jKQ+8LM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ovGyo0UILNUNe9XhLnaKgjOT3lXOdU/X
	j6lm55nB+E0IpZFnOXiam+avvKDhz5+lUCu/VOUl1m+BzMhJevZOESiFfx0aHPKn
	gBs6C7lbjI6rCxouJV4gdfMGf3L1yYkbhW3N5rI5AkGX3FPW22Xr62LaHu7WmTfk
	2RcbsSh+x38=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A854FACDA;
	Fri,  7 Dec 2012 16:52:09 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 248D4ACD9; Fri,  7 Dec 2012
 16:52:09 -0500 (EST)
In-Reply-To: <A6FF9929-74F8-4F2F-BA0B-1B1086D4E7F5@quendi.de> (Max Horn's
 message of "Fri, 7 Dec 2012 22:41:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 595733B2-40B8-11E2-9431-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211197>

Max Horn <max@quendi.de> writes:

> On 07.12.2012, at 20:09, Junio C Hamano wrote:
>
>> Except for a minor nit in 6/6; I think "defined options" should be
>> "defined attributes".
>> 
>>    --- a/Documentation/git-remote-helpers.txt
>>    +++ b/Documentation/git-remote-helpers.txt
>>    @@ -227,6 +227,8 @@ Support for this command is mandatory.
>>            the name; unrecognized attributes are ignored. The list ends
>>            with a blank line.
>>     +
>>    +See REF LIST ATTRIBUTES for a list of currently defined options.
>>    ++
>
> Indeed, my mistake. Dumb question since I am still not completely
> familiar with the procedures here: Would you just fix this
> yourself as you apply this, or is it better (or even required)
> that I reroll for this? (Of course if I ned to re-roll for other
> reasons, I'd fix this one as well).

I didn't see any other issues myself, and I didn't see anybody
raising issues on the series, either, so I could fix it up by
amending what is already queued, as long as you are OK with it.

Thanks.
