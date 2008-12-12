From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3 (edit v2)] gitweb: Cache $parent_commit info in
 git_blame()
Date: Thu, 11 Dec 2008 19:05:05 -0800
Message-ID: <7vr64e9jq6.fsf@gitster.siamese.dyndns.org>
References: <20081209224622.28106.89325.stgit@localhost.localdomain>
 <200812101439.18526.jnareb@gmail.com>
 <7v7i67zsgj.fsf@gitster.siamese.dyndns.org>
 <200812110133.33124.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Luben Tuikov <ltuikov@yahoo.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 04:06:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAyMN-0000qw-Kl
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 04:06:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757286AbYLLDFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 22:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757089AbYLLDFP
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 22:05:15 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55112 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756827AbYLLDFO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 22:05:14 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3FF9F86DDD;
	Thu, 11 Dec 2008 22:05:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2A2FA86DD6; Thu,
 11 Dec 2008 22:05:06 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B111A7CC-C7F9-11DD-93B0-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102882>

Jakub Narebski <jnareb@gmail.com> writes:

> ...
> Alternate solutions:
> ~~~~~~~~~~~~~~~~~~~~
> ...
> Acked-by: Luben Tuikov <ltuikov@yahoo.com>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> On Wed, 10 Dec 2008, Junio C Hamano wrote:
>
>> To recap, I think the commit log for this patch would have been much
>> easier to read if it were presented in this order:
>> 
>>         a paragraph to establish the context;
>> 
>>         a paragraph to state what problem it tries to solve;
>> 
>>         a paragraph (or more) to explain the solution; and finally
>> 
>>         a paragraph to discuss possible future enhancements.
>
> Like this?

Yes, basically.

The "future possibilities" section might be a bit too heavy, and also
calling it "Alternate solutions" makes it slightly unclear if it is
talking about what is implemented, or only talking about idle speculation
without an actual code (in this case, it is the latter), though.

> Only commit message has changed.

Which is a bit unnice, because it will conflict with the original [3/3]
that I queued already (with a pair of fixes, including but not limited to
the one you sent "Oops, it should have been like this" for).

I can hand wiggle the patch to make it apply, but I'd prefer if I did not
have to do this every time I receive a patch.

I think the conflict was trivial (just a single s/rev/short_rev/) and I
did not make a silly mistake when I fixed it up, but please check the
result on 'pu' after I push the results out.

Thanks.
