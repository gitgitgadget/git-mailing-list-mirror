From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Wed, 02 Nov 2011 11:58:13 -0700
Message-ID: <7v1utqjqre.fsf@alter.siamese.dyndns.org>
References: <20111026202235.GA20928@havoc.gtf.org>
 <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <1320049150.8283.19.camel@dabdike>
 <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org>
 <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <7vwrbjlj5r.fsf@alter.siamese.dyndns.org>
 <4EB12122.7010803@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: linux-ide-owner@vger.kernel.org Wed Nov 02 19:58:18 2011
Return-path: <linux-ide-owner@vger.kernel.org>
Envelope-to: lnx-linux-ide@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-ide-owner@vger.kernel.org>)
	id 1RLg0v-0005FW-HJ
	for lnx-linux-ide@lo.gmane.org; Wed, 02 Nov 2011 19:58:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756319Ab1KBS6Q (ORCPT <rfc822;lnx-linux-ide@m.gmane.org>);
	Wed, 2 Nov 2011 14:58:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53018 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756065Ab1KBS6P (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Nov 2011 14:58:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F62C5B0B;
	Wed,  2 Nov 2011 14:58:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TfGyWAJcmKoW1ijvhno+omCXioM=; b=rTNV8l
	el6WaAecfS7LLGe4cXgbUDplrCSRU0hPvWtLeZr7Y+/pFrkBVvFXB9KqqctXbWGf
	yFtvdz0WXrom14Gr+eEB5V2uUDuATp/9vj7JcC9c75PcPP5p0Z72zLZsStfRissp
	UVYzg4ZEIpTRkkEObdPlluDTv0JKMKcrDNxEg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N38ibDY4Vy3CEZY0J+7IF5y4i2o/S0Vt
	MH/pT0NhxYMw90hjIThztZk/cQHhlQ8CoOsWJuEc272E1bZifOOY4X21uxFfNFiy
	qKK1AsYc9W8CgyhQmPNLn7WPCSF19Q6L0dr1taRIKwQ60tTeSCmmbwY3NFlfERCU
	oU99M0O4Nfw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1619E5B0A;
	Wed,  2 Nov 2011 14:58:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B1415B09; Wed,  2 Nov 2011
 14:58:14 -0400 (EDT)
In-Reply-To: <4EB12122.7010803@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Wed, 02 Nov 2011 11:53:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9E4139C0-0584-11E1-914C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184655>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> The advantage of tags is that they can be added without rewriting the
> commit, of course.

And you did neither think about the downsides of tags, nor read what
others already explained for you?
