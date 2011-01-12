From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4: correct indenting and formatting
Date: Wed, 12 Jan 2011 01:04:26 -0800
Message-ID: <7vlj2q3339.fsf@alter.siamese.dyndns.org>
References: <1294808703-1848-1-git-send-email-andrew@andrewgarber.com>
 <7vsjwy33zn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Garber <andrew@andrewgarber.com>
X-From: git-owner@vger.kernel.org Wed Jan 12 10:04:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcwdN-0000XL-4d
	for gcvg-git-2@lo.gmane.org; Wed, 12 Jan 2011 10:04:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753457Ab1ALJEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jan 2011 04:04:43 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42490 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924Ab1ALJEk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jan 2011 04:04:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DA13E263C;
	Wed, 12 Jan 2011 04:05:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p5VwJRv74oafgerrSFJsEAmtz6k=; b=cUJkjp
	G+6EFmSHamdMb0CmwfTcboLyfc0+MyOcrNYk/8shBzQ3wyJ+0dRW0fEN2P89E/xW
	/ardSIQekYET1L343BwwU+Kb7D320o3edYVEpDEVJKCLoZSAR5Y2H/Tso3RZfaTF
	MVb9hZpcVRMJ/HflcKO6l9gBs0U7xboa4Voi0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lxN9804VQfLw5bzd1WbcWgxXyu8r1S0G
	/9eV4JRVmISd+cLHQ5qHBNzI9cxuB5iHgxJnPAA50AoFzThz3dWuRcZ0IpU6qB2I
	PRrDK4zTAHL0rDCTLHzltCXSzKrxOA2r+rX5kL/sGq1EyMtNno3TKd+p6SYvJ/vX
	FliIM/iP5zc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A432F263B;
	Wed, 12 Jan 2011 04:05:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A05FB263A; Wed, 12 Jan 2011
 04:05:14 -0500 (EST)
In-Reply-To: <7vsjwy33zn.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 12 Jan 2011 00\:45\:00 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 133D5A66-1E2B-11E0-A6FF-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165007>

Junio C Hamano <gitster@pobox.com> writes:

> Andrew Garber <andrew@andrewgarber.com> writes:
>
>> - replace tabs with appropriate number of spaces
>> - minor tweaks to code formatting
>> ---
>>  contrib/fast-import/git-p4 |   71 +++++++++++++++++++++-----------------------
>>  1 files changed, 34 insertions(+), 37 deletions(-)
>
> Sorry, but in git codebase, tabs are 8-place indent by definition, and I
> don't see much merit in this patch, other than being religious about
> somebody else's coding style, which would matter only if we are trying to
> get this included in "batteries included" set shipped with Python
> distribution, perhaps.
>
> A downside is that this patch will make life harder for people with
> private patches to git-p4 that they haven't shared with us.

Sorry, I obviously was not paying attention to the patch itself.

The file already mostly follows the Python convention to use only SP and
you are fixing some oddballs that have HT instead of typing 8 SPs out to
make things consistent.

I don't see any problem with that kind of change.

Will queue on a separate branch for you, expecting that you are doing this
in preparation for a new feature or a bugfix to the script.

Thanks.
