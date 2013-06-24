From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] documentation: add git transport security notice
Date: Mon, 24 Jun 2013 15:28:58 -0700
Message-ID: <7vy59z5ej9.fsf@alter.siamese.dyndns.org>
References: <1372069414-12601-1-git-send-email-frase@frase.id.au>
	<7vppvbbhoi.fsf@alter.siamese.dyndns.org>
	<20130624215733.GU2457@bacardi.hollandpark.frase.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Fraser Tweedale <frase@frase.id.au>
X-From: git-owner@vger.kernel.org Tue Jun 25 00:29:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrFGC-0003z0-RG
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 00:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619Ab3FXW3D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 18:29:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34668 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751358Ab3FXW3A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 18:29:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 467722B93D;
	Mon, 24 Jun 2013 22:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZyCkthPMuh1PGXnmf2m/TDKHKy4=; b=fYB/nm
	inowSlqe2yFgaEWiYyDzH/DufSRsshnmgAaoXpuhrxLZICaWTF/Udu9L74urBDgh
	exallWxPbEr+ZUlFJTVGN2K/jNVtZTBLYotbw5NA/Mw94K1tDqxLnfnl/7UMtZNX
	InEC4lTkhneuaxFfwsaWXGi7Lhcl0oR4EjLl8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pugz9GQJz+CDwGpgbWwV5PRb+2eJ7v0M
	W5f3P4zI70z//Rp4d19gMfL7l7Z4XzADDTHRXFShrrNVJh8XKGPfDfpU3OYwe/1/
	3LyEumVB3ggoZvxPKUJ52O8XCZvBG4ejhngxBDuhSMkwYUZC3tkz4V9hLfEBX8z7
	70kzbtkphw8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39DF12B93B;
	Mon, 24 Jun 2013 22:29:00 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B17682B93A;
	Mon, 24 Jun 2013 22:28:59 +0000 (UTC)
In-Reply-To: <20130624215733.GU2457@bacardi.hollandpark.frase.id.au> (Fraser
	Tweedale's message of "Tue, 25 Jun 2013 07:57:35 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7726C75C-DD1D-11E2-9F78-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228914>

Fraser Tweedale <frase@frase.id.au> writes:

> Junio, do you prefer the following more generic wording?  If so I
> will re-roll the patch (also note s/protocol/transport/ which is
> more appropriate, I think).
>
>  The git transport is insecure and should be used with caution on
>  unsecured networks.

Generic but I somehow find it overly vague (it is unclear what kind
of "insecure-ness" it is talking about).

  Because the git transport does not do any authentication, it
  should be used with caution on unsecured networks.

Perhaps?
