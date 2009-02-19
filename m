From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rebase -i
Date: Thu, 19 Feb 2009 02:09:22 -0800
Message-ID: <7v63j6oi0d.fsf@gitster.siamese.dyndns.org>
References: <43d8ce650902190121v2e18aac1rfaa64a4ce6e799a3@mail.gmail.com>
 <FEE581A3-C858-45CF-B545-8F7187FCCE40@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Thu Feb 19 11:11:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La5rt-0000oy-91
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 11:10:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754270AbZBSKJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 05:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753776AbZBSKJ3
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 05:09:29 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57431 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337AbZBSKJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 05:09:29 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CA94A2B77D;
	Thu, 19 Feb 2009 05:09:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1B55F2B77C; Thu,
 19 Feb 2009 05:09:23 -0500 (EST)
In-Reply-To: <FEE581A3-C858-45CF-B545-8F7187FCCE40@ai.rug.nl> (Pieter de
 Bie's message of "Thu, 19 Feb 2009 10:00:53 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 64455222-FE6D-11DD-9F7D-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110662>

Pieter de Bie <pdebie@ai.rug.nl> writes:

> On 19 feb 2009, at 09:21, John Tapsell wrote:
>
>>  Would there be any objections to making  'git rebase -i' default to
>> HEAD~10  or maybe 16 or 20.  Having sensible defaults for commands
>> helps a bit with making it easier to use.
>
> I'd prefer something a bit less arbitrary, like using the tracked head
> for a tracking branch.

I'd say that might be a very sane default for users or "branch --track"
and/or "pull --rebase", both for i-rebase and rebase.
