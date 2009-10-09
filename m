From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: enable THREADED_DELTA_SEARCH on IRIX and
 IRIX64
Date: Thu, 08 Oct 2009 23:52:29 -0700
Message-ID: <7vhbu95aaa.fsf@alter.siamese.dyndns.org>
References: <Zyq66vleW7YI5l2liyEIAK1O_rnknZ4_xci4KmS3Proua7JfnWyaAyyk1ww9sknBMukmwGErv7slPEl71tr1Lg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Oct 09 08:56:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mw9P2-0007Wp-ME
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 08:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbZJIGxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 02:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755075AbZJIGxT
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 02:53:19 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53234 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbZJIGxT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 02:53:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BD08951B5E;
	Fri,  9 Oct 2009 02:52:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UCuQYYEsWcsGyZh21G7CgWxUMZ4=; b=Gr56Sk
	rHLu23zcsCNY3HRkplmB0f5A4HuPTYPg4vvkRjPD4PGpopxszEGeOkTQkb5A6LI0
	ZfGBF//VrjnMtMnu0dvHGt4MIXPUgUviIWA2oPw937mtfAVbqrB2s8wNYTe2y2gE
	GqkGSJak1yL5Mo/5nASdOsu9r0C8qnGR/YxvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ekhrydv+JRSa9b4gB18Vgct05Sg7npyP
	wZJZVvaRdiJPh3lEB5tI1ZZREJyNw7/5Z61OK963yBCaaDdlULgmNk3ik0UOoZi+
	lkN9lWQwsMIZeMf2TvtmEH2Za2Y6V/D8DDEWnngVygjRbXN1N+Y6Jk4zkgS9ir44
	ckvGyDkoDfg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8927451B5D;
	Fri,  9 Oct 2009 02:52:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E4E0851B5A; Fri,  9 Oct
 2009 02:52:30 -0400 (EDT)
In-Reply-To: <Zyq66vleW7YI5l2liyEIAK1O_rnknZ4_xci4KmS3Proua7JfnWyaAyyk1ww9sknBMukmwGErv7slPEl71tr1Lg@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Thu\,  8 Oct 2009 18\:07\:41 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 52D81396-B4A0-11DE-AC09-E80E3AD9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129746>

Thanks; both IRIX patches applied, as it did not look wrong and I do not
have an environment to test myself.
