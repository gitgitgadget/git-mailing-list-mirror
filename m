From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2014, #02; Mon, 7)
Date: Tue, 08 Apr 2014 11:46:02 -0700
Message-ID: <xmqq38hn4q39.fsf@gitster.dls.corp.google.com>
References: <xmqqmwfwlr4f.fsf@gitster.dls.corp.google.com>
	<53444156.8020800@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Apr 08 20:46:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXb2G-00054w-9k
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 20:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757461AbaDHSqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 14:46:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62327 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756960AbaDHSqF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 14:46:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDB8A7965B;
	Tue,  8 Apr 2014 14:46:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MR2O22X8BXAOcCypsZWYBuHQqg4=; b=nIJt6j
	mHETAfaBN143gVRQv7SmCUtn2QDK1uOp/pQbaQG/t3PEQ+JuAlYYuxitTNzy7435
	AQmAK3vJWAqDZaZQD/OMNTcEJTVZ0Nn4A6PH0z1C13TqdGvd7DvmhKI2ml0ksObV
	wMFl0hj3BQSb5ZstMm8rKRDYwobOs8KDNJ9PQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xCQwGNg8u+6rSx/J9KBL6wpoE/bvm+tX
	Vw/yT1CmQAx3CvPCjzJRyngQpIm9rvrHLBiyKt6wZ3HQI172aRkmfNM5cMc1VSB9
	GKAHz0FAzyNHVJj86ZhGwYeDCocI26SmWu3GkXHWltBHDyP8KtHIFVxlb+tjLK4x
	zPQ3Il/JwlY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C86BD7965A;
	Tue,  8 Apr 2014 14:46:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF67679659;
	Tue,  8 Apr 2014 14:46:03 -0400 (EDT)
In-Reply-To: <53444156.8020800@web.de> (Jens Lehmann's message of "Tue, 08 Apr
	2014 20:35:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 096629CE-BF4E-11E3-ADB3-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245947>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 08.04.2014 00:19, schrieb Junio C Hamano:
>> * jl/status-added-submodule-is-never-ignored (2014-04-07) 2 commits
>>  - commit -m: commit staged submodules regardless of ignore config
>>  - status/commit: show staged submodules regardless of ignore config
>
> I have two more patches for gitk and git-gui doing the same there,
> me thinks it would make a lot of sense all four make it into the
> same version. Should I wait until this topic hits next (or master)
> or does it make sense to send them to Pat and Paul right away?

Either would be fine, but I suspect they would appreciate it sooner
rather than later, if only as an advance notice.

How do these two relate to and/or interact with what Ronald and you
have been discussing, by the way?
