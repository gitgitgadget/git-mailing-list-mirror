From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch: avoid repeated commits in mark_complete
Date: Thu, 19 May 2011 18:42:17 -0700
Message-ID: <7vliy25erq.fsf@alter.siamese.dyndns.org>
References: <20110519204851.GA28574@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, git-dev@github.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 20 03:42:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNEjY-0001j0-TD
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 03:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934699Ab1ETBm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 21:42:28 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58893 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934682Ab1ETBm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 21:42:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2B4965A1D;
	Thu, 19 May 2011 21:44:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gG50GtfUcnAbddWjrorBxcKaeKw=; b=yGIZPd
	/VZeLlTXaVSk5xQDVwqiS/BsCopEe+t5tIdgYqNmo7hNYeGBFamfJDnS/LxAcfdh
	KB1murZ6FUGblvZImLT96JXzXCvi+TlqiGQfsiTGAdLOu3nH79SKKDLcehurspwt
	fs3RpnK0sqc8FtYyaDeZP4rTBaodlDkgZmEwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NuawL7Hdl6+u68qKBEH/20EVgpEp4f7E
	PcD3Q6wamaVbKm5wbTRBylKgVks00gOfCpP+CwXColdP+MsLnF9MP+HqOZ/lP0pI
	4n1so5B3byY7HU3isAGR2Iej4i2Vbp0x6l3VAkKRsBUiGKUAyK7TPDd1u3q8/nbR
	uHDQlqJkn1c=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D87605A1C;
	Thu, 19 May 2011 21:44:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D1BD45A1A; Thu, 19 May 2011
 21:44:26 -0400 (EDT)
In-Reply-To: <20110519204851.GA28574@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 19 May 2011 16:48:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B493E61C-8282-11E0-932C-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174032>

Trivially correct and the right thing to do.  I love this kind of patches
;-)

Thanks.
