From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t3010 broken by 2eac2a4
Date: Fri, 23 Aug 2013 10:15:55 -0700
Message-ID: <xmqqk3jcpbuc.fsf@gitster.dls.corp.google.com>
References: <82078845-3AB9-4B36-9130-039CC33C8A7A@gernhardtsoftware.com>
	<xmqqbo4qu3g4.fsf@gitster.dls.corp.google.com>
	<CAPig+cQHTvmTWvGfg1Z3KfBrPD+QbSEbYBYz6XWT3KKu3-+jyQ@mail.gmail.com>
	<xmqqbo4pqvde.fsf@gitster.dls.corp.google.com>
	<CAPig+cQmvRDDc3BHbta_UhCQe9QvbtAm0RJgt6HbtgFAKgo0Vg@mail.gmail.com>
	<xmqq7gfdqumd.fsf@gitster.dls.corp.google.com>
	<CAPig+cSEQLk2M+X5QP7mkm846wqqHRCjPHgO7O3URvNcsYO6+w@mail.gmail.com>
	<xmqq38q1qu3l.fsf@gitster.dls.corp.google.com>
	<CAPig+cSgM-kO0Mk9qbGfLR8DZkYQt60Va4N2wfRBVqmReTPowQ@mail.gmail.com>
	<CAPig+cQ15Qq7pJ0sLmnuQt_EERn9fkzCa-Gr-pb6a_zf1MLcGQ@mail.gmail.com>
	<xmqqwqndpbfc.fsf@gitster.dls.corp.google.com>
	<CAPig+cSqtMOYvxbvXstm9nqQD9sQ378NKCHSK7Ec6GrK5VJiGA@mail.gmail.com>
	<CAPig+cR0Z0gghUH5C6+XCuGQ3gz5JoWrnObVbbA5_ahPmC8G2Q@mail.gmail.com>
	<7vsiy1j7dd.fsf@alter.siamese.dyndns.org>
	<CAPig+cRumXHk-30yvS8Q2xvOxA0qEEXaD7=iJo_X26HL-YRRJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	"git\@vger.kernel.org List" <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Aug 23 19:16:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCuxy-00047W-VS
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 19:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755874Ab3HWRQD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 13:16:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45357 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755810Ab3HWRP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 13:15:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A29E3B617;
	Fri, 23 Aug 2013 17:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U1SINkCt0e2S3yS+HC7vQQzaCvg=; b=waqR+R
	ZXJbJujNoE1IgFUjufPuvWaH83iY5856iNGnGzRHgpmGKpYiJfKeGhw9mAf/kQM1
	/zlqg6HtAnXTjZD8oDa+2bIzTKf+g4q4PAWQ7RrrVRffGFp/AoD1S4gOV6gD+sxa
	J8J2Rj308fgrZ3VFKkrMBNH/o9ptsWcZe1q6w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GWz3puGdv7DwnvjgRbP2CdBzNgIG0mQR
	HowdcgOWkERxHpMDvo7vJZmCQasQdbUt2o8mVDDhxzxx3WTA/g6F9HU8btPpxds/
	YKKhYakyx8fFie0E9AU2gB4vkVav/6BdOpfc/TlmNr1CxoVHfOsuEDfllzOkjVSg
	aK7fSuPxJZY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20C5E3B616;
	Fri, 23 Aug 2013 17:15:58 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 737133B613;
	Fri, 23 Aug 2013 17:15:57 +0000 (UTC)
In-Reply-To: <CAPig+cRumXHk-30yvS8Q2xvOxA0qEEXaD7=iJo_X26HL-YRRJg@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 23 Aug 2013 05:19:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: ACD77C06-0C17-11E3-B656-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232813>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Aug 23, 2013 at 1:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>
>>> I sent a patch [1] which resolves the problem, although the solution
>>> is not especially pretty (due to some ugliness in the existing
>>> implementation).
>>
>> Yeah, thanks.
>>
>> I tend to agree with you that fixing the "icase" callee not to rely
>> on having the trailing slash (which is looking past the end of the
>> given string), instead of working that breakage around on the
>> caller's side like your patch did, would be a better alternative,
>> though.
>
> My concern with fixing directory_exists_in_index_icase() to add the
> '/' itself was that it would have to copy the string to make space for
> the '/', which could be expensive. However, I reworked the code so
> that the existing strbufs now get passed to
> directory_exists_in_index_icase(), which allows it to add its needed
> '/' without duplicating the string. So, the trailing '/' requirement
> of directory_exists_in_index_icase() is now a private implementation
> detail, placing no burden on the caller.

When 5102c617 (Add case insensitivity support for directories when
using git status, 2010-10-03) added the directories to the name-hash
with trailing slash, there was only a single name hash table to
which both real cache entries and leading directory prefixes are
registered, so it made some sense to register them with trailing
slashes so that we can tell what kind of entry is being returned.

But since 2092678c (name-hash.c: fix endless loop with
core.ignorecase=true, 2013-02-28), these directory entries that are
not the cache entries are kept track of in a separate hashtable,
which makes me wonder if it still makes sense to register
directories with trailing slashes.

And if we stop doing that (and instead if we shrunk the namelen when
an unconverted caller asks for a name with a trailing slash to see
if a directory exists in the index), wouldn't it automatically fix
the directory_exists_in_index_icase()?  It does not need to assume
that dirname[len] has '/'; after all, it may not even be a valid
memory location in the first place.
