From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] log.decorate: accept 0/1 bool values
Date: Thu, 18 Nov 2010 09:00:13 -0800
Message-ID: <7vmxp6d0te.fsf@alter.siamese.dyndns.org>
References: <20101117170045.GA4108@sigill.intra.peff.net>
 <7v4obfg2td.fsf@alter.siamese.dyndns.org>
 <20101117195259.GA13008@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 18 18:00:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ7qd-00020W-RX
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 18:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142Ab0KRRAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 12:00:23 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45948 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932437Ab0KRRAV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 12:00:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1595F35BA;
	Thu, 18 Nov 2010 12:00:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I4akKE2xwAx8ChOdovpHFNEGWv8=; b=Ff9a9u
	nxkRmE+mqddV9I+KgNifrijCZudcNco/5jjzphPyDBSGmDzArwUVA9K1Y8CkfpRn
	+yxsJozmTGIS970yRdDs0zak9tvz8KZoD14a4y/pS1jXoRA5R1vaWHHGQDowTlvi
	x549Ar7N0/bwiRN5vgc9DrOc9ynjs3c+xE3aU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KB6DlXLjBVYj2JcR+awU1TvPotMkwsHo
	cGD2HAJMPilJWMX4YH/1xWbGMzzXm/5cdOBm/5aGxUfzsPb64k7QITxwWFA1+cR2
	+ZDDRJ6mR9oUalvaHC9oPpOoKThVxavqX1X0UmJt1lSoLMqQuBZEp539MAPi+6tP
	2opaLog9WMs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E7E9935B7;
	Thu, 18 Nov 2010 12:00:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 181DB35AF; Thu, 18 Nov 2010
 12:00:25 -0500 (EST)
In-Reply-To: <20101117195259.GA13008@sigill.intra.peff.net> (Jeff King's
 message of "Wed\, 17 Nov 2010 14\:52\:59 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 589149AE-F335-11DF-850D-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161685>

Jeff King <peff@peff.net> writes:

> I don't think it is worth closing the hole for no reason on other config
> options, but I am certainly fine with breaking it in the case of
> pager.*.

Hmm, I guess that is fine, but will we hear "Why does it behave
differently only for pager.*" down the line, just like the issue your
patch 1/2 addressed, which was "Why does it behave differently only for
log.decorate?"
