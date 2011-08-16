From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git apply --check" successes but git am says "does not match
 index"
Date: Mon, 15 Aug 2011 21:10:43 -0700
Message-ID: <7vd3g6j8sc.fsf@alter.siamese.dyndns.org>
References: <loom.20110814T113311-277@post.gmane.org>
 <20110815232318.GA4699@sigill.intra.peff.net>
 <7vhb5ijkq0.fsf@alter.siamese.dyndns.org>
 <20110816001306.GA23695@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zemacsh <ruini.xue@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 16 06:10:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtAzM-0004Ns-70
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 06:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166Ab1HPEKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 00:10:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61348 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750902Ab1HPEKq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 00:10:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BDE844C4E;
	Tue, 16 Aug 2011 00:10:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SiO4Xgf+GAUuJyZEgmyhgAvuYWo=; b=Uj3Dbv
	g8uVuo1ac+6dR8sOy/xTouFCa7+locDEtnBoh3fpnjWifA1/byFDFbrosjzqbSuv
	TeTtEAWp7afUQL8/8JMan1EyATYonBlrjKYHMj1CfR6bzxsTO/nEI0LlsS/LyZBZ
	Mk/P51Rn+V5kKlowKP5NHdIaOFf4u3eVf9akE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i5JuRAm2sPgaLukxFeSTVTxRSLDQKuNO
	d/ONgyduG8HMFHn8E/k+37adU7R/ewOlPmAGrqDFNT8INDBNVbDMCQC/PIo5SB97
	6ayTQLBsSPc2T+NyB1tPARooGOYWZdpdxHhqbcAP9M1hAcQhqa7/5RyP//CcGRag
	A5S/BL6sDCY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B54E84C4D;
	Tue, 16 Aug 2011 00:10:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2EAC84C4C; Tue, 16 Aug 2011
 00:10:45 -0400 (EDT)
In-Reply-To: <20110816001306.GA23695@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 15 Aug 2011 17:13:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B6E0560A-C7BD-11E0-A21D-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179403>

Jeff King <peff@peff.net> writes:

> ... I wonder if "git rebase" actually
> suffers from the same problem,...

Doesn't it require a spiffy clean work tree before even starting?
