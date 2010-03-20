From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] t/t5505-remote.sh: escape * to prevent
 interpretation by shell as glob
Date: Sat, 20 Mar 2010 08:23:12 -0700
Message-ID: <7viq8row4f.fsf@alter.siamese.dyndns.org>
References: <CxNG4R6Vr07DvPgqJe5msRW43WBM-kHscjWMfuzYM-XxJsVlLbOmNz_AdlMU4gEIvpsxQfdo7fc@cipher.nrlssc.navy.mil> <CxNG4R6Vr07DvPgqJe5msXiOdQxDJcRUCjzNf-LPJNy2ozwVv3sxeG9yEQRNflvd8iDQ_qNtsIU@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: ilari.liusvaara@elisanet.fi, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat Mar 20 16:23:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt0WR-0000RA-CQ
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 16:23:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354Ab0CTPXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 11:23:24 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:32875 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765Ab0CTPXX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 11:23:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C4F5A2B98;
	Sat, 20 Mar 2010 11:23:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=uR9pd2
	qphZjc+ksu1jrtlmvf0IkeVIi5zuW0B7z05j4STWTfDTOTSXJ3DHxjqRaGyNqeMJ
	Ha03sXYiZHjzMmtjRM7oN0SxpXaM1nsuAvHN8v+tE7T2WfV2Gh4AG/lnOCoap1QJ
	5ViVWtSyJabZvhas79XGyTsFh/OQecRRqwP6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ei03Eapy2xOjEoEhed1R6CTDLmAsJW0o
	43uHej/nWmXdxvHXYilkrhfzqiZuiFoDmuFAXvYrm/hM1tl7A1CXZBT+vZS2SDCT
	NDg9js8WHYVnMYcuGqG9gj3wE3c/c6FmqkG3CscQ5NU6DJoUf/OXn6nRxmX2aZFu
	v2YwADfJVWE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B966AA2B90;
	Sat, 20 Mar 2010 11:23:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F357DA2B8D; Sat, 20 Mar
 2010 11:23:13 -0400 (EDT)
In-Reply-To: <CxNG4R6Vr07DvPgqJe5msXiOdQxDJcRUCjzNf-LPJNy2ozwVv3sxeG9yEQRNflvd8iDQ_qNtsIU@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Fri\, 19 Mar 2010 18\:36\:36 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 831EDFD0-3434-11DF-873A-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142716>

Thanks.
