From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git issues/bugs - is there an alert process?
Date: Mon, 23 May 2011 15:21:23 -0700
Message-ID: <7v62p1ukgs.fsf@alter.siamese.dyndns.org>
References: <1306172653284-6395510.post@n2.nabble.com>
 <20110523212150.GF6281@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: funeeldy <Marlene_Cote@affirmednetworks.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 24 00:21:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOdVK-00019P-KS
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 00:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030494Ab1EWWVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 18:21:33 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34679 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030378Ab1EWWVd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 18:21:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4DC36467C;
	Mon, 23 May 2011 18:23:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i1tbrJFP05Dk/MtwJTI7vj2d/0c=; b=ITGZ3r
	JmyOfTZu2I5n0DnZOCxmIQDGde/IKaFwTQCP6BoFKP1iPLlVCAtWjoNI6u8I3cTW
	KUs5kjcVURhjdMLDLkHPYwbQFFiTafoIynrewQ0V7VtWz9Y0XTeErgR/2d/Mqd03
	yD7+fcHIY2M4fjlePRFnlH8BLuYT10hIqMMUU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WdOl12g6Qh9OIo6fxTG3B8mSpZXeNuLW
	oI4IEG9gHUXpcLMPlQs9C2McjSBBeMc5pJgpZ98+F3WSFdcV+qbE+28hQMmOKrxu
	N5J76yCNw4JceYbOe/Ojm9TZYUyQPuEN3ruOYUoecs1fh3Tum872P0E7AgZ2bbiz
	CLF2o3ijRiw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1627F4679;
	Mon, 23 May 2011 18:23:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F0A624678; Mon, 23 May 2011
 18:23:32 -0400 (EDT)
In-Reply-To: <20110523212150.GF6281@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 23 May 2011 17:21:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4D9B2A7C-858B-11E0-A9ED-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174283>

Jeff King <peff@peff.net> writes:

> On Mon, May 23, 2011 at 10:44:13AM -0700, funeeldy wrote:
>
>> Is there any way for me to sign up to get alerts for serious bugs discovered
>> in a version of git?
>
> You can read the release notes; minor versions are always bugfix
> releases, and important bugfixes are backported to them. If you read
> only the [ANNOUNCE] messages on git@vger, you will see new releases.
>
> I seem to recall we have an announce-only mailing list, and somebody set
> up an rss feed, but I don't remember the details. Maybe somebody else
> does, or you can find it via google.

Well said.

Also it seems that we haven't had a need to alert for serious bugs that
often ;-). Certainly this particular one is not a "serious" bug, but
merely a failure in tutorial documents at most.

I am however worried about the rate we see minor regressions on 'master'
post 1.7.5, which seems to suggest that people on this list are getting a
bit complacent than they should be and perhaps not testing 'next' but are
on 'master'.

The promise of 'master' always being more stable than any released version
depends on competent testers and users using the 'next' version for their
day to day work.

Thanks.
