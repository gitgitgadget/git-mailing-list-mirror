From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] improve "git branch --contains=<commit> <pattern>"
Date: Thu, 31 Jan 2013 07:53:00 -0800
Message-ID: <7vpq0lic2r.fsf@alter.siamese.dyndns.org>
References: <679787987.uZRbjA7AMj@al>
 <20130131064357.GA24660@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Wu <lekensteyn@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 31 16:53:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0wS7-0003is-Nh
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 16:53:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734Ab3AaPxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 10:53:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37050 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751264Ab3AaPxD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 10:53:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0AFAC616;
	Thu, 31 Jan 2013 10:53:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JbI+Unixdyz26MEwPSEtJVGSDi4=; b=dTv+12
	nJ2MDKMRCki4+gyGP/bfztWYRceecJIZMmLuI3odo+BrWogYwi0mDZ419x92Vqbt
	JZRNe4sNjeONHxX07dyTnXbVD74L1Joef39JZ6MWMQtoMVv15eW/uRTmxwdCyl2S
	zq/yn3OD3VdF4Bwwz7wfPdRtlDOk6IIrlMib8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bVLAs3uXqpdoMQRy+DpvVPB/KbMcddN2
	38xzK3HVqZhEHXV/lMfbDh81h5h4PrQ+Fc6pnXyypyE8Y3aCRdx7kK9d0tpM9cBb
	SRdOpnfixiFMQe6Fs+A82Yr8tApyIHwJVd4kM3XOU/IRIrJ0C6+eV8tzHzEtQb44
	BgDIXasBXNo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68A5FC606;
	Thu, 31 Jan 2013 10:53:02 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C05EDC5FD; Thu, 31 Jan 2013
 10:53:01 -0500 (EST)
In-Reply-To: <20130131064357.GA24660@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 31 Jan 2013 01:43:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4AD4CF26-6BBE-11E2-B5E1-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215120>

Jeff King <peff@peff.net> writes:

> That being said, we could be much more helpful. It seems like --contains
> should imply listing mode, since it is nonsensical in other modes. The
> second patch below adjusts that, and makes the command above do what you
> expect.
>
>   [1/2]: docs: clarify git-branch --list behavior
>   [2/2]: branch: let branch filters imply --list

Thanks.  Looks good.
