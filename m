From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Documentation/git-diff.txt improvements
Date: Mon, 29 Apr 2013 09:33:35 -0700
Message-ID: <7v38u9l2jk.fsf@alter.siamese.dyndns.org>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
	<CALkWK0nVZHwSMS_gtisiAguNhAMnDpdWmAtz_OgzP93YZtYfHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 18:34:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWr1d-0005nC-NW
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 18:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758357Ab3D2Qdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 12:33:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52237 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758347Ab3D2Qdi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 12:33:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A72819CAD;
	Mon, 29 Apr 2013 16:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=7rpq/RfWaaIr8xzLkbjfQ1kHPio=; b=xhGNhXPvZBq3pvTGef9A
	cuMZMLZcBt6meO+La+mSdjcMvW7BITBF1rZruD986pETgXA+BToKiL0mVKrrkd5m
	RZpnSTFsUjX/KtMehr5rWuh5+UaQUGu8YYsDFvMpo4dowiQsWLpLqMDJmaL1/phd
	kThPasOhhHzF+eZBM54cKhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=PPOaA3Eu9kR13QK67LQg1KZQCEmoE5YKrOaV+n4Kr18ArX
	+TiVcEYhPAIfJsMfCpxi50zdtHIOiMfMZu/fCYAgUhj9MRj9sVI/Z5egt5axXMMl
	oD07duPAs7Pyx79q5LR4+jSGNUwF3WYoalOx5uB468387dvyiwr5T7mEeweQA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E91519CAC;
	Mon, 29 Apr 2013 16:33:38 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89EFE19CAB;
	Mon, 29 Apr 2013 16:33:37 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8B051116-B0EA-11E2-BD5E-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222810>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> So, I decided to drop everything and just submit the first two parts.
> Until we can decide what to do about the '<commit>..<commit>' and
> '<commit>...<commit>' forms (new rev spec? overload existing rev spec
> to change the meaning? deprecate without a viable alternative?), let's
> leave them as it is.

I had an impression that many of them, with the suggested fix-ups,
were improvements, with or without the A~B discussion.  It seems
that the entire review wasted many braincycles if you are to drop
the ball at this point, which is very dissapointing.

> Nothing to resubmit.  Junio: can you just queue the first two parts?

I do not appreciate "Nothing to resubmit".  [1/5] needs fixes to the
issue Jonathan pointed out, doesn't it?
