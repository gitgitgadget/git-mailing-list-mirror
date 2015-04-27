From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update git-multimail to version 1.0.2
Date: Mon, 27 Apr 2015 12:05:54 -0700
Message-ID: <xmqqfv7lwfvx.fsf@gitster.dls.corp.google.com>
References: <1430133445-21488-1-git-send-email-mhagger@alum.mit.edu>
	<xmqq618hxxya.fsf@gitster.dls.corp.google.com>
	<vpq383ltoxi.fsf@anie.imag.fr>
	<xmqqoam9whs0.fsf@gitster.dls.corp.google.com>
	<vpqh9s1s9by.fsf@anie.imag.fr>
	<xmqqk2wxwgv1.fsf@gitster.dls.corp.google.com>
	<vpq618hqu5d.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 27 21:06:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmoM8-0003lw-2n
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 21:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbbD0TGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 15:06:00 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64239 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932946AbbD0TF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 15:05:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D4F8A4BC07;
	Mon, 27 Apr 2015 15:05:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O4u7ccEXj4lx5ghyHAPEWhGAv3M=; b=V20LFE
	yDRRvCF2SotMl4xscmD4g+qdV0vsGbAZtsDaOpei2RMMNhBtbgjl9Z/ukd03gNS2
	BmqFOgtGyyCrCZdbh0D7wKFZJPIeqdAMD52a5RPwjDSzG3dpgNG+PWwzrhmQ0Ffy
	VpPySaUxaNNfQxm4h4qq1la+dI1VnWhz78Kgk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X+YSca3rYtYrMBwlrCQlSFAqdY/KlQLK
	o8W0fLvdZxOKMIohlGBATlSxBdYl8jrpoXZNVRfTiDmk47hfI8Blk3XD5YzWGQNP
	GsMJhNPtgGP1Op8pzqHlgmxVH4VA8npC//ttCFUIEOqFK3e8EfQpYrcL3BXXwwMt
	amaAvnb4RQI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CCB174BC06;
	Mon, 27 Apr 2015 15:05:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 418764BC05;
	Mon, 27 Apr 2015 15:05:55 -0400 (EDT)
In-Reply-To: <vpq618hqu5d.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	27 Apr 2015 20:54:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6E4C1312-ED10-11E4-ACFC-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267873>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> Was that obtained from the upstream project (i.e. you) and match
>>>> your 1.0.2 tag?
>>>
>>> Yes. Isn't that what the text above says?
>>
>> Well, the patch does not update git_multimail.py at all.  Requoting
>> the part you omitted from my response
>>
>>     $ git rev-list -1 master contrib/hooks/multimail/
>>     b513f71f6043c05c3918e670b332dfa7ec6b2661
>>
>>     which is b513f71f (git-multimail: update to version 1.0.0,
>>     2014-04-07)
>>
>> it matches what "was obtained from the upstream project on
>> 2014-04-07".
>
> Yes, but it also matches "was obtained on 2015-04-27", since only the
> README has changed (the commit message of this patch says: "The only
> changes are to the README files, most notably the list of maintainers
> and the project URL.").
>
>> Or did you forget to include the update to the software in the
>> patch?
>
> The update to the software is empty.

Hmm, that may be technically correct but it is grossly misleading to
update the existing "was obtained on 2014-04-07" to "was obtained on
2015-04-27", especially if nothing was actually obtained, isn't it?
I honestly am surprised that, after seeing the announcement about "a
new repository, co-maintainer and multiple contributors", no code
change is made over the past 12 months.

I would understand it if the description were "The version in this
directory matches the upstream project as of 2015-04-27", though.
