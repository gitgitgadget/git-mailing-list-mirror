From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4: correct indenting and formatting
Date: Wed, 12 Jan 2011 00:45:00 -0800
Message-ID: <7vsjwy33zn.fsf@alter.siamese.dyndns.org>
References: <1294808703-1848-1-git-send-email-andrew@andrewgarber.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Garber <andrew@andrewgarber.com>
X-From: git-owner@vger.kernel.org Wed Jan 12 09:45:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcwKQ-0007wo-GQ
	for gcvg-git-2@lo.gmane.org; Wed, 12 Jan 2011 09:45:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754660Ab1ALIpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jan 2011 03:45:10 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56382 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083Ab1ALIpI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jan 2011 03:45:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 338D024D4;
	Wed, 12 Jan 2011 03:45:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PmxNj8ZLdRiFLe9aoQfe43m04BI=; b=EASMNE
	LpqbT2HzkwWz13vYo258g6jvwFCs/mybvtsF5IZsleyIWZPFBzkN8Zxv6uxofupv
	Ev0yt5KXgkVhyMogtBPAaBsvs+mdc455ls41Cl1fsdqHn7gSE2hVqDelDu+7POCX
	hcq5GXke6CaTT4vbcm2OjGpNfrZbez5J2PUz8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mByvEhRacJoI4BHOssGArdxH9IayZHZS
	Lw9+ffD7t+4fpGihP+8pyT//6rALPt3A56uQrnpkjxMmbdCVOpoQHxJhJFOQGjVc
	cNGPI4eaWeW0Vy3hsJktYZvveJMEkhVA/pQPbGDr0VfxypZyxvtn5QAvgcYr4UKF
	cMuYv55vtJo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0EEA924D0;
	Wed, 12 Jan 2011 03:45:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1677C24CF; Wed, 12 Jan 2011
 03:45:43 -0500 (EST)
In-Reply-To: <1294808703-1848-1-git-send-email-andrew@andrewgarber.com>
 (Andrew Garber's message of "Tue\, 11 Jan 2011 21\:05\:03 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 597D5394-1E28-11E0-81A6-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165006>

Andrew Garber <andrew@andrewgarber.com> writes:

> - replace tabs with appropriate number of spaces
> - minor tweaks to code formatting
> ---
>  contrib/fast-import/git-p4 |   71 +++++++++++++++++++++-----------------------
>  1 files changed, 34 insertions(+), 37 deletions(-)

Sorry, but in git codebase, tabs are 8-place indent by definition, and I
don't see much merit in this patch, other than being religious about
somebody else's coding style, which would matter only if we are trying to
get this included in "batteries included" set shipped with Python
distribution, perhaps.

A downside is that this patch will make life harder for people with
private patches to git-p4 that they haven't shared with us.
