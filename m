From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Thu, 08 May 2014 15:22:04 -0700
Message-ID: <xmqqppjn29o3.fsf@gitster.dls.corp.google.com>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
	<xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com>
	<xmqqha515ebt.fsf@gitster.dls.corp.google.com>
	<536adf96f37ec_3caaa612ec69@nysa.notmuch>
	<xmqqtx902k45.fsf@gitster.dls.corp.google.com>
	<536be16ba5ef1_3ce710a12ecdb@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 00:25:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiWl2-0004gu-Ly
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 00:25:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbaEHWZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 18:25:33 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64567 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932203AbaEHWZa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 18:25:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5444915723;
	Thu,  8 May 2014 18:25:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NX7nAMAtpfJOYTk2XOnNwWrX5JU=; b=gTH5Jr
	PJbQflRaWDSMj56b7oulgi4OTY3pOEtLFjyc0HJ3ScjK47qz4BO7zpErP70KzIyw
	GAxCaV/HOx6ySR0ycA1Rppa4xOhxarT0yk+1VgN7qhgRl+puFYSKYSD45vFyf0Lk
	JFanWb3OwqcNw3kwf30GenMIzHzP1mdsHLuGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mp7GAKBw0YaknWXPJI+LLMstAM2FSh8e
	31DTTCch++MaHu6tB6GS3kR6HjJwWVivCqXunZmOeLQDgPix4p+ZPezQImpb77cu
	Ua5Db22IfJeZRh1FmaAZhOX6zpqtLGqZUEjw4YJiqBbsQXjaZHNXDQJc9j5XrfBE
	dN4h5gB4mBA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 49E9215722;
	Thu,  8 May 2014 18:25:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5E6EF1567E;
	Thu,  8 May 2014 18:22:06 -0400 (EDT)
In-Reply-To: <536be16ba5ef1_3ce710a12ecdb@nysa.notmuch> (Felipe Contreras's
	message of "Thu, 08 May 2014 14:56:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3024C14C-D6FF-11E3-B814-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248457>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> In other words, I knew that you are capable enough to track down a
>> bug in the code you wrote recently that made it violate the
>> expectation you defined in your own tests.
>
> Wrong. The code in question was not recent, it was introdued in 1.8.3,
> more than one year ago.
>
> And wrong, it didn't violate the expectation of my own tests.
>
> The code was simply not exercised in the tests.
>
>> There was no room for differences of opinions to come into play, as it
>> was just between you and your own code.

OK, I misread the blame output---sorry about that.

But that does not change the fact that your tests caught a bug in
your own code, and the issue was solely between you and your own
code without involving criticism from anybody, does it?

Unless you count a barf from a rather old version of Mercurial as a
criticism, that is.

>> Why would I expect otherwise?
>>
> Because most people take attacks on their code as personal attacks, and
> they don't fix bugs in their code if they don't like the person
> reporting it.
>
> But you know I don't take attacks on my code and ideas personally, which
> is more that can be said of most people on the list.

Just to make sure new people who may be watching with popcorns in
their hand from sidelines do not get a wrong impression, I do not
share your "most people take attacks ..." observation.

In reviews I have seen over the years around here (and also reviews
at $DAYJOB), I rarely saw such a reaction by the person whose change
is reviewed.  I view this list as very cooperative and productive
environment most of the time.

In any case, there was not even any attack---it was merely your code
not passing your own test on a platform you did not have access to,
which is not something to be upset about.

> I don't want to do anything for a "contrib" tool.
>
> It's already broken in v2.0 anyway.

Yes, this is not even an old regression.  If you no longer want to
have it in contrib/, I can drop it in future releases (but not in
v2.0), so that people can find the latest and greatest directly from
you.  Otherwise, queuing a fix on 'pu' and then to 'next' in
preparation for an early graduation for the release after v2.0 (and
as a fix, it may want to go to older maintenance releases) is also
fine by me.
