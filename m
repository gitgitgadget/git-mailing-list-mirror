From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] RelNotes: wordsmithing
Date: Thu, 23 Apr 2015 08:38:18 -0700
Message-ID: <xmqq618mdfdh.fsf@gitster.dls.corp.google.com>
References: <1429792070-22991-1-git-send-email-mhagger@alum.mit.edu>
	<1429792070-22991-6-git-send-email-mhagger@alum.mit.edu>
	<5538E9F3.7040702@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Apr 23 17:38:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlJCs-0002p1-Np
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 17:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966153AbbDWPiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2015 11:38:22 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63609 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965690AbbDWPiV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2015 11:38:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 65F214B644;
	Thu, 23 Apr 2015 11:38:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9d1Fks7DWxOV2Oy51E/7WctJ42c=; b=qv0Acd
	034w9pNW5MqhS+NKpM9TyJqLrF44i52KMLjbZiSn4BfSq4+QOAHXyVkO8VAUB6A6
	bvDlOO5ZcG4L0hmAK/5qsEcvDfj9JHaiqgAYCnc3W8YRCyDcCPHvxLe/EkPqfSRQ
	eBLzqAwXVjsQ+hfr2UpTPgj2eeFzqFAJZG6W8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w9jDxqDDvYVR0ZOMBUawNRWU54bLeXti
	oqdyvMJKnIIt4Sebv1+M4KAW+J8bq7iUaYiGhwzO5XjvU+kSnS15uJ1rs0LLl/QU
	b+Y7Bd+R9HQR2/pYu2wZPXPJBSLzYhlavZsFvzqMozi2gMcmP64DGZIuW13cY+kn
	rjscZbiJDfc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F3404B643;
	Thu, 23 Apr 2015 11:38:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DD9944B642;
	Thu, 23 Apr 2015 11:38:19 -0400 (EDT)
In-Reply-To: <5538E9F3.7040702@alum.mit.edu> (Michael Haggerty's message of
	"Thu, 23 Apr 2015 14:47:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C49E6426-E9CE-11E4-A26D-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267693>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 04/23/2015 02:27 PM, Michael Haggerty wrote:
>> Make many textual tweaks to the 2.4.0 release notes.
>> 
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  Documentation/RelNotes/2.4.0.txt | 336 ++++++++++++++++++++-------------------
>>  1 file changed, 172 insertions(+), 164 deletions(-)
>> 
>> diff --git a/Documentation/RelNotes/2.4.0.txt b/Documentation/RelNotes/2.4.0.txt
>> index 7b23ca3..cde64be 100644
>> --- a/Documentation/RelNotes/2.4.0.txt
>> +++ b/Documentation/RelNotes/2.4.0.txt
>> [...]
>
> Oh, I just noticed that many of the same blurbs appear in the release
> notes for the maintenance versions. Once there is agreement on how many
> of the changes to accept, the analogous changes should probably be made
> in those other files.

Thanks.

FYI, these days the same text appears in

 (1) the topic description in "What's cooking";
 (2) the merge commit for the topic when it is merged to 'next';
 (3) the merge commit for the topic when it is merged to 'master';
 (4) Release notes for the 'master' and 'maint', when it is merged.

So the best time to catch mistakes and to rephrase it is when you
see something questionable in "What's cooking", ideally before it
hits 'next', before it hits 'master'.
