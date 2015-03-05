From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] GSoC 2015 application
Date: Wed, 04 Mar 2015 17:17:52 -0800
Message-ID: <xmqqr3t45jjz.fsf@gitster.dls.corp.google.com>
References: <20150218191417.GA7767@peff.net> <54E6C78D.3070506@alum.mit.edu>
	<20150220072924.GC8763@peff.net> <vpqpp94exb5.fsf@anie.imag.fr>
	<70A3994196D94205B75660D9DEFF0A12@PhilipOakley>
	<CAGZ79kaNZsBP19gLvsrDx6RLyQ7QhmbKAgSDcXg71Uwcvf9tNQ@mail.gmail.com>
	<75FBE31490904D8EA82F5C445F1F33E1@PhilipOakley>
	<CAPc5daV_igiExbvY1eH0T2SKxgawO86F0eZyoai_QK-dXc5fDg@mail.gmail.com>
	<CAGZ79kZzB8-r2a4VGG23GL1ZqxY7c34391vMwVr09MnCV6Hqcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 02:18:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTKQj-0000oA-JO
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 02:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098AbbCEBRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 20:17:55 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57724 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751258AbbCEBRy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 20:17:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 405583CA10;
	Wed,  4 Mar 2015 20:17:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Jgl7kpeCgmgANCNPRdnOKoCVK1g=; b=QornLe
	uAYtWHaieGIh5zjWyotz9dHJjAYlFOYJvouP2no4V61iA0Tpq61DcLxos0f6gpSc
	3abr3Jo85euLH52+gXAqnb2v2ejnwzEwYxW5nOwUKam4dUgkc7jQk7pdaahfmcSO
	eN0hRoag4IvgJY+fA4jt1AbQcTCFW7k48H5Co=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fkEwBKGZbhyzlL3itqnwORo9hJ/gjwpy
	CQR5hNzc5Vi72viNIXWOmv8FmUN1BU2vyW92d2tAcONojU3QEh6IpdPn75uATgSa
	wShSDv4SX3nj7GUAh73OomPfL9kKvMNoWn6FSjFwrPyauM8WGgXeiv3SN0UoMK8s
	F7r0p9XXr5Q=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 368DB3CA0F;
	Wed,  4 Mar 2015 20:17:54 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9ECBA3CA0C;
	Wed,  4 Mar 2015 20:17:53 -0500 (EST)
In-Reply-To: <CAGZ79kZzB8-r2a4VGG23GL1ZqxY7c34391vMwVr09MnCV6Hqcg@mail.gmail.com>
	(Stefan Beller's message of "Wed, 4 Mar 2015 16:32:05 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 72BB72FE-C2D5-11E4-AEDA-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264806>

Stefan Beller <sbeller@google.com> writes:

> On Wed, Mar 4, 2015 at 4:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> On Wed, Mar 4, 2015 at 4:17 PM, Philip Oakley <philipoakley@iee.org> wrote:
>>>>
>>>>    git clone --since 2.weeks.ago <url>
>>>>    git clone --since v2.10 <url>
>>>
>>> The use of --since instead of --date would be an equally valid way of
>>> spelling the option (coders choice;-)
>>
>> I think it is a demonstration of poor taste. Everywhere else,
>> --since is a way to specify the date, not a revision. Why should
>> this one alone should be different?
>
> I wanted to point out the broader use case than being stylish correct,

OK.

I actually think it is OK to envision that "--since" will be made
appliable to non-dates in the longer term.  The proposal, when dug
into minor detail, may include extending approxidate() to take a
revision name, i.e.

	git log --since=v2.0.0 master

would behave as if

	git log --since=@1401300269 master

because that is the timestamp the v2.0.0 tag carries.

Note that I do not think it is a good idea to rewrite the above to 

	git log v2.0.0..master

at all (hint: think how you would rewrite --until).

As to the shallow-boundary capability implementation, I think what
has been discussed in the thread is basically sound.  Just send the
end-user supplied string ("2.weeks.ago", "v2.10", etc.) over the
wire without interpreting locally, and have the server end apply (an
updated) approxidate() on it, internally compute the exact cut-point
just like "git bundle create" does when it computes the prerequisites,
and use the resulting commits as the shallow boundary.
