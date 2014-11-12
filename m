From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: add some crossrefs between manual pages
Date: Wed, 12 Nov 2014 13:07:13 -0800
Message-ID: <xmqq7fz03z7i.fsf@gitster.dls.corp.google.com>
References: <1415737027-44589-1-git-send-email-max@quendi.de>
	<xmqqppct5p1q.fsf@gitster.dls.corp.google.com>
	<96693472-344E-4ED3-B027-49A8303AF8C0@quendi.de>
	<xmqqbnoc3zli.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, spearce@spearce.org, jrnieder@gmail.com
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Wed Nov 12 22:07:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xof8v-0000Tq-WB
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 22:07:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364AbaKLVHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 16:07:54 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63534 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753309AbaKLVHx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 16:07:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 69E581D489;
	Wed, 12 Nov 2014 16:07:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pQPMteD46lNTJCyRtbQVgDLE7Wg=; b=IFu7Je
	DvbhKYYCWLw00brSaIX0QHSVZFBUsFcGLWqO68g1tM+NcXGqccRf067e4C1QOOmv
	//7eHcxAV+jK728bbgD/IbqTtuYKWfwx2PWWyP2j1sXwcJH0/WAML/dIUE9dbSd2
	3/INOle+a0YmQio1Tri8bCtgbFZD8YPOlW3gQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wkjs2M/53HzjQL8m8DvgN5yaVTFBHXdl
	vWOMeMC2Cw9EeEERD8bopoynK+UyF0xzycwzL6HXkQ5elcWb5c5fiG4uNHotfH/R
	hXA/w7srLGIen3yEmkNGO3t+z7Km2KeVMdXZic1frSOaUzSWznJ/oxKc3QwCg8Pm
	CNt8Q7VHxPM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6169E1D488;
	Wed, 12 Nov 2014 16:07:51 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D4B621D44A;
	Wed, 12 Nov 2014 16:07:14 -0500 (EST)
In-Reply-To: <xmqqbnoc3zli.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 12 Nov 2014 12:58:49 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E0A6EB96-6AAF-11E4-9ED1-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Max Horn <max@quendi.de> writes:
>
>> On 11.11.2014, at 23:51, Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>>>> +linkgit:git-fast-import[1]
>>> 
>>> This looks somewhat out of place; fast-import is not the only or
>>> even the primary way to do a remote-helper, is it?
>>
>> It depends on how you look at it, I'd say. If you write a remote-helper that
>> uses the import/export feature, it is absolutely vital.  All remote helpers
>> I ever worked on are of that kind, so to me it is the primary way ;-),
>> although of course I realize there are others. So, how would you determine
>> which of the various methods is the "primary" one?
>
> You don't.  If there exists no clear "primary" one, you do not have
> to designate a random one as the "primary".
>
> I just thought that these references are to related/relevant pages
> in the same family of commands, and not a place to list possible
> implementation technologies.  We do not say "see also libcurl" only
> because we have the curl-based remote helper that almost everybody
> uses to interact with other repositories over https:// URLs here,
> and do not list send-pack or receive-pack, even though the pair
> would be a natural way to implement 'fetch' and 'push' methods to a
> helper to interact with a native Git repository, either.

Sorry, the final paragraph did not make it for some reason, which
read like this:

    Having said that, we do seem to refer to fast-import quite
    extensively in the text of this manual page, so I think it is good
    to have a reference to its documentation at the bottom.

So I am OK to special case fast-import and single it out as a
notable implementation technology, which is what your patch does.

Thanks.
