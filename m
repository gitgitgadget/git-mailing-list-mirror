From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.7.9
Date: Fri, 03 Feb 2012 11:41:48 -0800
Message-ID: <7vehubpuv7.fsf@alter.siamese.dyndns.org>
References: <7vipjwzvc2.fsf@alter.siamese.dyndns.org>
 <m3y5slark1.fsf@localhost.localdomain>
 <CAPc5daVhXQ3-TCqZi8di=j5LdpwXZUt3bO8KkvA2UmL6axCRqQ@mail.gmail.com>
 <201202031352.10279.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 20:41:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtP1A-0004MY-Kl
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 20:41:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005Ab2BCTlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 14:41:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56262 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753372Ab2BCTlu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 14:41:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 126BC6343;
	Fri,  3 Feb 2012 14:41:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aPWPDKANTAGnw5hkSzM/kFbUo7M=; b=P+Vm6r
	nQ378S/qzhC8WwOESMpYC+11Bz8b1tQ9TqwJchjTvrdsLOvWpU8OQc1eBA8fK6I6
	kZBNhQbMgw1ejAM9meh3/0AseDlCqPd8p01Kourfhf5FzxSSEXQNVJOI/ZNHyM/i
	/ZwiUsWLto+VOAG5Fmv5qLLqv6BbI03LFsR3s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BK5h9z25zXn+23RlxuYTbZY9nLS1WUPa
	IVO9GoEI2fBuDMpGyh3LHPoRb+rbYp7ZgBqiwkz+JLZwzuVHoGcZx8K9QzGYFMvU
	JjX3878N7MW0T/cn6uCndPdKM3zPy1BgZb7WHostLA40Mlg9pPe1wSVnnGbOv7Bs
	mB1sIsWccVU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A5A36340;
	Fri,  3 Feb 2012 14:41:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D070633E; Fri,  3 Feb 2012
 14:41:49 -0500 (EST)
In-Reply-To: <201202031352.10279.jnareb@gmail.com> (Jakub Narebski's message
 of "Fri, 3 Feb 2012 13:52:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1D528102-4E9F-11E1-9672-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189793>

Jakub Narebski <jnareb@gmail.com> writes:

>> >  RPM build errors:
>> >     Installed (but unpackaged) file(s) found:
>> >    /usr/share/locale/is/LC_MESSAGES/git.mo
>> >
>> 
>> I think it should be simply ignored at least for now.  I stopped touching
>> the rpm spec since August last year (the only reason I was running rpmbuild
>> was to install them on k.org), so I didn't notice.
>
> So for the time being something like that would be an acceptable fix?

Except that the patch probably wants to go to git.spec.in, removing that
installation target would be a good local workaround for now.

I said "local workaround", meaning that I am not all that interested in
applying such a patch myself.  Somebody who wants to do RPM needs to
decide what subpackage(s) it should go before we start accepting more po/
files, and at that time the workaround needs to be reverted.

And hopefully that should happen soonish ;-)
