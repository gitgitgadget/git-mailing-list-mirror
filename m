From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t3010 broken by 2eac2a4
Date: Thu, 22 Aug 2013 14:43:58 -0700
Message-ID: <xmqq38q1qu3l.fsf@gitster.dls.corp.google.com>
References: <82078845-3AB9-4B36-9130-039CC33C8A7A@gernhardtsoftware.com>
	<xmqqbo4qu3g4.fsf@gitster.dls.corp.google.com>
	<CAPig+cQHTvmTWvGfg1Z3KfBrPD+QbSEbYBYz6XWT3KKu3-+jyQ@mail.gmail.com>
	<xmqqbo4pqvde.fsf@gitster.dls.corp.google.com>
	<CAPig+cQmvRDDc3BHbta_UhCQe9QvbtAm0RJgt6HbtgFAKgo0Vg@mail.gmail.com>
	<xmqq7gfdqumd.fsf@gitster.dls.corp.google.com>
	<CAPig+cSEQLk2M+X5QP7mkm846wqqHRCjPHgO7O3URvNcsYO6+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	"git\@vger.kernel.org List" <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Aug 22 23:44:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCcft-0006vZ-0J
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 23:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934Ab3HVVoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Aug 2013 17:44:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46899 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753084Ab3HVVoH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Aug 2013 17:44:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DCE53B6BB;
	Thu, 22 Aug 2013 21:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lOZ51cPCNd/HCkeBF8AeIJBgd6k=; b=REaR5D
	hkINQXFK5sMvx9q1Z1RBMxmB2vaivagFi95pXrZ6rQUTSJXBxY85Ndco3e31czjN
	vAOufzBSC1P7C76g0/yfYY8o/txHJMGexkFLH25ZbfERTCvvvFhNyoN/bLIkZGjy
	JZVEF/FF6dFeNhNCEPXg0BzcGDuNe87qC+rFk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=katwEzEHToxC5/OX3Yt9wvzO0jW6RcHt
	/bv4sTm49m/LOFVF0b6ZeCmKtsuQ+/nkQ+/tVqelkxhrWpMw9BqX9S4v7SRLrp9V
	i3IObO46hgGU37Qk154Oe+Suf3BwBa9l6AKOosquYBsqmvfFxGO/SVgZMAA/tG3r
	R7g3DQUNuZ0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 215C33B6BA;
	Thu, 22 Aug 2013 21:44:06 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 11D8D3B6B4;
	Thu, 22 Aug 2013 21:44:03 +0000 (UTC)
In-Reply-To: <CAPig+cSEQLk2M+X5QP7mkm846wqqHRCjPHgO7O3URvNcsYO6+w@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 22 Aug 2013 17:35:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F6CA2074-0B73-11E3-AAED-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232782>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Aug 22, 2013 at 5:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>
>>> On Thu, Aug 22, 2013 at 5:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>>>
>>>>> I can confirm this failure on OS X, however,...
>>>
>>> Thanks for the explanation.
>>
>> Now, I am curious how it breaks on OS X.
>>
>> My suspition is that "ignore_case" may have something to do with it,
>> but what 2eac2a4c (ls-files -k: a directory only can be killed if
>> the index has a non-directory, 2013-08-15) uses are the bog-standard
>> cache_name_exists() and directory_exists_in_index(), so one of these
>> internal API implementation has trouble on case insensitive
>> filesystems, perhaps?  I dunno.
>
> That's exactly my suspicion at the moment. It's an obvious difference
> between Linux and OS X. I'm just in the process of trying to compare
> between the two platforms.

Or perhaps de->d_type does not exist?  In such a case, we end up
doing get_index_dtype() via get_dtype(), but in this codepath I
suspect that we do not want to.  We are interested in the type of
the entity on the filesystem.
