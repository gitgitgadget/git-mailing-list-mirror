From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: inform the user they can re-order commits
Date: Fri, 16 Mar 2012 07:26:32 -0700
Message-ID: <7vpqccipuv.fsf@alter.siamese.dyndns.org>
References: <4F63205A.6000202@seap.minhap.es>
 <vpqlin0n8w5.fsf@bauges.imag.fr> <7vty1oivub.fsf@alter.siamese.dyndns.org>
 <4F63571D.4070405@seap.minhap.es> <vpqaa3geiso.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Mar 16 15:26:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8Y77-0007c6-1m
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 15:26:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030448Ab2CPO0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 10:26:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35063 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760812Ab2CPO0f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 10:26:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BE7F41E7;
	Fri, 16 Mar 2012 10:26:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cz8FH3a8cMYy0SakrXrfvu8KDXE=; b=GAOZCO
	SFLzDUf0mLicbbu0uh1TcCjSCJA4iayTewlTLZxbIMM/McEVusL76jSr/lm9ppIr
	ZI2KZ/8QzeXHdTcdVGo87c0SU9Z6/qcr19KsHUADzjCOHfEeBOmiP4ciJl78ln9p
	vOc3z5yKlt0fCMD/xWg8KqK07W3CgcMRJJVks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xl9Nb49P0VrNFXUJD+AKNeJOvQV5JuuT
	qqKyAWlonMFKi5iNm0iuZIlj1wvMIz96qO/IVaPMRu1sDfri/fyPVrP87gv0nJLn
	OnJMjWzYz+MzmMO2+u2BL807C8ExHRo0fnaqtavcaV2QOAQ3fc66SLobG/oSL8ip
	HpC68JFwrzQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32BA241E6;
	Fri, 16 Mar 2012 10:26:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BDC1241E5; Fri, 16 Mar 2012
 10:26:33 -0400 (EDT)
In-Reply-To: <vpqaa3geiso.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Fri, 16 Mar 2012 15:12:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 07EFF1D2-6F74-11E1-89EC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193267>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> But if the user sees the help message of "rebase -i", then I don't think
> we will stop him from breaking anything by not mentionning that
> reordering commits can work. We already give other commands that rewrite
> history with more or less danger, so the additional messages isn't
> really harmful.

I was not questioning that "You can also reorder" is dangerous in any way.

What is dangerous is to give an illusion that it is safe to use "rebase
-i" without reading a decent documentation that does not even say that
reordering is one of the primary purpose of the command, and the mindset
that it is OK to give such an illusion with these reminder lines.
