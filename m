From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A git-mv question
Date: Mon, 01 Feb 2010 16:46:02 -0800
Message-ID: <7vwrywmpmd.fsf@alter.siamese.dyndns.org>
References: <ron1-09EE6C.16083801022010@news.gmane.org>
 <alpine.LFD.2.00.1002011927490.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ron Garret <ron1@flownet.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Feb 02 01:47:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc6vN-0005bB-E8
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 01:47:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442Ab0BBAqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 19:46:13 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43636 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab0BBAqN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 19:46:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E201C96A83;
	Mon,  1 Feb 2010 19:46:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hUZ39QKf9FeXKKZxTxqoR9petBc=; b=r5fyu1
	xv1AO7ekbjNwXjjl0FJyGDRPpVcHx2XERo+HYMSg7a+7fLopw0UEeF1cfgKSG3Vv
	D07oCASmUQP0/10YoMlAnoALOVnrKxP5MkXiv4WG5ClSqs4hdGs2DsVV063iMyF8
	RJIsEQ1LvHNOOcRE7eq4/RmyrTFlAyaBGMTuc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BSY+a1qazyGTJXyBZGK3r4cOe0sg6LuX
	xEGfc39s9rVLkJVpmLy45EPHPkYHZa+X/06lYAnmo13eUfDwydNoND9bADVJERZp
	TC17g3RozAz14m3k6HRSM6NGogOIZr1oxP1pe0GnuOsV8iAwByOAq2GB93STl/M7
	YXHcjHm1ax4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AC5A396A82;
	Mon,  1 Feb 2010 19:46:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CBA4896A7A; Mon,  1 Feb
 2010 19:46:04 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1002011927490.1681@xanadu.home> (Nicolas
 Pitre's message of "Mon\, 01 Feb 2010 19\:29\:26 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5A2B33A4-0F94-11DF-810E-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138667>

Nicolas Pitre <nico@fluxnic.net> writes:

> Please see:
>
> http://www.kernel.org/pub/software/scm/git/docs/gitdiffcore.html

Thanks.

Probably it needs a bit of updates to help new people read it.

 * It talks about diff-* family.  They exist, but what they do can be
   triggered also by "diff" wrapper and that is the primary way the users
   know about "diff" these days.

 * Because it was written to illustrate the low-level diff-* family, it
   says "when they are run without -p option".  People who only know
   Porcelain "diff" need to read as if it said "when run with --raw".

 * It does not talk about "log -p" but the discussion applies there as
   well (log is a glorified form of diff-tree).
