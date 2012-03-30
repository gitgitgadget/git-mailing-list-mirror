From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make http-backend REMOTE_USER configurable
Date: Fri, 30 Mar 2012 09:13:13 -0700
Message-ID: <7vvclmm5ie.fsf@alter.siamese.dyndns.org>
References: <1333051139-14262-1-git-send-email-willsk@bnl.gov>
 <7vzkazoyk3.fsf@alter.siamese.dyndns.org>
 <20120329222230.GB1413@sigill.intra.peff.net>
 <20120329222632.GC1413@sigill.intra.peff.net>
 <7vk422q2ho.fsf@alter.siamese.dyndns.org>
 <20120330070130.GA30656@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: William Strecker-Kellogg <willsk@bnl.gov>,
	Git List <git@vger.kernel.org>, spearce@spearce.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 30 18:13:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDeSF-00025E-Qi
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 18:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760849Ab2C3QNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 12:13:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47692 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754105Ab2C3QNP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 12:13:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00F4B5277;
	Fri, 30 Mar 2012 12:13:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=yHOjpj
	gbVWtDW8BEDP6s2prkeauhF7dFRtiXOpnTD+PGWv/WNX9xvsJMhhYqV4+0HQM8xY
	lJh7XbxIdkJK3VY8ju77Gy/RAxrXuI2+x1R2kZgWIAgaTR5Bej23R9EXWyh0NLLj
	xmUt19NdKe/hBREGCvuSuma8neZTXhTvZ9FU0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JDGE9vtHRLo4VI6Zic5dcaLp7t9atsi7
	kasjh8PDW1zt+I15ljnk2ObYKnpT712bRBO1jcW/kNNf2pIK83K+AwHUmqf0r+n8
	CLmve8TQAo79Xv6zYLBqzxatNiShoyx/5SoJCWBvEpGosVZT5VfHKasqSDCKj1GU
	ZKuXZ9W2slk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EBC635276;
	Fri, 30 Mar 2012 12:13:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 845E55275; Fri, 30 Mar 2012
 12:13:14 -0400 (EDT)
In-Reply-To: <20120330070130.GA30656@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 30 Mar 2012 03:01:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 40DFD6B4-7A83-11E1-BA3A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194372>

Thanks.
