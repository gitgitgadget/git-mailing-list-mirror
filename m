From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git submodule: update=!command
Date: Tue, 17 Mar 2015 13:49:26 -0700
Message-ID: <xmqqy4mvmjs9.fsf@gitster.dls.corp.google.com>
References: <1426620537.1785877.241673949.72FB3B40@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Chris Packham <judge.packham@gmail.com>
To: Ryan Lortie <desrt@desrt.ca>
X-From: git-owner@vger.kernel.org Tue Mar 17 21:49:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXyQg-0006Nt-59
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 21:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754003AbbCQUt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 16:49:29 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65489 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752997AbbCQUt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 16:49:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 31E1E3F0F2;
	Tue, 17 Mar 2015 16:49:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=edx12YaKBLjiZaYtlbHHRp4d/QU=; b=Ruy9Py
	YQHhaYr/MgakQMBmKWC+Yk1c93mUzCsl0K71Y2pc06PCvFcYTzD291VmrGXX6yuv
	yRpvi39Zks4rsicMJNp1R1inRIr3Ark1fyZaIdKRNoWRaB5hA45YZsfmhpIjBj4Y
	WbQnu+fyEDAhwkOWD+o2aq1F5ro7Td09jJgRE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YVGXnVemvv1+n9SI9FtI7lHnjBDKC3Zw
	LC6LPlPqSgZK9g7CO3pyRqX2k6yMD8IgBb0ETBROZMX5bYXliijG3bFaO+9Yu9vF
	9/9/U2fGH8LCYrpHYwLn2NosVcsY1bZlZbwgGwQz7J+NPDIsQC44Qz+QOnof9o5m
	SCNN+SgDtJo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2AC113F0F1;
	Tue, 17 Mar 2015 16:49:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7E0973F0F0;
	Tue, 17 Mar 2015 16:49:27 -0400 (EDT)
In-Reply-To: <1426620537.1785877.241673949.72FB3B40@webmail.messagingengine.com>
	(Ryan Lortie's message of "Tue, 17 Mar 2015 15:28:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1A18D666-CCE7-11E4-8012-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265666>

Ryan Lortie <desrt@desrt.ca> writes:

> 'man git-submodule' contains mention (in one place) that:
>
>     Setting the key submodule.$name.update to !command
>     will cause command to be run.
>
> This is not documented in 'man gitmodules' (which documents the other
> possible values for the 'update' key)

Yes, that is deliberate, because you cannot use !command in .gitmodules
that is tracked for security reasons.

With more recent versions of Git, namely, the versions after
30a52c1d (Merge branch 'ms/submodule-update-config-doc' into maint,
2015-03-13), the documentation pages already have updated
descriptions around this area.
