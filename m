From: Junio C Hamano <gitster@pobox.com>
Subject: Re: warning in git version 1.6.6.rc0.114.gc8648
Date: Wed, 02 Dec 2009 09:50:40 -0800
Message-ID: <7veindgt8v.fsf@alter.siamese.dyndns.org>
References: <hf67m0$r10$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alejandro Riveira <ariveira@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 18:51:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFtLo-0006jI-Uz
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 18:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755081AbZLBRul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 12:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755018AbZLBRul
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 12:50:41 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48825 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754897AbZLBRul (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 12:50:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2540E84224;
	Wed,  2 Dec 2009 12:50:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ww+j6u2vWFithy4j/a6rQR/gIHY=; b=fdwFcI
	SY2oKNx3xoJu0w9DsNMvjft1DVsdlNgDqng4FoF/g8k/tyjfnUxI6WfNapirgQDR
	LVQk5U76bi0vZ4/2fSVVqGFcrzkFMeGz3n3iEmRxNHmm+AcmKwNr5vUFuTaedNd4
	wdRSIg34MEyoZMQ4/HjDqKCFjtiysSmpxylug=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JHlzUcmp36EDk9mJS65hjEDsOYjPEFnC
	N11BsfgQnTIEYHG053sH4jbHPwJJp6bT7ma6JsbF99M845AYgIB6E2RPARK7pRsy
	iYEHcV6WE4X14ADPaPS67qpmEQUhwrULG9JmcTacWqkZdsrq7Oo7hA4Ff35AFvP5
	wKLMz/05XbY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 05B0484223;
	Wed,  2 Dec 2009 12:50:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 696EA84222; Wed,  2 Dec
 2009 12:50:42 -0500 (EST)
In-Reply-To: <hf67m0$r10$1@ger.gmane.org> (Alejandro Riveira's message of
 "Wed\, 2 Dec 2009 17\:21\:04 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 374C2248-DF6B-11DE-BE82-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134362>

Alejandro Riveira <ariveira@gmail.com> writes:

> Whenever i do a "git pull" to check updates to the kernel
> or git repo i recieve
>
> warning: 'git merge <msg> HEAD <commit>' is deprecated. Please update
> your script to use 'git merge -m <msg> <commit>' instead.
> In future versions of git, this syntax will be removed.
> Already up-to-date.
>
> git pull should be updated to not use a deprecated form of git merge.

Yes we are aware of the issue and have a patch to do so which requires
another change which we also already have patch for.  It will be fixed
before 1.6.6-rc1

Thanks for reporting.
