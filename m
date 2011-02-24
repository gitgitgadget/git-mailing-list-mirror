From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2011, #05; Wed, 23)
Date: Wed, 23 Feb 2011 16:43:58 -0800
Message-ID: <7voc6245yp.fsf@alter.siamese.dyndns.org>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org>
 <201102240052.36379.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Feb 24 01:44:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsPJX-0007pJ-Ts
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 01:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754899Ab1BXAoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 19:44:07 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34566 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830Ab1BXAoF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 19:44:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 68A374C3D;
	Wed, 23 Feb 2011 19:45:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eiUfIa9eyS7Ak/+ZZ2mC3ulEy6Y=; b=OUmcC7
	FnfivK9Eo0VaYh4pcilBqxuGHQpcom9l2iBq5ho3U1J9pL/OayH/j+pF0jVfJy5Y
	006xuhnXmM05PtwJiWBPrp1IjLOeVf6gOW2AbAoAymhYatU+kkQAj9glefySYR49
	p7V5r0dXhRwWkWAfD0L58OIkpS2zlOLZrvoKk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VC2WU8oEgr3sRSU7SE2cR5IGjh+FDAWl
	yjN25kevSiqpg8XbmCIIuMygpN+TzaY9j/e3CW7j/qlwwwOHJdfh8rsfQuSm4Yu5
	W+mm8ZnwyzyJj/oYxekNTMuuQtrLtf8nuGBdjjWkS9oNMSC2VYPUL16d0coBO/pD
	R0PW3jPKsmw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 46B2C4C3C;
	Wed, 23 Feb 2011 19:45:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4F6C54C3B; Wed, 23 Feb 2011
 19:45:12 -0500 (EST)
In-Reply-To: <201102240052.36379.johan@herland.net> (Johan Herland's message
 of "Thu\, 24 Feb 2011 00\:52\:36 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 58302022-3FAF-11E0-8086-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167758>

Johan Herland <johan@herland.net> writes:

> On Thursday 24 February 2011, Junio C Hamano wrote:
>> Here are the topics that have been cooking.  Commits prefixed with '-'
>> are only in 'pu' while commits prefixed with '+' are in 'next'.
>> 
>> [...]
>> * jh/maint-do-not-track-non-branches (2011-02-17) 1 commit
>>  - branch/checkout --track: Ensure that upstream branch is indeed a
>> branch
>> 
>> This supersedes "do not track HEAD" from Thomas.
>
> What do you mean by "supersedes"? It builds on top of Thomas' patch (v2 was 
> rebased on top it), but it does not _replace_ Thomas' patch.

I judge that the earlier one to special case only "HEAD" a failed attempt
to the wider problem; what was posted to the list might have been relative
to it, but what is queued reverts the effect of the previous patch and is
relative to the mainline.
