From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-filter-branch: Move note about effect
 of removing commits
Date: Tue, 18 Sep 2012 12:50:05 -0700
Message-ID: <7v392fm7pu.fsf@alter.siamese.dyndns.org>
References: <m2627biaw3.fsf@igel.home>
 <7vwqzrmbk1.fsf@alter.siamese.dyndns.org> <m2wqzrgn58.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 21:50:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE3oJ-0000yc-0Q
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 21:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754694Ab2IRTuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 15:50:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47941 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754630Ab2IRTuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 15:50:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 182039F43;
	Tue, 18 Sep 2012 15:50:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UGCNXfnOnHhl1UTR5Bs+RxNmszA=; b=Oovbkd
	Wy1UEgeMp29/Q0NlcqzmaAXVx6LhbRFrEQPXJHbTUZC8JNyMnezBUimomCm8nQJP
	SP6GrqUsRTh/0deeIouDLZGvSsHojRwhEDp7PkrQxU1ztsbQHzusJVmCR37UjYUV
	x5eRjO6Ystvjf6D/VzC8IEekae2IdAADo97t8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CEH8PXPQx8bSa+a/OuOt5TsrYaID88Ab
	Te7gqI5xluhYdYOr4n8/FSqCKgdBgQQuhbPqE/nXNZLnD2/B6Y9YrF4vguH1hPh2
	TgBLZ8PUb2YnFNa4dnpIg8StCCfi1n6d2mVIcEDc+1lYk7xtMpGXQzQseBP+LYJU
	YPZ4q2M/MFw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9D9E9F42;
	Tue, 18 Sep 2012 15:50:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6EDD69F3E; Tue, 18 Sep 2012
 15:50:07 -0400 (EDT)
In-Reply-To: <m2wqzrgn58.fsf@igel.home> (Andreas Schwab's message of "Tue, 18
 Sep 2012 21:13:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0C38FD4A-01CA-11E2-A6E1-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205861>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> So something like this instead?
>
> I agree it's even better.
>
> Andreas.

Thanks for proofreading.  I'll squash in the differences to your
patch.
