From: Junio C Hamano <gitster@pobox.com>
Subject: Re: old but persistent problem: bad line length character
Date: Wed, 08 Jun 2011 07:56:48 -0700
Message-ID: <7vpqmo2wy7.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.10.1106071832470.4175@localhost>
 <20110607180624.GA23752@sigill.intra.peff.net>
 <alpine.DEB.1.10.1106072337500.11389@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Kleiweg <pkleiweg@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Jun 08 16:57:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUKBo-0000dr-VC
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 16:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755890Ab1FHO44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 10:56:56 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39445 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487Ab1FHO4z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 10:56:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EE36A44B7;
	Wed,  8 Jun 2011 10:59:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nkc1eO791NQptIyeL+tGdhzRGU0=; b=qb+eBD
	xkuXMR8dIxY8x/wTFBVoJp7AdhM2RESwXVmcECi8GeI+ci+VxECbCN9L5/YXsTGH
	djngXKPflkq5RaajAsbvDBCf7QTHpWV53tzBc5trMwAlh88nLgUM3f/Lx0U96295
	9PCbQLBZaREhhd41q8Ee7dHrEI3hGGVScCQeE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wAEAH2pr5mt1dE/yyaIKZjxFE4oUnIBg
	tTw3tB/ZgC8UK0+LTjeojsf6pUf2AHn+e28clyo+X19lsCeYVrlGSQ7TyzTBd60/
	bGsHxsqToZYu981HziDx87lxk9gzkvDVyv2ZpZw+RKgfZGDjFIblFZCZTJ9qpLDa
	tQSBGmpkZ9E=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CCC2C44B6;
	Wed,  8 Jun 2011 10:59:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E60D144B5; Wed,  8 Jun 2011
 10:58:59 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.10.1106072337500.11389@localhost> (Peter Kleiweg's
 message of "Wed, 8 Jun 2011 00:32:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D91DCF86-91DF-11E0-BBE4-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175376>

Peter Kleiweg <pkleiweg@xs4all.nl> writes:

> I made it read some more than 4 bytes. And this is what I get:
>
> {27}]0;github git-receive-pack 'pebbe/Gabmap.git'{7}
>
> Ah, I see! I have a wrapper set-up around ssh that sets the 
> window title of the shell to the ssh command argument. That is 
> what messes things up!
>
> OK. Fixed now.

That does not explain why you earlier said 1.4.4.4 works and more recent
versions do not, though.
