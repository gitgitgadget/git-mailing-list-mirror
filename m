From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2013, #05; Thu, 26)
Date: Fri, 27 Dec 2013 14:13:35 -0800
Message-ID: <7vmwjmj628.fsf@alter.siamese.dyndns.org>
References: <xmqq1u0zcoci.fsf@gitster.dls.corp.google.com>
	<CAPig+cQXsdFocFeSR8YKh8crOwBFP0ZK0td2UbP-yypRYJhREQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Dec 27 23:13:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwffB-00058N-OD
	for gcvg-git-2@plane.gmane.org; Fri, 27 Dec 2013 23:13:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754822Ab3L0WNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Dec 2013 17:13:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43253 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754813Ab3L0WN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Dec 2013 17:13:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 480625CC78;
	Fri, 27 Dec 2013 17:13:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KtOxP+S0Rm97FYR4H9nfZEKtVmc=; b=JRoK4j
	RoFhoA7LH5iqGet/dSoOjFMyu1xHXBchgWkFkuA+or9nIVwh90293ywkNCt80nDi
	bk9+6LqccdOR3Ah/yli75Hx36IUoYGTTuKcJiqkMifXCAUtmmjswG9gieRrcoOLg
	pw3mEHRjPDp96NYKHkcnQcdPQRIDvAkSFPkBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QwSdjwxtg6/wVKndZgqs3EnEBf42/NLG
	JlT3SW4tSpp0WnUwvYK9FgVnDTRhwDs5UDssHSvuzIt9v4uy6ZGCXxzztDjIOBzP
	4uIcPNrz8syeRTR8sJk91wVCpxm6CWFtcFQgItho0ruYwqULDsi2A3IrAdkbpPG5
	tkiJYMTM1fQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B31C5CC77;
	Fri, 27 Dec 2013 17:13:29 -0500 (EST)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 661B35CC76;
	Fri, 27 Dec 2013 17:13:28 -0500 (EST)
In-Reply-To: <CAPig+cQXsdFocFeSR8YKh8crOwBFP0ZK0td2UbP-yypRYJhREQ@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 27 Dec 2013 16:54:52 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: 1CE1BF54-6F44-11E3-B505-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239751>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Dec 26, 2013 at 4:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Here are the topics that have been cooking.  Commits prefixed with
>> '-' are only in 'pu' (proposed updates) while commits prefixed with
>> '+' are in 'next'.
>>
>> You can find the changes described here in the integration branches
>> of the repositories listed at
>>
>>     http://git-blame.blogspot.com/p/git-public-repositories.html
>>
>> --------------------------------------------------
>> [New Topics]
>
> Would $gmane/239575 [1] be of interest for "New Topics"?
>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/239575/

Actually I was planning to scoop it up directly to master but forgot
to do so.

Running "git diff maint pu -- name-hash.c" shows that we have added
a comment that mentions index_name_exists---that needs to be
adjusted, too, by the way.
