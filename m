From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] submodule update: Initialize all group-selected submodules by default
Date: Thu, 21 Jan 2016 12:57:29 -0800
Message-ID: <xmqqfuxqy7k6.fsf@gitster.mtv.corp.google.com>
References: <1453260880-628-1-git-send-email-sbeller@google.com>
	<1453260880-628-4-git-send-email-sbeller@google.com>
	<xmqqr3hc3pmz.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYJJ+JxgLBqD1Y_UWACUd7yJGnU+rnwEnU6X041deftjQ@mail.gmail.com>
	<xmqqlh7jzgsx.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbHvPRa9vn7_BjiNJ+PGT3LWXZXMdTZRJmHP9bJ-_rHZA@mail.gmail.com>
	<xmqqk2n2y815.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 21:58:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMMIj-0001f1-Nd
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 21:57:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760130AbcAUU5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2016 15:57:46 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53568 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753019AbcAUU5c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2016 15:57:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6E7113C7D0;
	Thu, 21 Jan 2016 15:57:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4z7BAIPEY3IITUR5YwRzQCtKDAk=; b=UhmbcX
	aIiCsqoYwKIwhr/JWa3GPiVdin4UnB0I4nljcx3Qm3yjqlXy3fs7y7on1XHxeTUf
	f9iMT2ATLYTbG+L14xYtsJxHntQ4H9jWlrFpcZASDqrQ9+liPhRzgiGMr42/ud2K
	j3xwMJpfapAZtFMWxTxCNhOQ8CZURYXAHPm5I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JZeFws2bAKeAMs3ckC1uAQFWqQfN5VPG
	61sOKxiaT7zgugDgK2vQtlkk/YCBauzYlrp1MwIHcSgsKMeV8lKVWg+LToFVsb0u
	4LRuBjJ2B7jLB/QuFZCmRCqN6e/dHgdXA0y+lzjVhBZy7329VuaBevjw6n8igNxe
	fOJCPRS8t20=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 63E923C7CD;
	Thu, 21 Jan 2016 15:57:31 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D0AF03C7C9;
	Thu, 21 Jan 2016 15:57:30 -0500 (EST)
In-Reply-To: <xmqqk2n2y815.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 21 Jan 2016 12:47:18 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 96492EB4-C081-11E5-83B3-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284525>

Junio C Hamano <gitster@pobox.com> writes:

> Ahh, it wasn't clear that was what you were trying to do.  If that
> is the case, then ...
> ...
> So I do not think --remember-init-for-tracking is necessary.  Just
> make it _always_ on and be done with it, I would say.

By the way, I forgot to say that we're basically in agreement on
everything in your message that I didn't touch in my response.  Also
I forgot to say that I am happy to see that we are designing a new
mechanism to name a set of modules in a convenient way so that the
users can do things to them without hassle.

;-)
