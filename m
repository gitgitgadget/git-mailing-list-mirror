From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/8] Git remote helpers to implement smart
 transports.
Date: Wed, 02 Dec 2009 10:52:46 -0800
Message-ID: <7v3a3tfbsx.fsf@alter.siamese.dyndns.org>
References: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <20091201171908.GA15436@Knoppix> <20091201193009.GM21299@spearce.org>
 <7vskbuwhmy.fsf@alter.siamese.dyndns.org> <20091202055632.GD31244@Knoppix>
 <7vy6llnar5.fsf@alter.siamese.dyndns.org> <20091202160446.GA32667@Knoppix>
 <alpine.DEB.1.00.0912021832480.4985@pacific.mpi-cbg.de>
 <fabb9a1e0912021006x2905578bo16dbcaedc0d97bc6@mail.gmail.com>
 <7vk4x5fcbf.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0912021050r4fd96ed4rf863917a965a42fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 19:53:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFuK7-0003mG-GS
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 19:53:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253AbZLBSw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 13:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755198AbZLBSw7
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 13:52:59 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49084 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016AbZLBSw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 13:52:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 88147848AE;
	Wed,  2 Dec 2009 13:53:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q7MDfDu+glkoYhz373fMRFc2yB4=; b=h0oO8P
	igcwwB6yeqewBFIXexp4Hon3Gu2jwdd0c8myOOd/E2oHpSP63KaJaSg1fKaQ1Od+
	yxvbj5l3jlFDqFakCByMV2Zwx/ltaoSVK4lqbyThvwVB6kL+XLuH8OoWfmhsNAI0
	6YNWX82gHNAHI3n60Xn8miIhWmInfuqaJe6Nk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mM31OIjFwPTwtGVfK5ue3vXDPgkFTEih
	Rk5/XIVEso687HoxukobMh148t+7a/sNPheW209eQTVNZQsqBvNSR7HHqysIru1R
	ct9GO2wnTS4tDIrhGN0a/3uijlWRmKPI+6aYmgkATALVk/8X0AgacsqXtbo1pWdo
	uYeOKPjRBjQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EA54848AD;
	Wed,  2 Dec 2009 13:52:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 62DCD848AC; Wed,  2 Dec
 2009 13:52:48 -0500 (EST)
In-Reply-To: <fabb9a1e0912021050r4fd96ed4rf863917a965a42fb@mail.gmail.com>
 (Sverre Rabbelier's message of "Wed\, 2 Dec 2009 19\:50\:54 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E81D8082-DF73-11DE-93E0-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134370>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> I don't see how what you are talking about is any different. With the
> mapping the executable of the alternative implementation still needs
> to have a different name, no?

Sure, but please search for "second class citizen" in my message.
