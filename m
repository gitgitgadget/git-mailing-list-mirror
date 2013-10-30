From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/7] Documentation: put blame/log -L in sticked form
Date: Wed, 30 Oct 2013 12:37:43 -0700
Message-ID: <xmqqa9hqbldk.fsf@gitster.dls.corp.google.com>
References: <21f40508f83a9407986d29f002adf5ad366c8b88.1382287779.git.trast@inf.ethz.ch>
	<c41aef218951f8b0ec6a20e1dbc39712ad13afce.1383031141.git.tr@thomasrast.ch>
	<xmqqvc0fd0la.fsf@gitster.dls.corp.google.com>
	<87bo27i85i.fsf@linux-k42r.v.cablecom.net>
	<xmqqiowed6t3.fsf@gitster.dls.corp.google.com>
	<874n7ywpnd.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Wed Oct 30 20:37:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbbaR-00022Z-58
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 20:37:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754204Ab3J3Thr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 15:37:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43019 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753261Ab3J3Thq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 15:37:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58A4E4CDAE;
	Wed, 30 Oct 2013 15:37:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o3v3ir05yfstG9bMRhOhEJvRhpQ=; b=ZAph9C
	C4hZgRxzqcPOzrQpI7NDWy8srt8qgdfCapWVMVbbvNx5tG7oecuBAMDzSMJcSRRD
	AcKP6DAzaIWYasJDHfmpmF816Xcc4Fe2PHqWagDuEN/iXy3C+3U9wxe2HGlxp096
	WG01oQ1apOLiwZhv9qp7Xw4pHb6hiPcrVEKkk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LSknnUCaEacY3113Dm4kl0dCdYbFNaPS
	bn2xd5pCAmRCGMZexDuIpWpwmwVJRRmB9arJgWON9Nw2zyyGtm+RzkNwv1jgj9yQ
	4sG2tBiFmMz1GMGi7ZbNT287i033LjosgmqXUyUB8+Cr9f9I2S5d2geede8tcbhv
	a54oYs2x/uk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B7C64CDAD;
	Wed, 30 Oct 2013 15:37:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AAF084CDAB;
	Wed, 30 Oct 2013 15:37:45 -0400 (EDT)
In-Reply-To: <874n7ywpnd.fsf@thomasrast.ch> (Thomas Rast's message of "Wed, 30
	Oct 2013 19:59:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C03ACAEC-419A-11E3-AF00-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237061>

Thomas Rast <tr@thomasrast.ch> writes:

> So my short-term plan just became: document instead of fix; clean up
> manpages towards the stuck form for long options; have gitk only parse
> -Lstuck.
>
> Medium term we can move gitk to a different option parser, resolving at
> least that inconsistency.
>
> Longer term we can see about moving some more of the remaining craziness
> towards parseopt, getting consistency for free.

In that sensible context, the patch sounds in line with the
short-term step.  Thanks.
