From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 0/8] docs: use metavariables consistently
Date: Sat, 18 Dec 2010 12:27:25 -0800
Message-ID: <7vhbeahln6.fsf@alter.siamese.dyndns.org>
References: <1292650725-21149-1-git-send-email-lodatom@gmail.com>
 <20101218084908.GE6187@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 18 21:27:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PU3NY-0001Ee-TE
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 21:27:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175Ab0LRU1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 15:27:37 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64490 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932108Ab0LRU1g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 15:27:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D9BC22CA2;
	Sat, 18 Dec 2010 15:28:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i1oXDnV292H7S6hXu/0FhqoWl6c=; b=WfByTa
	mWS3fTiGp45tSZa54BF9dShdZMKHLWR5uvzUqPDiqgfmYLKNqYyhx7WMW27MewII
	GAi6hn1GwO5gzINq7CGG6jB/rhVOf6weaVPG6DErfGDamSYOmIN/cYHldU8fLoKV
	Y6QsSQWzwmfTIHQ2byLOuvvbMunOab+5pfJ9o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=adECGwIAssttpOEfHV0ebMR2aKz2BX5D
	shtWPtr5t6Qz6jy6vpWpTPQhfGU7ssICkje9x+IIVl6MaKO74vBgorIVBArc3UcP
	8q3mAYto+Nn+Gg4FhHteIavpCrrM7rfStffJCDmP0mflzdHR8d9dF8PG+8xcIxvB
	hkpdu4j4npo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A5A8C2CA1;
	Sat, 18 Dec 2010 15:27:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6063A2CA0; Sat, 18 Dec 2010
 15:27:55 -0500 (EST)
In-Reply-To: <20101218084908.GE6187@burratino> (Jonathan Nieder's message of
 "Sat\, 18 Dec 2010 02\:49\:08 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4E2B358E-0AE5-11E0-8420-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163929>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Ah, missed this before.  It is not clear to me why this difference ---
> is it just to be conservative about changing behavior?

Yes.  It is clear from the context you mean its tree if you feed a commit
to commit-tree, but the original intent of not dereferncing was to avoid
mistakes by scripts and people, so you need to make a convincing argument
that not derefencing does not help avoiding mistakes, and prove that
nobody's script is relying on the current behaviour for type-checking
purposes.
