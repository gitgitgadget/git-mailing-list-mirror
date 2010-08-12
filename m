From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2010, #02; Wed, 11)
Date: Thu, 12 Aug 2010 14:58:09 -0700
Message-ID: <7vbp97qyry.fsf@alter.siamese.dyndns.org>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
 <4C63BD9B.6000608@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Greg Brockman <gdb@MIT.EDU>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Elijah Newren <newren@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Aug 12 23:58:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjfnD-00041u-LM
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 23:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760892Ab0HLV60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 17:58:26 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54087 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754629Ab0HLV6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 17:58:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 363A6CC14B;
	Thu, 12 Aug 2010 17:58:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FKu/Qe6+2iPyn5719JHgxz58Kls=; b=BbNrM2
	xRgBZUb3tYN7XNTYglmkmIDm5RiokoaIo9ZfNH9rCkAJCmTqto690bs6hwjRr2LG
	25N6ObTOq5MP1zzbLMX1FKFtYJB/4bJiKmOkG0K/XEAHCBKoQTKyAex6II3F354P
	V+Dl+dmfD8hRxVA1oyANajHE10mTMECIO/LwU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A3nrYxGlA/SwBsIjLr7aiN5nMvQwzNwa
	UCrqhCFMiS5iFt3HdXlmmVaDTJ9STNBU/HVd8pZboyKarzjb1S7WkUXSZf9AZLW/
	lwS8KJGmh2ZFX+0yhpwapGLsOjDBnJ2ksDu7Bx08eLxYvMfswUAkpaf4mORs97LO
	1WhVYB1DiHM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B7B9CCC14A;
	Thu, 12 Aug 2010 17:58:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 965C9CC149; Thu, 12 Aug
 2010 17:58:10 -0400 (EDT)
In-Reply-To: <4C63BD9B.6000608@viscovery.net> (Johannes Sixt's message of
 "Thu\, 12 Aug 2010 11\:23\:39 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B6B93EFE-A65C-11DF-9D9D-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153424>

Johannes Sixt <j.sixt@viscovery.net> writes:

> I compiled many topics in pu and ran the test suite on Windows,
> particularly those that "look good" and "will merge to next". Here's a report.

Thanks.

>> * jn/apply-filename-with-sp (2010-07-23) 4 commits
>>  - apply: Handle traditional patches with space in filename
>>  - t4135 (apply): use expand instead of pr for portability
>>  - tests: Test how well "git apply" copes with weird filenames
>>  - apply: Split quoted filename handling into new function
>> 
>> Looked Ok.  Will merge to 'next'.
>
> The test cases that work with files with tabs must have a prerequisite;
> see t3600-rm.sh.

Thanks for stopping me.

>> * en/d-f-conflict-fix (2010-07-27) 7 commits
>>   (merged to 'next' on 2010-08-03 at 7f78604)
>>  + t/t6035-merge-dir-to-symlink.sh: Remove TODO on passing test
>>  + fast-import: Improve robustness when D->F changes provided in wrong order
>>  + fast-export: Fix output order of D/F changes
>>  + merge_recursive: Fix renames across paths below D/F conflicts
>>  + merge-recursive: Fix D/F conflicts
>>  + Add a rename + D/F conflict testcase
>>  + Add additional testcases for D/F conflicts
>
> The new tests in t/t3509-cherry-pick-merge-df.sh and t9350-fast-export.sh
> need SYMLINKS prerequisite.

Again, thanks for stopping me.
