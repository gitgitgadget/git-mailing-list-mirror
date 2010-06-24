From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] git-cat-file.txt: Document --textconv
Date: Thu, 24 Jun 2010 13:10:07 -0700
Message-ID: <7vk4pochuo.fsf@alter.siamese.dyndns.org>
References: <4C2355EF.7030604@drmicha.warpmail.net>
 <735c21d857407c7f0cb18da13d556d3a77a358db.1277383590.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jun 24 22:10:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORskm-00035B-Aw
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 22:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519Ab0FXUKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 16:10:24 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48902 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799Ab0FXUKX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 16:10:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 880A3BE9CA;
	Thu, 24 Jun 2010 16:10:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xaS4EDY2kRJTzMCe7Oa7WiwiRZw=; b=uSZQjN
	KehZmHTHY/IEV6GzYtYmtx70RjieWV1t5S0Lk375PJizm8nzF115U5TJF5rKPZbt
	oWoGwOIpvmiHW0GHvX2ZlJwIaZXt7XOiixCFq5GDOYbMjWZVnbyQnztOpL9EzJNO
	E6+yOYdEaEhSEwe4dOf9qwqAlkYK3uRgeaaqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lcKXokDthUvMLWWWH8Muy3nR2w6bHJ5G
	Nvqahb66sURVJUlXbXnwrfbrADPMziI41Zd9FmB4VRwnWrg7BsNhRljtcg7T0k0b
	fW+g5qYNBuxBj5Z4NU144SP0i1CplYysb0pfyH04Fs6T3T9G1dCbT5G1i967/6Fe
	SQ+3tevrOJk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 295C5BE9C3;
	Thu, 24 Jun 2010 16:10:16 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C172BE9BF; Thu, 24 Jun
 2010 16:10:08 -0400 (EDT)
In-Reply-To: <735c21d857407c7f0cb18da13d556d3a77a358db.1277383590.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Thu\, 24 Jun 2010 14\:56\:55 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 81294E20-7FCC-11DF-9691-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149632>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> v2 based on clarification by Matthieu Moy.

Looks good; thanks.
