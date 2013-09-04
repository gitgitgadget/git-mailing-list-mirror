From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2013, #01; Tue, 3)
Date: Wed, 04 Sep 2013 12:19:38 -0700
Message-ID: <xmqqfvtkmm2d.fsf@gitster.dls.corp.google.com>
References: <xmqqppspo6i7.fsf@gitster.dls.corp.google.com>
	<vpq7gew6c0v.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 04 21:19:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHIcK-0000Lr-UY
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 21:19:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757042Ab3IDTTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 15:19:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39709 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752987Ab3IDTTs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 15:19:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4BBA3F585;
	Wed,  4 Sep 2013 19:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=raPQL9MbAUw4GavjCTuJa6URTSg=; b=rNbXEx
	9jNx4VM92aEDqePK4Kq7Mp1OuOrO8dH0Qm0Snt5AJXoGHchptnLwdX3BurGijQfR
	lqneBMpuHx1PFLROupqpbFtX5mCycY96OQKKgiY5R1jeIuxtvxdwh0HJRsl1RFFT
	O9w9nZm2yflGVgs945CDL4jOdcBdrZEOLleLg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LqiMByscz6XtIyh+wXdxVVg4y4ppdwYC
	RYbTPUt8uox5HdrtcZ7FWWPfkXFCsKCzcwr7UK0qR9T9moaRKjJhDIlQwD8srp0g
	eObRC4motbiwcaCapMP+67GC4p95qZL0CU41JwYFUu8EjmxGRjP0uN6Y0v0dUN9f
	pFjbNtSBAhY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B83E3F580;
	Wed,  4 Sep 2013 19:19:44 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 912563F570;
	Wed,  4 Sep 2013 19:19:41 +0000 (UTC)
In-Reply-To: <vpq7gew6c0v.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	04 Sep 2013 13:50:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F35C890E-1596-11E3-8299-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233867>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * mm/status-without-comment-char (2013-08-29) 5 commits
>>  - status: introduce status.displayCommentChar to disable display of #
>>  - SQUASH: do not fprintf() random strings
>>  - get rid of "git submodule summary --for-status"
>>  - wt-status: use argv_array API
>>  - builtin/stripspace.c: fix broken indentation
>>
>>  Allow "git status" to omit the prefix to make its output a comment
>>  in a commit log editor, which is not necessary for human
>>  consumption.
>
> I'm waiting for the situation of "git submodule --for-status" to be
> settled to send a reroll. Don't merge this for now, and let
> bc/submodule-status-ignored converge.

Thanks.  I had an impression that bc/submodule-status-ignored was
still being discussed.  Has what I have in 'pu' settled?
