From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] api-credential.txt: document that helpers field is
 filled-in automatically
Date: Tue, 12 Jun 2012 07:48:29 -0700
Message-ID: <7vehpk4mde.fsf@alter.siamese.dyndns.org>
References: <7vzk897rqi.fsf@alter.siamese.dyndns.org>
 <1339437107-25909-1-git-send-email-Matthieu.Moy@imag.fr>
 <20120611190811.GB20889@sigill.intra.peff.net>
 <vpq7gvcx40y.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 12 16:48:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeSOa-0002sn-5c
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 16:48:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301Ab2FLOsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 10:48:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49688 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752372Ab2FLOsb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 10:48:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5388893B9;
	Tue, 12 Jun 2012 10:48:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=mKGOH1VTVpGbuOvpjaYohnvB8FQ=; b=ahksl1
	kWFNsVvfLaH4wqDlSgFXClaWLUSkoTEqyZ17hhGkP/en22lHb3SXlP7ZS6uj2Kbd
	Xb0dhizM3ZNzgAZeQ/b2jp/l9BYY99J5TC/nXxlokMuE5DGy2HKqxvMKAzIDjZnd
	bdl3s0gEj+qhYiBeFdyYFh/clzAWu66E47V5A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vbUzm3LL117INuxJaIDyeQ/8gy83mxtL
	Fi3PLjmffQluEUOoD0nr+WluAnwqEEXt8phX6p+ZzDwd3Rs3SulG4U+zV6AIaUVZ
	KZtzvqoCV8CajgEV6O0lvFD28lY+rZRPJISYEJHoOuhx92klc3UE15k1PkZ6fog5
	l+fWBOmPNog=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4ABB693B8;
	Tue, 12 Jun 2012 10:48:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D324D93AD; Tue, 12 Jun 2012
 10:48:30 -0400 (EDT)
In-Reply-To: <vpq7gvcx40y.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Tue, 12 Jun 2012 11:39:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AD558646-B49D-11E1-93A4-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199796>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Agreed. I see that Junio already has this fixup in pu. Junio, let me
> know if you prefer a resend.

I take it that you told me to squash that fixup in, so will do.
It's much easier for me ;-)

Thanks.
