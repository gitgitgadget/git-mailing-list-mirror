From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2010, #01; Wed, 1)
Date: Thu, 02 Sep 2010 09:26:30 -0700
Message-ID: <7v1v9c2jt5.fsf@alter.siamese.dyndns.org>
References: <7vaao15jk2.fsf@alter.siamese.dyndns.org>
 <AANLkTi=ma8MLssD_1YeSju7iJucRN9NFzYESJ2rGhyjv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 18:26:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrCce-0003H7-RH
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 18:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755863Ab0IBQ0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 12:26:39 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46218 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082Ab0IBQ0j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 12:26:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A4854D20C0;
	Thu,  2 Sep 2010 12:26:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kQOvKlzyo/yOjbIPpCOgwapec6A=; b=mrlo/h
	Q91nHJtKLuGHvEPtOGO/MoCdLYCJP58Pjfl83oP97jrzMO8jzqpbijGa5Y26nCDn
	WquGKMVlz+UPaqUMCv6Xukr2cz8gADLIOsdVaWH6EQIpVykoulU6DKrhHVo/BBca
	Ck3M5LpwDZ/0FRVBGMIaknMrjPGM26iQV4jmM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tUHM9ge+ShEhRaPXh+Za1TBf6BAzvA0X
	R55PC2hwcDrvKXmIl+bNA/KhP3fbzClDkhIavJ0V7CQLybiDIaua66TiG24o2ywy
	ZYvR/8+b47DbM6R87WUVBxkwcq98+rhvI/wfrWFaIRfV5swtCqFFFIxlPknjndXs
	qDbPD+fkY3s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 78A37D20BF;
	Thu,  2 Sep 2010 12:26:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C477CD20BB; Thu,  2 Sep
 2010 12:26:32 -0400 (EDT)
In-Reply-To: <AANLkTi=ma8MLssD_1YeSju7iJucRN9NFzYESJ2rGhyjv@mail.gmail.com>
 (Elijah Newren's message of "Wed\, 1 Sep 2010 14\:54\:45 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DABA71F8-B6AE-11DF-8E45-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155142>

Elijah Newren <newren@gmail.com> writes:

>> * en/object-list-with-pathspec (2010-08-26) 2 commits
>>  - Make rev-list --objects work together with pathspecs
>>  - Add testcases showing how pathspecs are ignored with rev-list --objects
>>
>> Heard that this is still broken?
>
> Are you possibly remembering v1 of the series, which mis-used the
> tree_entry_interesting() API, and was fixed by v2 including extra
> testcases?  You merged the latter into pu, so there's no remaining
> issue I know of.

Right about me misremembering things; thanks.
