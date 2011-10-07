From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How pretty is pretty? git cat-file -p inconsistency
Date: Fri, 07 Oct 2011 11:04:43 -0700
Message-ID: <7v62k0wudg.fsf@alter.siamese.dyndns.org>
References: <4E8EBC00.90909@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Oct 07 20:04:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCEmx-0007Dy-V4
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 20:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755440Ab1JGSEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 14:04:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63610 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751068Ab1JGSEq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 14:04:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A8E76C46;
	Fri,  7 Oct 2011 14:04:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=de6gZjyibhjK/yFAq/bl4PV/wpM=; b=g0nVd6
	0t6v+vTViXmCqG1LRE7KjOOhUIkb0hgMIBGgvcboiX+NvNkhY1RYGl+I5BL7Gpa8
	K2QkassydaakE5sggHKL9wHrgCNWA1gZ1kJwBIxTx1+TH9s7jd8X0z+HzAl4//+/
	Bk+ZZUWrAR9q33UnVv6umfrlFC9y2nO6e3Y2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J09CNFQgAeRhOHb7wevSwY3BmX4snodT
	FuYkchQNbsIHHDUmkzUJgS+0YSYdod4YI7ZgoWDfEO7EybT2GCNn2uMUW/4z5lfN
	7JvVq7ZOJqRfJBl/u4OhKRSmGqdhPbBpPdjsgrCiZo3F6sTJ9MMPYdYbrAPqqwH2
	JzaOC/jcD3U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 817D96C45;
	Fri,  7 Oct 2011 14:04:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F34266C44; Fri,  7 Oct 2011
 14:04:44 -0400 (EDT)
In-Reply-To: <4E8EBC00.90909@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Fri, 07 Oct 2011 10:44:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D667BAE8-F10E-11E0-B9AB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183094>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> That is, "cat file -p" pretty prints dates for tag objects but not for
> commit objects. In fact, "-p" on commit objects does not prettify at all
> compared to the raw content. Is that intentional?

"cat-file -p" is an ill-conceived half-ass afterthought, and I do not
think anybody sane considers it as part of the "plumbing" ultra stable
interface for machine consumption. See a0f15fa (Pretty-print tagger
dates., 2006-03-01).

> I'd suggest
> prettifying dates with "-p" for commit objects also.

Please make it so. It is your choice to do a patch to update this single
thing first, or to discuss the output with "-p" for all the other object
types at the same time to get the list concensus before proceeding.

Thanks.
