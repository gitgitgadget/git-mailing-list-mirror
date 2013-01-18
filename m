From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question re. git remote repository
Date: Fri, 18 Jan 2013 13:38:19 -0800
Message-ID: <7v1udiqiic.fsf@alter.siamese.dyndns.org>
References: <201301161749.r0GHnGV6007806@smtpb02.one-mail.on.ca>
 <20130116220615.48c159546bccfa5b9cd9028e@domain007.com>
 <20130116182156.GB4426@sigill.intra.peff.net>
 <20130116233744.7d0775eaec98ce154a9de180@domain007.com>
 <0630A778-9AC8-4023-889C-4FC58ABAB683@gmail.com>
 <alpine.DEB.2.02.1301161459060.21503@nftneq.ynat.uz>
 <201301172153.r0HLrU4F019815@smtpb02.one-mail.on.ca>
 <1BBEF94B6B46E54980290D150A6F2EDD46B7AAE2@BN1PRD0612MB635.namprd06.prod.outlook.com> <201301181833.r0IIXNGb027544@smtpb02.one-mail.on.ca> <alpine.DEB.2.02.1301181127590.21503@nftneq.ynat.uz> <7v622uqjch.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.02.1301181320070.21503@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Lang\, David" <David.Lang@uhn.ca>,
	"'Matt Seitz'" <mseitz@mhseitz.onmicrosoft.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Fri Jan 18 22:38:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwJe7-0007QC-QQ
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 22:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881Ab3ARViX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 16:38:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44907 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750761Ab3ARViW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 16:38:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 812EFA7DA;
	Fri, 18 Jan 2013 16:38:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mL+/tQx0PT6xUyiBbmUfsSbM9SU=; b=lHOc0p
	527zysxZQY4z+GHIScAvsQ0roLV+vnfgKxgZ/Dc8K+5vWXZNcsoYUxxix8E6wuRf
	nZ1raD4I5zBVqHrgpsCIIm9ed2p2UaZFFjjXZ+vrH/3epiN1E0490n/vLzc5+1rI
	Ac8HUtoDMfcWLJrT2b38IqunU5WPYtlTZ5Dt0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ceHklSOnsk/QMoHh0YlcWXf/aK+3qV9F
	npcrqL680WA1fu/0ohnAoI9fasqQnKynFzJTT314d/LDmIhCqt51rKwOWkMc/ZAA
	w9Hkgr4S40cChP0PWhUa+b4gh4TqKzROgxQmi6oCfYrnptGX2Jm4HzIRK9T5vfn1
	CBL1ANIrCbc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75A5CA7D9;
	Fri, 18 Jan 2013 16:38:21 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2A62A7D2; Fri, 18 Jan 2013
 16:38:20 -0500 (EST)
In-Reply-To: <alpine.DEB.2.02.1301181320070.21503@nftneq.ynat.uz> (David
 Lang's message of "Fri, 18 Jan 2013 13:27:55 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 60FE26A0-61B7-11E2-B2E3-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213940>

David Lang <david@lang.hm> writes:

> On Fri, 18 Jan 2013, Junio C Hamano wrote:
>
>> David Lang <david@lang.hm> writes:
>> ...
>>> developers then do their work locally, and after a change has been
>>> reviewed, pull it into the master repository.
>>
>> s/pull it into/push it into/; I think.
>
> fair enough, I always think in terms of pulling from feature branches
> into the main repository so that any merge conflicts get resolved. I
> didn't describe this clearly enough.

If you are assuming that the "main repository" has a working tree
and somebody goes there, runs "git pull" and manually resolves
conflicts, that may be asking for trouble down the road. It may be
sufficient for two-person group as long as they coordinate among
themselves so that only one of them uses that working tree at the
"main repository" at a time.

But in general, it is more common to have a bare repository without
any working tree as the "main repository", let a push that conflicts
fail, and have the pusher fetch from the "main repository" and fix
up the conflicts in his working repository before he tries to push
the cleaned-up result.  That gives the pusher a chance to re-test
the result of integration with what he did not see while he was
developing what he attempted to push.

"pull" and "pull -rebase" are two ways to do that "fetch from the
'main' and fix up" step.
