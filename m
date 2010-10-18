From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t0003: properly quote $HOME
Date: Mon, 18 Oct 2010 12:15:30 -0700
Message-ID: <7veibn48j1.fsf@alter.siamese.dyndns.org>
References: <decc39532e1706c50964bad14c51d0bcd9ab09a6.1287342744.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Petr Onderka <gsvick@gmail.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Oct 18 21:15:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7vBZ-0001B0-Mz
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 21:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126Ab0JRTPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 15:15:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47827 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756092Ab0JRTPn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 15:15:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BB13ADFC75;
	Mon, 18 Oct 2010 15:15:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zrWXlWxSV82yOmO42TjX3ZfuFjA=; b=J1G9YG
	NY3EqS0wDbOK9mzs07qfmTGvCzbFo8b+H2JQeZ1F14IYkgz2pIVLkBugVP2ZXYoM
	N1VkCH8bvW8u4EPXuWyebbkAoN8vdJiNL/pcYBFzz+5Zxt9HEq4Hx3U5MYLscc1Y
	lYjSso0VBVCqUnaLocn2BTguTJzs7Q5FHZeYc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XlerZHuIMJiVLrEm/D/g1naMjfN9thlA
	8Z8R+UKRQ8MuzNTaqH4L11UXHkbhggBJJSeuL0ieCFAQe0BLQoHUFp9ITan5ruoZ
	sIvLf3C6Vtc/0zw9/cq9aLdtGnOq5GuZNnJLB0biA3uvKBOsEYtRBgNs5Lc5OGKS
	TBwkgAyZZj0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 89FB9DFC71;
	Mon, 18 Oct 2010 15:15:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A41CCDFC6F; Mon, 18 Oct
 2010 15:15:32 -0400 (EDT)
In-Reply-To: <decc39532e1706c50964bad14c51d0bcd9ab09a6.1287342744.git.trast@student.ethz.ch> (Thomas Rast's message of "Sun\, 17 Oct 2010 21\:13\:53 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 16E0DF62-DAEC-11DF-801D-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159282>

Thomas Rast <trast@student.ethz.ch> writes:

> 6df42ab (Add global and system-wide gitattributes, 2010-09-01) forgot
> to quote one instance of $HOME in the tests.  This broke the test for
> me with the shell complaining about an ambiguous redirect (but only
> when run with --root for some reason).

Sounds like a similar breakage to what was fixed in 3fa7c3d (work around
an obnoxious bash "safety feature" on OpenBSD, 2010-01-26) to me.

Thanks.
