From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-* in hook scripts
Date: Tue, 23 Feb 2010 16:32:20 -0800
Message-ID: <7vr5obxyln.fsf@alter.siamese.dyndns.org>
References: <m3hbp7x673.fsf@winooski.ccs.neu.edu>
 <20100223235941.GG12429@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eli Barzilay <eli@barzilay.org>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Feb 24 01:32:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk5B5-0003UY-9A
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 01:32:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753886Ab0BXAc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 19:32:29 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37354 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945Ab0BXAc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 19:32:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 895999C9F9;
	Tue, 23 Feb 2010 19:32:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lHa/pSU7ox22t0raY7UnZKVEpVs=; b=ir1hcf
	c50Lc7Hvcq3AXrUllkiZpifEuQWt4TOjnIcHMLNA7GJmMLl0Gu5ob4cdCyKer+1u
	MlNGetMa4eXGQ0qj0MFrQ4MOkvHivPZXNMalMu3FpQtQrvkuEuEycRaJSS1VEnHy
	d93V46VGqRAR8hNV8uu0wlTjG0TM/mU0PURcs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZkdcAfSb0ItLNH4rUtSz5HQ2CY45tGGA
	ArYDEFR/+XdVqgY7LWtiTNfbEUmFz82NNx3ZgtT80DmcoqO3OiDq+cMFbBSvLNqH
	9offwvYFfei9tMNID4Mh7HkGHYBCUfYxJWP0f/XL3L+HI8Nh+iT4wBhNu84T1YYG
	VPZTQamK64I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FA8A9C9F8;
	Tue, 23 Feb 2010 19:32:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8BCA89C9F4; Tue, 23 Feb
 2010 19:32:21 -0500 (EST)
In-Reply-To: <20100223235941.GG12429@genesis.frugalware.org> (Miklos Vajna's
 message of "Wed\, 24 Feb 2010 00\:59\:42 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 147B1046-20DC-11DF-99DA-E038EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140882>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Tue, Feb 23, 2010 at 11:33:36AM -0500, Eli Barzilay <eli@barzilay.org> wrote:
>> There are several sample hook scripts that use `git-*' -- should these
>> use `git *' instead?
>
> No need to do so, `git --exec-path` is already in PATH when those
> scripts are invoked.

We have been waiting until nobody remembers days we had dashes.  It may be
a good time to at least start thinking about updating them. v1.6.0 is one
year and half old.
