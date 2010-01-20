From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] misc. msvc patches
Date: Wed, 20 Jan 2010 12:57:57 -0800
Message-ID: <7vmy081okq.fsf@alter.siamese.dyndns.org>
References: <4B57573E.2050006@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Jan 20 21:58:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXhd2-0004kF-DC
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 21:58:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839Ab0ATU6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 15:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753713Ab0ATU6L
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 15:58:11 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:32922 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753711Ab0ATU6L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 15:58:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 43E8E92E3D;
	Wed, 20 Jan 2010 15:58:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VHAZGVHpLGYpEDWhxaI7wxxp2Iw=; b=GKDpy7
	eA7olmGxYpPtdNqCe7V5xsO8yLTmjifzLMpJ5wQOapZ6R55XBkkICXhcQ0Ozd3WV
	H7gdykZikRwmrIILifFckir4PXVkN2IDV91R/nmUonWR4iJqI0kuzK2jWD30pPcW
	5Gr62cUtFkkPGXf4woISTaA+vHdTy5+FB1zUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JmFMdh+d99gADL3THF50SIz3GOMxql0G
	Zfs16Of5NjMPPhXLb14U7lRardQ97gAdM479Ab+nhMVm4gPXHF2iKDGgAvmPyccA
	EzCKhpETncer3UeAx4OBc/cxbT6LsMOT/348dzJurEneYAj72advSbrmHBaz0Utc
	OqToBNYJJXY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E98D92E36;
	Wed, 20 Jan 2010 15:58:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3872892E34; Wed, 20 Jan
 2010 15:57:59 -0500 (EST)
In-Reply-To: <4B57573E.2050006@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Wed\, 20 Jan 2010 19\:19\:26 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8085FD0A-0606-11DF-BBDA-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137578>

I only looked at regex/regex.c and it really is a real bugfix as the
structure fields are of pointer type ;-).

I'll wait for Hannes, Sebastian Shuberth and/or Marius Storm-Olsen, as
they appear in "git shortlog compat/vcbuild contrib/buildsystems", for
their Acks.

Thanks.
