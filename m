From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Promoting Git developers
Date: Wed, 11 Mar 2015 13:42:15 -0700
Message-ID: <xmqqfv9b5krc.fsf@gitster.dls.corp.google.com>
References: <CAP8UFD1+rC0FjisSddDcyn1E_75wtBU9pEpUcQX5zNtd4zKYFQ@mail.gmail.com>
	<54FDA6B5.8050505@drmicha.warpmail.net>
	<CAP8UFD0KNbPBB_dOzw_dAj+ws190_cO8g7_jb_V33x1jxgvnqQ@mail.gmail.com>
	<xmqqk2yo22ce.fsf@gitster.dls.corp.google.com>
	<CAP8UFD37v_zOjRkUPLy-ChDs=+NetsDY7Q14-4rYA-WhnTRYyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	David Kastrup <dak@gnu.org>, git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 21:42:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVnSQ-0002Y7-LM
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 21:42:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbbCKUmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 16:42:18 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51324 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751702AbbCKUmR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2015 16:42:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E478A3F0E8;
	Wed, 11 Mar 2015 16:42:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dsesH1fkaYBMQtKGD75tKBChbmw=; b=OLziso
	9t+mqcNc8fYYrhpcAeEDXCbpSZ7dsEXMeYdXL3bRxrvARqUIW4jKnSkmJifSwoh4
	qJZXTzy/ZWov/YB+UsiQ/ARGfHcwGz4UgcJqrt2nqLP1Z+G2OyERpxJxynrUVwVM
	AOg485bmnnTFNTx1ai2gE+VW7I68JzRcCDZxA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A3M7cSDHB8lf2tNL9AS6QpsLhiB/OD2G
	fAnW4fx4hzuJr1rBevR4EOLa9Ze3IvZyfN+qznIXW8gPdrs9MWrlH1jVFYMWC92F
	3+QfNhcrJUeXslKsbXyXxOKj4R0yax6/msEdLE73YKJX1K7yni9uDp1COHRtC/Es
	oot2EvzsFXw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DC82E3F0E7;
	Wed, 11 Mar 2015 16:42:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 493CA3F0E6;
	Wed, 11 Mar 2015 16:42:16 -0400 (EDT)
In-Reply-To: <CAP8UFD37v_zOjRkUPLy-ChDs=+NetsDY7Q14-4rYA-WhnTRYyA@mail.gmail.com>
	(Christian Couder's message of "Wed, 11 Mar 2015 14:53:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1AA38B1A-C82F-11E4-AE74-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265338>

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Mar 10, 2015 at 6:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> I would suspect that those who agree with you would appreciate if
>> you or somebody volunteered to act as our CKDO (chief kudos
>> distribution officer).  I do not think I have enough time to do that
>> well.  One good place to start might be to scan the list and
>> summarize something like the following on weekly or monthly basis,
>> as these are not something you can get by pointing people to "git
>> shortlog" output.
>>
>>  - Those who gave helpful review comments, "how about going this
>>    way" illustration patches, etc.  Bonus points to those who helped
>>    onboarding newcomers.
>>
>>  - Those who asked pertinent questions on common pain points, and
>>    those who answered them helpfully.
>
> Ok, I can start something about this two points every week or every
> few week. It would be best if I could get help from at least one
> person as I think it is a lot of work.

No kidding; even though it may no longer be an impossibly large task
as in the infrationary epoch reported in the Git Traffic, this forum
is still a high traffic place.

> I also appreciate very much that you are willing to improve the
> release notes by adding a summary with people's names.

Just in case you misunderstood, I do not think it is a good idea to
add names to release notes and I will not do so.

I was and am planning add the list of contributors at the end of the
e-mail when the release notes is sent out, i.e. in the "Announce"
message that is sent to the list (and CC'ed to lwn.net).
