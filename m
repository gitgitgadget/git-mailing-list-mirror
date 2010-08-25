From: Junio C Hamano <gitster@pobox.com>
Subject: Re: kill filter-branch --remap-to-ancestor?
Date: Wed, 25 Aug 2010 11:58:24 -0700
Message-ID: <7v39u2senj.fsf@alter.siamese.dyndns.org>
References: <i4pd55$19q$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Csaba Henk <csaba@gluster.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 20:58:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoLBF-00085Z-JO
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 20:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339Ab0HYS6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 14:58:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58211 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260Ab0HYS6c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 14:58:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C219CD0497;
	Wed, 25 Aug 2010 14:58:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R4sae0JU0w/qKu4z+HfcP2pWxf8=; b=m27vvt
	MSh93tMw783QbAd5l1BaG6AVI1CDHRJ84OxlxCI27+We3uVQFEqivDv4cwn6HDyq
	10AUh48Wtb3HOPxSWXSRzpeUtbTAtIETkyxMkSEOOijlD4AmKaYMZFMFViRbm/H0
	cSo9vakF4tfFcbklowwhBTKNvEQUf/sNSo8f4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ayQwXOKDpb7piwmIDPvRDubdOiGxIOdS
	HoGB5LMb9n172B5T9Vl0ixc+1Td4MOBJOKQOCUTCXxXAzhOb78bDsBgfzJ+kgnsU
	Jyk8bVXCNA4CfTBmiHWh9aokTyECHR5cFR5y7epkLHc/8hl1+AI7uR4VFq6vKjlZ
	rf4JteRnj28=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 99CACD0496;
	Wed, 25 Aug 2010 14:58:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1067CD0495; Wed, 25 Aug
 2010 14:58:25 -0400 (EDT)
In-Reply-To: <i4pd55$19q$1@dough.gmane.org> (Csaba Henk's message of "Sat\,
 21 Aug 2010 20\:32\:37 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BFDEF8B6-B07A-11DF-AA35-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154462>

Csaba Henk <csaba@gluster.com> writes:

> I had some headache with the issue to which the cure is the
> "--remap-to-ancestor" option of git filter-branch -- back when
> "--remap-to-ancestor" was not yet
> (cf. http://thread.gmane.org/gmane.comp.version-control.git/112068/focus=112838).
>
> This time, in a similar situation, I had some headache with finding out
> that the panacea is already there and it's called "--remap-to-ancestor".
>
> Why not cut back on complexity and get rid of "--remap-to-ancestor"
> while automatically enable the implied behavior for filters including a
> path? This was already proposed by Junio and the author of the option
> had no objections against this idea (see
> http://thread.gmane.org/gmane.comp.version-control.git/130949/focus=132684).

I am not a heavy user of filter-branch myself (I used it once during the
past 6 months and it was with pathspec but the project did not have any
tags, so that particular exercise does not matter).

I do not offhand see a reason not to.  Please make it so, if you are
so inclined, or perhaps somebody else may volunteer?
