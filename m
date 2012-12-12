From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 0/3] submodule update: add --remote for submodule's
 upstream changes
Date: Wed, 12 Dec 2012 10:19:32 -0800
Message-ID: <7vzk1j3zgr.fsf@alter.siamese.dyndns.org>
References: <20121204001717.GA17375@odin.tremily.us>
 <cover.1355251862.git.wking@tremily.us>
 <7vtxrr6d2f.fsf@alter.siamese.dyndns.org>
 <20121212152437.GB5157@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Wed Dec 12 19:26:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tir12-00040K-3f
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 19:26:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754245Ab2LLSTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 13:19:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51746 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752766Ab2LLSTf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 13:19:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A4A3A958;
	Wed, 12 Dec 2012 13:19:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nAdY/D/C5MW6V0bOMw1XjFFTY40=; b=vySGkI
	xIwuhb6mBVCqz2CYQbMxOoe5YMuCanVqtCIxRzBOFJF2uOW9biUYHBl2wBitJx0f
	2bebJSaXH5S9cIpe0QYI6vI/LQYXqhvWDGEGdPIjxbrvWzn2CyBF/jMxm15ysb/L
	xYIFY+L4S5R2B9WjDuSjt/X5ZZdYnJDqTmJYs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bn1LlEejLghDlGvRX7DWXk+UabCAGSCp
	O5jmkEl59L01MhpyLmxy5tQCtzoTTUOar5Op8JHuMLGnMlZ3o2ftEND0LETF3goj
	nfoXQ2breEnO4Cu/D7lkDJwv5jBTX1gSWfO1Dlt6EBQLf6oGvLpM5h/sD1mZtyz9
	o/5rP4h6wMg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16BB9A957;
	Wed, 12 Dec 2012 13:19:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 81FD0A956; Wed, 12 Dec 2012
 13:19:33 -0500 (EST)
In-Reply-To: <20121212152437.GB5157@odin.tremily.us> (W. Trevor King's
 message of "Wed, 12 Dec 2012 10:24:37 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7A7AD534-4488-11E2-951F-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211379>

"W. Trevor King" <wking@tremily.us> writes:

> On Tue, Dec 11, 2012 at 09:42:48PM -0800, Junio C Hamano wrote:
>> What branch did you base this series on?
>
> Every version of this series has been based on v1.8.0.

Thanks.

There were quite a few changes to git-submodule.sh since then to
'master' and I had to either wiggle the patch or know which exact
one 1/3 needs to be applied to in order to allow 2/3 to apply (try
applying these three to 'master' yourself---you will likely to see
that 2/3 will stop with conflicts).

In any case, I ended up applying them by editing the patches, and I
should have a good copy in 'pu'.  Please double check the result.

Thanks.
