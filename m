From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] remote.c: introduce remote.pushdefault
Date: Wed, 20 Mar 2013 11:53:44 -0700
Message-ID: <7vk3p1ewcn.fsf@alter.siamese.dyndns.org>
References: <1363783501-27981-1-git-send-email-artagnon@gmail.com>
 <1363783501-27981-6-git-send-email-artagnon@gmail.com>
 <20130320183255.GL3655@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 19:54:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIO9V-0001Lt-Mi
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 19:54:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755297Ab3CTSxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 14:53:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37354 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751381Ab3CTSxy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 14:53:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2BD0A76A;
	Wed, 20 Mar 2013 14:53:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nCrUgNbHXmO56dGaRJ72oCMdgWo=; b=VDn5qf
	vRCAqg5miUZ4LMLOtnCripnoo2NNSkYMH9niyTIoTgwvPyPpeNl1qFZUjHKUEv9G
	Nq+mnnKtOLlBN7MvOR44aRBlxtncWgPvKxI5I40et8FJxUbtGCK/9uinV9aOIzlm
	Ouqz+uhptyJ+csD9CO8CLKFQlS1E3s8QIgTj8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n3trjBZd6w6fabQ0AW/YZs8JvK7/JOqw
	gktRXfxHtrfpwRy52NxRG4kA34zuoq0co/k5AUjarDy+6uaj3HUe+91RhW4iqkhU
	oHdXrF5icOKxhRngX9nr/n+M/GwlgoTgOjhyUF35J8lEt9ELbfPXHMusYxFCLJkv
	WaBJP6+dWDc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 918F0A769;
	Wed, 20 Mar 2013 14:53:53 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC540A760; Wed, 20 Mar 2013
 14:53:52 -0400 (EDT)
In-Reply-To: <20130320183255.GL3655@google.com> (Jonathan Nieder's message of
 "Wed, 20 Mar 2013 11:32:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 827AAA80-918F-11E2-89AE-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218654>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Ramkumar Ramachandra wrote:
>
>> This new configuration variable defines the default remote to push to,
>> and overrides `branch.<name>.remote` for all branches.
>
> Micronit: I think this would be easier to explain if it came after
> patch 6, since then you could say "In other words, it is a default for
> branch.<name>.pushremote for all branches" and readers would not have
> to wonder "Why does the more generic configuration override the more
> specific one?".
>
> My two cents,
> Jonathan

Thanks for all good comments (not only to this one but to others in
the series).  I agree with all of them.
