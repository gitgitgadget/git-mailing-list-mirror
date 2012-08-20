From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2012, #06; Sun, 19)
Date: Mon, 20 Aug 2012 15:52:28 -0700
Message-ID: <7vobm5gor7.fsf@alter.siamese.dyndns.org>
References: <7v393im4jy.fsf@alter.siamese.dyndns.org>
 <20120820224808.GA30139@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 00:52:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3apo-0007wU-LD
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 00:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756585Ab2HTWwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 18:52:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33728 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754289Ab2HTWwa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 18:52:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 966129332;
	Mon, 20 Aug 2012 18:52:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qwK1MrjUz1aHq/ZKwxAtjAaR0fU=; b=G1zm98
	hADqo2taVTFo+sPOFPLcXENeA/iZCisdeVYYwFW9qD6j4A/xB+xyjk/BeFE9bx88
	uV63N0PiExPLAYCn+QFSj/TH1xgEIjtGoYxa47llu/lbtV0PnZdA398Y2tN+Ke2U
	mqW1LhJ4U68+1DHm+JfIXAIN1nHlNkGjJeh+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hg5/OViInJ7yfyahbDRbtbAvEvlJ3Jtp
	C1HpWHX7LTMdVkaewGcBgph4DNRGfnQNMvO0b44mnYSCOewtZH/bofB5LQc6oyWI
	HmC+YX/bmxmSoqNG7Uau/PHA4crXMc9i2k4LSHZ58LoKcHCpZL4EfK8dMRzuHOye
	+8jmiqLjX9I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 839F69331;
	Mon, 20 Aug 2012 18:52:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EE8079330; Mon, 20 Aug 2012
 18:52:29 -0400 (EDT)
In-Reply-To: <20120820224808.GA30139@padd.com> (Pete Wyckoff's message of
 "Mon, 20 Aug 2012 18:48:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B87E9F6E-EB19-11E1-9295-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203905>

Pete Wyckoff <pw@padd.com> writes:

> gitster@pobox.com wrote on Mon, 20 Aug 2012 00:00 -0700:
>> * pw/p4-submit-conflicts (2012-08-16) 12 commits
>>  - git p4: add submit --prepare-p4-only option
>>  - git p4: add submit --dry-run option
>>  - git p4: accept -v for --verbose
>>  - git p4: revert deleted files after submit cancel
>>  - git p4: rearrange submit template construction
>>  - git p4: test clean-up after failed submit, fix added files
>>  - git p4: standardize submit cancel due to unchanged template
>>  - git p4: move conflict prompt into run, use [c]ontinue and [q]uit
>>  - git p4: remove submit failure options [a]pply and [w]rite
>>  - git p4: gracefully fail if some commits could not be applied
>>  - git p4 test: use p4d -L option to suppress log messages
>>  - git p4 test: remove bash-ism of combined export/assignment
>> 
>> I saw Pete and Luke going back and forth collaborating, so I take
>> that this may still be rerolled---if not, please holler.
>
> Yes, expect a reroll; this isn't ready to go as-is.  We'll
> continue the back and forth.

Ok, will wait until the dust settles.

>> * pw/p4-use-client-spec-branch-detection (2012-08-11) 5 commits
>>  - git p4: make branch detection work with --use-client-spec
>>  - git p4: do wildcard decoding in stripRepoPath
>>  - git p4: set self.branchPrefixes in initialization
>>  - git p4 test: add broken --use-client-spec --detect-branches tests
>>  - git p4 test: move client_view() function to library
>
> I've got a
>
>     Tested-by: Matthew Korich <matthew@korich.net>
>
> to add in the top-most commit "make branch detection work...".
> Should I send a whole reroll, just one patch, or simply a note
> like this?  In general, for next time, please.

I can amend it here.  Thanks.
