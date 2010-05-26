From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] commit: show abbreviated sha for commits with empty
 diffs
Date: Tue, 25 May 2010 22:07:22 -0700
Message-ID: <7viq6bqmid.fsf@alter.siamese.dyndns.org>
References: <1274694452-4200-1-git-send-email-rctay89@gmail.com>
 <1274694452-4200-2-git-send-email-rctay89@gmail.com>
 <1274694452-4200-3-git-send-email-rctay89@gmail.com>
 <1274694452-4200-4-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Jeff King" <peff@peff.net>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 26 07:07:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH8qI-0005SM-3n
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 07:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932609Ab0EZFHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 01:07:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47938 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932536Ab0EZFHb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 01:07:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 18A73B67B8;
	Wed, 26 May 2010 01:07:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=i4hyFMFnPFniz/s9qvmhWS+FPNU=; b=CNDE8O6is2igwM3pDvRVxyv
	C6sBao/5p/Rx8lEGe6LcjETOCPOwrIv6TSealKE7Qx2knX799R6p5DJ8U8Ah/c+S
	NV9MY2RmdRL+CFwtuPAJi+7xzHbbkD9hGfwkOT6xaaJoFxdaznMefY7DC55scRir
	vu+MfkPtr6XDpR4v0aS8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Dtc6V/DGy90e6g7JiXLAS32lmdOComL4blbemVPzh81KhTGVH
	bomjYzaIdNe1Y2znJBTKqe5/laKzO2IT8cluTVUPkBwTZHjjqudoc1Sf7PIqsSga
	Ans7Ts7wrHgdSW9Az7sPNXljrrRn0sNli4shVp2XbrvC+yIGt/9y47SNes=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D6B9DB67B4;
	Wed, 26 May 2010 01:07:27 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B72AB67B2; Wed, 26 May
 2010 01:07:24 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 945CFBC2-6884-11DF-B453-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147739>

The fix itself might be trivial, but the series seems to break 7502.20
and 7502.22

Thanks.
