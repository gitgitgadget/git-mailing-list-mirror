From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/7] merge,tag: describe -m just like commit
Date: Mon, 14 Feb 2011 12:08:09 -0800
Message-ID: <7v4o86s7km.fsf@alter.siamese.dyndns.org>
References: <cover.1297695910.git.git@drmicha.warpmail.net>
 <5d55b72b16f3d2def5fa955862fe5be6ff9f82f7.1297695910.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 14 21:08:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp4ic-0001lm-D2
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 21:08:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569Ab1BNUIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 15:08:18 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59578 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398Ab1BNUIR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 15:08:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 35FA04746;
	Mon, 14 Feb 2011 15:09:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Eoi5w6eEmaY4vUbhn7YQtU+bUdA=; b=SK2cbD
	gta2kWYrs/t5mQKcNeD3FYD/4lyYqd/NPq1Jam5VTXbC9BPmA9yNERKnp8bBAALL
	ZgHdGhs3zlQ8ZpkbvPaXPS6VSM+hrnLcFPxWLR8GvPgbVuMo9tEOW2+FMZka5BLT
	AZjJyx+Q+fKpsSGnKN2c4BfYOzlhhJbkWl8pM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RidSmk+0n/Dk/vdokn3n1dWx2NAvbtcA
	R/c826ehQWaLIPSwqMJ/XpdQRSLZ0FrUMxz16rM4T2xaDt3VtOSktfuwG4ZIYdLg
	FgJqzyAzxYpLcTZtDJihP9Oy1ilz8o8aEqOCFDxZdZNWGmFg4vEGp9sLhZBSYeP+
	WolhsigT7Bs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 147714743;
	Mon, 14 Feb 2011 15:09:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2A7504742; Mon, 14 Feb 2011
 15:09:15 -0500 (EST)
In-Reply-To: <5d55b72b16f3d2def5fa955862fe5be6ff9f82f7.1297695910.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Mon\, 14 Feb 2011 16\:10\:32 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4E341DF2-3876-11E0-8296-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166764>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> This also removes the misleading "if any" which sounds as if omitting
> "-m" would omit the commmit message. (It meant to mean "if a merge
> commit is created at all".)

Hmph, then don't we want to keep that in your clearer form, i.e.

	specify merge commit message (if a merge is created at all)

An option is by definition to _specify_ something, "specify" is a waste of
space in a description of an option.  E.g. in patch 3/7, --template option
is described as "directory from which templates will be used", and not
"specify the directory from which...".
