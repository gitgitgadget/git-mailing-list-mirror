From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add a git-completion rpm subpackage to the spec
Date: Sat, 20 Mar 2010 13:12:34 -0700
Message-ID: <7v8w9mda6l.fsf@alter.siamese.dyndns.org>
References: <1269045134-28072-1-git-send-email-icomfort@stanford.edu>
 <1269109086-8887-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Sat Mar 20 21:12:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt52P-0007pI-G5
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 21:12:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609Ab0CTUMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 16:12:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35628 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808Ab0CTUMo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 16:12:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B86E8A3F37;
	Sat, 20 Mar 2010 16:12:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xNKcvxiKqwpputd8Mwb1ksepE5Y=; b=yJ9I5g
	23TllRpRiA8QuM9k0EHEE53YseZhGQfJrHmoQgwgsx8WKeTkzwHbGGkoDlweXVwO
	Kt1kakiE34rN5m4yLnNbm41luBiNq3Q2HUy+2/9Vd8pUzuuIB3SLXihyXTiDIKGs
	6QbF0ewZGf6tx84bktxBYhfNhDlnW+J/PyOFI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hbF0aqwMzymXJAVW+ST5DH1P5WCXuGpm
	XakVKtJPbEBn2DbAaEOyFMdGADVQum3+LiMW0Wi82jwXFs/b3+hN5Hl7LtLED92A
	WZekGj67YSB49RjFFEiUBnESiPV1PbP6C/wgwgLljioNooSp2MRWQl8FDSYP2yht
	Yh+lxe6eqEI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B1B2A3F35;
	Sat, 20 Mar 2010 16:12:39 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 36C6AA3F33; Sat, 20 Mar
 2010 16:12:36 -0400 (EDT)
In-Reply-To: <1269109086-8887-1-git-send-email-bwalton@artsci.utoronto.ca>
 (Ben Walton's message of "Sat\, 20 Mar 2010 14\:18\:06 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EED44832-345C-11DF-A6D7-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142744>

Ben Walton <bwalton@artsci.utoronto.ca> writes:

> Make the rpm spec file create a git-completion subpackage that
> contains the bash completion support from the contrib/ directory.
>
> Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
> ---
>
> This is the alternate method for shipping the bash completion support.
> I think I personally prefer this method, but I'd be happy to see
> either solution ship as part of the .spec file so that I don't need to
> continue handling it separately.

As long as %{_sysconfdir}/bash_completion.d/ is the appropriate place for
*all* RPM based distros, which I don't knonw, the patch looks sensible.
May I ask for what distribution you are "handling it"?  The last thing I
want to do is to get in the way of distro packagers.

I looked for "gitcompletion" or "git-completion" in rpmfind.net, but
didn't find anything, which may actually be a good sign that whatever we
do here won't stomp on whatever distro package maintainers would do.
