From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Do not create commits whose message contains NUL
Date: Wed, 14 Dec 2011 19:09:18 -0800
Message-ID: <7vobvapm3l.fsf@alter.siamese.dyndns.org>
References: <1323777368-19697-1-git-send-email-pclouds@gmail.com>
 <1323871699-8839-1-git-send-email-pclouds@gmail.com>
 <1323871699-8839-4-git-send-email-pclouds@gmail.com>
 <CADCnXoaqEXJV+Mb1=nQge_bjA3H6R7=BPt213CKLX55zyTHEtg@mail.gmail.com>
 <20111215011855.GA24568@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miles Bader <miles@gnu.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 15 04:09:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rb1hF-0006MR-EB
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 04:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758616Ab1LODJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 22:09:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58301 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758599Ab1LODJU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 22:09:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 24EFF6EB4;
	Wed, 14 Dec 2011 22:09:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f6rLdCtlDXO12BhIsX87awTgF54=; b=q8mRSO
	KhtrTLY59219b9/pOFX2yzbebNr5zHou+gilhqHYGkUYlYC95liEqdmxde4vONgw
	O/mDXZjQlW3g9JbiEOEuBDfejDXWit1mVOifPwVmFRHrCdkCIL/0PWGTugI0mrRC
	k6p/DXDr5U+5G0G1xh8YTpnUxO3x1U1ff0CIc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QaB3piTO7LGndfg0ll0gUsdaac+FUZYC
	OQj6Xr4kC4ud9gpILJHsz2LJnylvqsSUfy9J4HdfUMTowI74fziGSi6HOjmvSn0b
	pvMzDrt+hnUwzMpMOIUuV2vAUrPyunPCJcK6N+6WpYIr9BUFEFNsUzgE72kfVNhp
	AQ1EJS8TYFo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D0786EB3;
	Wed, 14 Dec 2011 22:09:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A9A856EB2; Wed, 14 Dec 2011
 22:09:19 -0500 (EST)
In-Reply-To: <20111215011855.GA24568@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 14 Dec 2011 20:18:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2E220928-26CA-11E1-B0F5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187185>

Jeff King <peff@peff.net> writes:

> Perhaps it should just be dropped.

Thanks. I have nothing to add---you said everything that needs to be said.
