From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] filter-branch: Add more error-handling
Date: Wed, 11 Feb 2009 14:28:04 -0800
Message-ID: <7v8wocbocr.fsf@gitster.siamese.dyndns.org>
References: <1234361365-63711-1-git-send-email-git@randomhacks.net>
 <1234372518-6924-1-git-send-email-git@randomhacks.net>
 <7vhc30eqy7.fsf@gitster.siamese.dyndns.org>
 <20090212063038.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Kidd <git@randomhacks.net>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 23:30:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXNaQ-0003Cj-B9
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 23:29:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755287AbZBKW2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 17:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754921AbZBKW2P
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 17:28:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51429 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754589AbZBKW2P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 17:28:15 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6503A2AEFC;
	Wed, 11 Feb 2009 17:28:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 465922AEC9; Wed,
 11 Feb 2009 17:28:06 -0500 (EST)
In-Reply-To: <20090212063038.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Thu, 12 Feb 2009 06:30:38 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4348E3BE-F88B-11DD-BBB5-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109539>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>:
>
>> This goes after three-dashes; people who read "git log" output wouldn't
>> know nor care what was in v1.
>> 
>>     Subject: Fix X under condition Z
>> 
>>     X should do Y if condition Z holds, but it does not.  This can result
>>     in broken results such as W and V.
>> 
>>     This patch fixes X by changing A, B and C.
>> 
>>     Thanks for M, N and O for reviewing and suggesting improvements.
>> 
>>     Signed-off-by: A U Thor <au.thor@example.xz>
>
> I think you meant this as a sample to follow.  Can we add it to Documentation/SubmittingPatches?

I did mean it as such, but I doubt it is good enough to be in in the
document (primarily because I wrote it).

Just quoting the above verbatim does not make it clear that "Thanks for M,
N..." is usually not even wanted, but was merely a suggestion for this
specific case of Eric's commit, iow, _only if he wanted to_.  We need more
commentary like that, but with too much details, it would cease to be a
generic recommendation.

Also, the above is not suitable for new features at all as a template.
