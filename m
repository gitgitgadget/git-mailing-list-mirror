From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] documentation: Makefile accounts for SHELL_PATH setting
Date: Sat, 11 Apr 2009 13:42:39 -0700
Message-ID: <7vmyamdirk.fsf@gitster.siamese.dyndns.org>
References: <1237728044-15651-1-git-send-email-bwalton@artsci.utoronto.ca>
 <20090410093430.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ben Walton <bwalton@artsci.utoronto.ca>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sat Apr 11 22:44:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lsk3r-0000jy-Pq
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 22:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759226AbZDKUmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 16:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759193AbZDKUmt
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 16:42:49 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44607 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758961AbZDKUms (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 16:42:48 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 10080E2C1;
	Sat, 11 Apr 2009 16:42:45 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 61A9FE2BE; Sat,
 11 Apr 2009 16:42:41 -0400 (EDT)
In-Reply-To: <20090410093430.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Fri, 10 Apr 2009 09:34:30 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4F75A5D8-26D9-11DE-9D79-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116345>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Ben Walton:
>
>> Ensure that the Makefile that generates and installs the Documentation
>> is aware of any SHELL_PATH setting.  Use this value if found or the
>> current setting for SHELL if not.  This is an accommodation for systems
>> where sh is not bash.
>>
>> Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
>
> Junio, may I ask what happened to this patch?

There was a discussion going that eventurally petered out without seeing
success (or breakage) reports from people with various platforms.

I think the patch text is Ok, with "where sh is not bash" in the log
message rephrased to "where sh is not POSIX", but I do not have an easy
access to a system where /bin/sh is broken (perhaps I should install
OpenSolaris in a vbox to try out), so it is still sitting in my inbox.
