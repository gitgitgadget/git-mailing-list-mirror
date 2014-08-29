From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pretty: Provide a strict ISO8601 date format
Date: Fri, 29 Aug 2014 13:57:34 -0700
Message-ID: <xmqq8um75801.fsf@gitster.dls.corp.google.com>
References: <1409248189-31409-1-git-send-email-bbolli@ewanet.ch>
	<xmqq61hc8bvq.fsf@gitster.dls.corp.google.com>
	<20140829174439.GA10274@odin.ulthar.us>
	<xmqq1trz6sv0.fsf@gitster.dls.corp.google.com>
	<20140829202916.GB10274@odin.ulthar.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Beat Bolli <bbolli@ewanet.ch>, git@vger.kernel.org
To: Scott Schmit <i.grok@comcast.net>
X-From: git-owner@vger.kernel.org Fri Aug 29 22:57:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNTEz-0001Gl-9q
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 22:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbaH2U5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 16:57:45 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54637 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750829AbaH2U5o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 16:57:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 31595367CC;
	Fri, 29 Aug 2014 16:57:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fm6HHRLfAql74vWo4UxrHZRlXT0=; b=ohtH00
	UWUYwADKrHi6wUfS1eQVS18NCtrn1Jdp8pDESairLfd7m0lTkOgo0jm6B7Gv+n8F
	wbbBeYsioOQYQEFdHv7dh1cxe5NhWogXtjGSE/n3ZXBBazv4I77fncBQQMZCcIqB
	9M7A40MgKgivKWNMpQ8hXPC7eaGQ7ibSu+nbM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HguUALYCwbgUvDwhJQH8lI4R1H0UBO9v
	Hi7RaUPTxcWvBe4Y2xLisKoSaknzt4owDF6JLom5ESV5u2SzJQnrEtqykFMmTnvb
	4Dy/I0Vej3kLRBXm9X8NypkJVqrh6kVrYWlnz+GKaLd0dD2eo2k29djzyOFRIQXk
	7jnrZ2PMcgQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2847B367CB;
	Fri, 29 Aug 2014 16:57:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B2711367C5;
	Fri, 29 Aug 2014 16:57:35 -0400 (EDT)
In-Reply-To: <20140829202916.GB10274@odin.ulthar.us> (Scott Schmit's message
	of "Fri, 29 Aug 2014 16:29:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1A7A3DF4-2FBF-11E4-8652-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256192>

Scott Schmit <i.grok@comcast.net> writes:

> +00:30 because zero can't be negative in two's complement arithmetic.

Yet to meet negative zero yet myself ;-)

> The "-30 / 100 = 0" part didn't click for some reason.  Sorry for the
> noise.

That's OK.  You are not the only one who didn't get this right the
first time.  The important thing is that we get it right in the
version we will use in the final product.

Thanks.
