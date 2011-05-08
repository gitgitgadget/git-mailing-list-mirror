From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git alias fails if non-accessible directory is in PATH
Date: Sun, 08 May 2011 09:50:13 -0700
Message-ID: <7v7ha1uofu.fsf@alter.siamese.dyndns.org>
References: <iq5p6k$73f$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 08 18:50:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ7Bc-0005yq-2V
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 18:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158Ab1EHQuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 12:50:22 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45324 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932085Ab1EHQuV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 12:50:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5E3344B7A;
	Sun,  8 May 2011 12:52:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WBKAVjblwle9BwNO0yjLejOJwpA=; b=pEBHvF
	WOxGOT3+uJiV0h6QymfEof5KOm4QA97F6/qjDQguYOpF/ZwMzyAzASSlxtIBdrUr
	xY2lNBtYQwoESZJkjeiSSqeVipTK/h9D660ptCevo/Dr5N3JLEm3B5288IxXMN5V
	XNRg2Wi8D67hVa3slN2CN8cKl/jbweLhkpeVA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fPUgL7FgRwleMPJeRHGwL+0UJs4v2jap
	Ekp6ocUYm+spLDDI0/quSkYbNUhiNAEV9t1siCEQ9ZiqcUkv2qg0n9XEVatrs/lS
	SfJ8TdNZaKOTD5ovMHwHJVsxyieKur9rj3lDoH/Jx7boUue54sFEUyvaiT/ugfDw
	pd3mCuuY5PM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3A16B4B79;
	Sun,  8 May 2011 12:52:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5CBDD4B78; Sun,  8 May 2011
 12:52:20 -0400 (EDT)
In-Reply-To: <iq5p6k$73f$1@dough.gmane.org> (Sebastian Schuberth's message of
 "Sun, 08 May 2011 11:53:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8BABF732-7993-11E0-90C3-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173160>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> # git config alias.br branch
> $ git br
> fatal: cannot exec 'git-br': Permission denied
>
> Is this by design, or a bug?

The "tangent" part of

    http://thread.gmane.org/gmane.comp.version-control.git/171755

and then the discussion that begins at

    http://thread.gmane.org/gmane.comp.version-control.git/171755/focus=171767

may explain the current list concensus.
