From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [git wiki PATCH 2/3] "Designing a faster index format" project
Date: Fri, 02 Mar 2012 10:24:09 -0800
Message-ID: <7vobseeu9i.fsf@alter.siamese.dyndns.org>
References: <57e8b4eb7a98af33982c2f3a763e18f62b1d6d6d.1330686331.git.trast@student.ethz.ch> <afdfa68348d8d98f2cb604d9c17dad6cd764066e.1330686331.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Mar 02 19:25:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3XA6-0006SG-UX
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 19:25:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759019Ab2CBSYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 13:24:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52792 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759005Ab2CBSYO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 13:24:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 91A2B60D5;
	Fri,  2 Mar 2012 13:24:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xJBp9Wf6G4P/oOTf2KltPMT+Pek=; b=BWD2Hd
	xFJYczJ7sfFMLqdU1KjMt1rNzQjuycIvVa28DFjGYldp2AflQbCfxdxFvEmmREix
	2dGaEdpRh0lxtvv4k8/N57VRPdm9kv2wIkVbsiCfFo5myTLrYIwRRuITp9+4yVAo
	xe9Hz8tiq/MGrm0TbDnIY78PSeFjh8WIJ24U8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sRK5U0/DC54Pnha1mKymc2NoEG3uw4Bh
	Z1C9W2EqD2mBML5Nsi/4mLTKUdCiTW+9PvP661kVNKKNcM0A4fxaZS7Fz4+87uGd
	YuHsVmDqv8LcMvMfHvNyCFxY878Imr2B0tybPkwBbfLcWUR2kWhzvFsqgH7FdWQf
	UjF90MdVUFc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 895EE60D4;
	Fri,  2 Mar 2012 13:24:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1EEA460D1; Fri,  2 Mar 2012
 13:24:11 -0500 (EST)
In-Reply-To: <afdfa68348d8d98f2cb604d9c17dad6cd764066e.1330686331.git.trast@student.ethz.ch> (Thomas Rast's message of "Fri, 2 Mar 2012 12:05:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E832593C-6494-11E1-9094-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192055>

Having harder and more ambitious ones in the mix is OK, but I suspect this
one is probably a bit too ambitious to be realistic for a student project
that lasts only 3 months.

This proposal is about a change that touches core parts of the system that
has the chance of inflicting permanent damage to end users' histories.
I'd have a hard time reviewing and convincing myself that the change is
good, if such a change were done by somebody new to the system, even if
the work were mentored very closely by one of our top 15 committers.
