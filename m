From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2013, #10; Sun, 27)
Date: Wed, 30 Jan 2013 08:47:53 -0800
Message-ID: <7vpq0mlirq.fsf@alter.siamese.dyndns.org>
References: <7vlibdyfdt.fsf@alter.siamese.dyndns.org>
 <20130130123420.GA3793@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 17:48:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0ape-0005q2-U5
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 17:48:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754556Ab3A3Qr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 11:47:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44031 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754368Ab3A3Qr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 11:47:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCEAFB4E7;
	Wed, 30 Jan 2013 11:47:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xIlfgXsZF7BUM1jxvF839t42NuU=; b=atCqBR
	I6pfj70PxIR/a6grEhvLJnCYD2WYg22MTJOH/70TMb98QpyR7iwMSeAnAyckNVGd
	95UFBRBfrhG3+flWvZp2SlS6stvJ8+n73Nbx+KZJsnyvQuSrHzL0EpZgvoL0cr9B
	Wq5bK2SPHrj1jl7UP5ak1j6eEwo9qd9Kfde88=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I0u4L+SiHwzdHVwGgFkST1DfFdZXufzk
	HkNiMWKPDxRRqZHna9FrpeT6CbGqtzk6MyLFVxXUuWwTdbzKwAXSmm+egdIgYNIp
	1vCHKGrncBu2zaUTzZfopPiMuf+F581GG5HGaButQmg0X6pKGWMdS9SRYiLuFLTV
	qE2Pr8Ls1Pk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0BB6B4E4;
	Wed, 30 Jan 2013 11:47:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 43D3EB4DF; Wed, 30 Jan 2013
 11:47:55 -0500 (EST)
In-Reply-To: <20130130123420.GA3793@padd.com> (Pete Wyckoff's message of
 "Wed, 30 Jan 2013 07:34:20 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CB7DAFB6-6AFC-11E2-B602-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215031>

Pete Wyckoff <pw@padd.com> writes:

> gitster@pobox.com wrote on Sun, 27 Jan 2013 22:45 -0800:
>> * pw/git-p4-on-cygwin (2013-01-26) 21 commits
>>  ...
>>  Improve "git p4" on Cygwin.  The cover letter said it is not yet
>>  ready for full Windows support so I won't move this to 'next' until
>>  told by the author (the area maintainer) otherwise.
>
> The series is ready as is to support Cygwin platforms, and
> thus useful to people who would use git on windows via cygwin.
>
> Future work will be to add support for Msysgit.  That work
> will need much of the changes in this Cygwin series as well.

OK, so let's treat that as a completely separate topic that comes on
top after this series is done.

Thanks; will start merging down.
