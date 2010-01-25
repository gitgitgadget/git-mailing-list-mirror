From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2010, #08; Sun, 24)
Date: Mon, 25 Jan 2010 15:47:31 -0800
Message-ID: <7vfx5t3fxo.fsf@alter.siamese.dyndns.org>
References: <7vfx5u6bn9.fsf@alter.siamese.dyndns.org>
 <m3eildbydx.fsf@localhost.localdomain> <20100125231241.GA4159@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"J.H." <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Jan 26 00:47:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZYet-0006j8-4c
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 00:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872Ab0AYXrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 18:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214Ab0AYXrq
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 18:47:46 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46860 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082Ab0AYXrq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 18:47:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7194094793;
	Mon, 25 Jan 2010 18:47:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8Pw8j4DK/ewfjZ6xC8ljxakbsLA=; b=ilYZUp
	NxYw3awzMiiC9xRuU6mphHWXhnVvRSncw33v5A3f8rdby8gvAoKUZ7yE3GN3+adm
	zN7JF7iJTSK1Kl/goxap0qCNzCzQ+o2VRApCMjSICd7HmS3Kbzt+/93H/UFyNVoE
	ztsT9hRH/q6Am2pklGt/AEKslWMaFYj02EJGM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S5PXTXkMHXH8eCR3ry9y66caC4B+/uem
	ywsLWUtix3SU9fcN2Wuq9/SAx79BCLJqzPMzPk7R/Qb/hwcJP0b2PVGq37yDMrNf
	wduVa5AKhozgX/qOycMrGGAYZ6V3MjPSZT2VYaUnFMkjv4pTsBDrpM7C+d7rmVBd
	w89GGZLqTp4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E14F94791;
	Mon, 25 Jan 2010 18:47:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0023C94788; Mon, 25 Jan
 2010 18:47:32 -0500 (EST)
In-Reply-To: <20100125231241.GA4159@machine.or.cz> (Petr Baudis's message of
 "Tue\, 26 Jan 2010 00\:12\:41 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 05FF309C-0A0C-11DF-9EA0-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138007>

Petr Baudis <pasky@suse.cz> writes:

> ... I think
> it's healthier for new gitweb stuff to develop more in-tree, even
> if that means few angry users annoyed about less-than-perfect UI stuff,
> rather than polish the diamond in infinite discussions; worse is better!
> The only thing we should be worried about is avoiding introducing new
> bad URL interfaces since we should keep backwards compatibility there.
> ...
> For the main caching patch, it seems like good idea to take Jakub's
> split-up series instead, let's see what is J.H.'s opinion on the series?

Sounds reasonable.
