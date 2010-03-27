From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Teach 'git grep' about
 --open-files-in-pager=[<pager>]
Date: Sat, 27 Mar 2010 10:23:39 -0700
Message-ID: <7vbpe9u19g.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.00.1003261145500.7596@pacific.mpi-cbg.de>
 <20100326124650.GA12215@coredump.intra.peff.net>
 <7vwrwykhee.fsf@alter.siamese.dyndns.org> <m239zmdcz5.fsf@gmail.com>
 <7v39zm7epf.fsf@alter.siamese.dyndns.org> <m2r5n5vlld.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 27 18:24:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvZjo-0006G3-Lv
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 18:23:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753750Ab0C0RXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 13:23:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63437 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735Ab0C0RXv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 13:23:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 611F7A5A8E;
	Sat, 27 Mar 2010 13:23:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QreoDKokUrwfKrvFrGeceHQ8jtE=; b=eaWgyi
	85PoKbRmGbm2K2pniu2fjNoQ8vccRyjIgSRTqKjQS4O+Tpr4kU3B9iiMUwQlDoFB
	yZTq/eVPa6S/J+tYKHmnOBRBAe6ILR3oDmUOpb5syvZIPaeQe+mL+tGWfCLUDmpD
	7rSJJ8wRrEqE7JdauLtvG7v5jBPUFe75fHPt0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YtTn4LO6Wi9eifM6pWPedMxHyYXysE83
	5gYjztK1j1lV42THNkU3qFysKka0bdZxFS8Y3Kh2omZ9NXCKZYJB2+ZobL7Em2sk
	dPA9+8sGhnFfZ4j/D+Kmy8I+OpFcM6aCzRasrzwAPNLapCeyIc4Sq78saCVCkPYw
	NVLkUcBA3vc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 211BAA5A8C;
	Sat, 27 Mar 2010 13:23:46 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 42D19A5A87; Sat, 27 Mar
 2010 13:23:40 -0400 (EDT)
In-Reply-To: <m2r5n5vlld.fsf@gmail.com> (Francis Moreau's message of "Sat\,
 27 Mar 2010 16\:19\:10 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7FDE4748-39C5-11DF-A81F-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143341>

Francis Moreau <francis.moro@gmail.com> writes:

> Do you have any tricks for this case ?

I use PAGER=cat only inside Emacs, so I don't see how "log" can be a
problem.  Perhaps that is because I don't use "M-x shell" (I used to but
not anymore).  Of course you have to limit the extent of "log" in "M-x
compile" mode, but that goes without saying.

I may have used some hooks when entering shell mode to tweak the
environment further only under "M-x shell".
