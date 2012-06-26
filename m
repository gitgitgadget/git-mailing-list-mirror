From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] rebase -i: support --root without --onto
Date: Tue, 26 Jun 2012 14:24:07 -0700
Message-ID: <7vwr2tahs8.fsf@alter.siamese.dyndns.org>
References: <20120626133339.GT9682@arachsys.com>
 <bdb45972685db8899a46ebc62213e56c9a3d0c94.1340717793.git.chris@arachsys.com>
 <7vtxxxc22x.fsf@alter.siamese.dyndns.org>
 <20120626193817.GD30779@arachsys.com>
 <7vfw9hbzz5.fsf@alter.siamese.dyndns.org>
 <20120626201155.GE5864@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 23:24:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjdFC-00065J-IY
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 23:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753634Ab2FZVYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 17:24:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36723 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752054Ab2FZVYN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 17:24:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 136899484;
	Tue, 26 Jun 2012 17:24:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zalwABmWnuCF+fZeB4OtiYVGnY8=; b=cIvK3w
	Aza8Lf5SURgmpdn6xLWM8y943+i6NE/xrfbO+4YRYkn9ZnCffoZCDPENcaHboeFZ
	unKCdhRLAlx/X0b+8waE+1Fgk1kfeOPAT3hhH40Ngmu2rPsAFNXUFw21yOWo+Q6e
	fB2h+MvNfnIDsNs8ImGopkM4FRarLyLx6EYfg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hTrCpRBjM1j8Ncn6+Kj+jwOYsWhe/w6N
	AemmulxprFCM7hR22znMIyziBmh1f9Fq8IYN7gATvrrsKOy+CHLBKIevfbDXzcBh
	GgBeYtPBFMgqaCwsp409xtipf7ecAF78h8mHW1edsBcx2G1NAipAqKQ0PPVSv2Na
	+Ihy08fysz8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09EC29483;
	Tue, 26 Jun 2012 17:24:13 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EAA07947D; Tue, 26 Jun 2012
 17:24:08 -0400 (EDT)
In-Reply-To: <20120626201155.GE5864@arachsys.com> (Chris Webb's message of
 "Tue, 26 Jun 2012 21:11:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 44B89E8C-BFD5-11E1-BF9B-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200684>

Chris Webb <chris@arachsys.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Very understandable.  Perhaps in-code comments would have helped.
>
> Shall I re-spin this with a comment to explain what's going on, and to
> mention the implicit -i with rebase --root without -i, or would you prefer
> to queue the existing version with any clarifications you think appropriate?

A reroll would be preferred, as it would be less work for me ;-)

Thanks.
