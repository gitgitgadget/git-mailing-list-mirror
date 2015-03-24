From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2015, #08; Mon, 23)
Date: Tue, 24 Mar 2015 13:08:54 -0700
Message-ID: <xmqqoani5fah.fsf@gitster.dls.corp.google.com>
References: <xmqqmw338khu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Mar 24 21:09:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaV8O-0007Ot-Dc
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 21:09:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972AbbCXUJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 16:09:04 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61101 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752800AbbCXUJC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 16:09:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B08343131;
	Tue, 24 Mar 2015 16:08:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Kc0qoLA82u+4qyYN2DNAjfHVMlQ=; b=sjzXcO
	uqebjDJ7BazLj8T38/+nsDawp0e/+9ILQEGLTfanpYti1wakNYRlybTui6G+Ndn5
	F/O+Z/2PAA2k/cXWRdyZQHQ/UROgTtH8hXKH0a+YunYbG9w2O04Ks2haL3jut9hO
	FVty3sLlmmjWMMz5fHM/s6wP/hWru+4nn06Es=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P1g0e9MrMEfxs923VJkmLE5NAZb2a5Hd
	e7AJ/Ry0ByfsTO1FV9mpMotfuD80/YjdNRNaJ1q+5XwDqw54/1SYs39e7c4TwsXe
	nWnWXCJsx4CLctWDm2ePhng2m7MzI0gw4rQNjucBWJZ6pIRubtMnoPlOkckiPgHZ
	Tl7fiVx2JhU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 63FCF4312F;
	Tue, 24 Mar 2015 16:08:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DF04F4312D;
	Tue, 24 Mar 2015 16:08:55 -0400 (EDT)
In-Reply-To: <xmqqmw338khu.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 23 Mar 2015 14:35:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 99A43B6C-D261-11E4-8342-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266225>

Junio C Hamano <gitster@pobox.com> writes:

> [Stalled]
>
> * mh/fdopen-with-retry (2015-03-06) 6 commits
>  - buffer_fdinit(): use fdopen_with_retry()
>  - update_info_file(): use fdopen_with_retry()
>  - copy_to_log(): use fdopen_with_retry()
>  - fdopen_lock_file(): use fdopen_with_retry()
>  - SQUASH??? $gmane/264889
>  - xfdopen(): if first attempt fails, free memory and try again
>
>  Various parts of the code where they call fdopen() can fail when
>  they run out of memory; attempt to proceed by retrying the
>  operation after freeing some resource.
>
>  Waiting for further comments.

Sorry, but I lost track.  Is this one still viable, or have we
decided that it is not worth doing it?
