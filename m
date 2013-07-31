From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jul 2013, #09; Mon, 29)
Date: Wed, 31 Jul 2013 11:51:55 -0700
Message-ID: <7v4nbav9ys.fsf@alter.siamese.dyndns.org>
References: <7vk3k9yol3.fsf@alter.siamese.dyndns.org>
	<51F94DFD.5020101@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, tboegi@web.de, mhagger@alum.mit.edu,
	mlevedahl@gmail.com, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Jul 31 20:52:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4bVI-0008En-Aw
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 20:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760708Ab3GaSwD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 14:52:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43985 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757214Ab3GaSwC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 14:52:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70B2535671;
	Wed, 31 Jul 2013 18:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lQb2e2takA0SwnbwRz08/70lPqY=; b=J0izCY
	OowKb1o3oi89gJfVylyr2s15clAvyf6SidVcAd2qbbV83ZVI6777VvYXm/wbuwzS
	gUt2dBJF0MtZPC8K6PsoZ2MnlG2qE1WovI41AYzsdMb1+B8qRVowoQiVnL3DbdBh
	6PpV0LyXlubr2FMsnKRFI9qhrc/raEyzULw+4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MKz7+nGedwW8rMFM1Doho99QP8UGMQVp
	ultT/2INjRperimlfEpronCNB7Jb8KyUOgjxS/cQLoCt6Wvo+Gh+8aFYbAlQQI/y
	4Qoq6f4dSOLp+wNcSJfO5rJDiKi5hsVndZdpxaqt1L6V7X1z38cUi8jeXC9BuBSW
	nO9R9Svqt/4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 173283566C;
	Wed, 31 Jul 2013 18:51:58 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4755235667;
	Wed, 31 Jul 2013 18:51:57 +0000 (UTC)
In-Reply-To: <51F94DFD.5020101@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Wed, 31 Jul 2013 18:48:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4683098C-FA12-11E2-8DF7-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231442>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

>>  I am personally in favor of this simpler solution.  Comments?
>
> I had expected this to me marked for 'master'.
>
> Has this simply been overlooked, or do you have reservations about
> applying this patch?

I am just being careful and do want to keep it cooking in 'next'
during the feature freeze.  The more users work with 'next' (not
"work *on* 'next'"), the more confidence we would be with, and
hopefully this can be one of the topis that graduate early after
the 1.8.4 release.
