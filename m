From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2016, #08; Fri, 29)
Date: Mon, 02 May 2016 10:21:10 -0700
Message-ID: <xmqqshy0v0jd.fsf@gitster.mtv.corp.google.com>
References: <xmqq37q4vzp1.fsf@gitster.mtv.corp.google.com>
	<20160430004741.GA16900@yexl-desktop>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ye Xiaolong <xiaolong.ye@intel.com>
X-From: git-owner@vger.kernel.org Mon May 02 19:21:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axHX5-0007Qg-Sj
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 19:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754465AbcEBRVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 13:21:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58749 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754224AbcEBRVP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 13:21:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 811C4188AB;
	Mon,  2 May 2016 13:21:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P28uyX3cCHLLtaW67WEomhgEcCE=; b=IFUH7r
	HHsybgTFI4Xz1mFEtrfTKOWQEqgrRJT1iBBTHVUvXOflBz34NxVOEbYp9lXAgaj2
	h08rG3Fq8C96mivdGMmdfiRc+5aRlJRUeLFAx91RP67yV6oveRkJ2QFYfmVuUkni
	e2vnafcsavYN3Xqj6SZ5l0SlV1JHEjL23nVLk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K/ABgWAtBoleIPolVD+yD7/4a6WFLYEn
	jejo1wnwj4nhMnVXhnbJRzHwLeXk8v108hFBJ1/MHIStMDrrvxhx3oG+eW9ZlwrO
	aPC9XLaKLQh8xXcdqvtdEClIgwvfjzbfRt2kyTdv8FSkWNdzTf/pnnSRJ3fuBAEM
	cpgkOw4lUmo=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 77EC1188AA;
	Mon,  2 May 2016 13:21:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CD7D0188A9;
	Mon,  2 May 2016 13:21:12 -0400 (EDT)
In-Reply-To: <20160430004741.GA16900@yexl-desktop> (Ye Xiaolong's message of
	"Sat, 30 Apr 2016 08:47:41 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 44E16434-108A-11E6-87D8-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293243>

Ye Xiaolong <xiaolong.ye@intel.com> writes:

> On Fri, Apr 29, 2016 at 03:04:58PM -0700, Junio C Hamano wrote:
>>* xy/format-patch-base (2016-04-26) 4 commits
>> - format-patch: introduce format.useAutoBase configuration
>> - format-patch: introduce --base=auto option
>> - format-patch: add '--base' option to record base tree info
>> - patch-ids: make commit_patch_id() a public helper function
>>
>> "git format-patch" learned a new "--base" option to record what
>> (public, well-known) commit the original series was built on in
>> its output.
>>
>> Looking close to be ready.
>> ($gmane/292622).
>
> Not quite sure about this status, anything else I need to do other
> than the follow-up patch which to do the enhancement feature
> suggested by Stefan?

I thought that we all agreed that enhancing it with even more
heuristics would be nice to have but lack of them does not block
what is already in the series from progressing without them?

I was planning to hold this for in 'pu' for a while, until others
review them with fresh eyes to make sure there is no have any
glaring errors or leaks, and then merge them to 'next' and
eventually down to 'master', while accepting follow-up patches on
top but as a separate "enhancement" effort.
