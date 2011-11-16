From: Junio C Hamano <gitster@pobox.com>
Subject: Re: odd name-rev behavior?
Date: Tue, 15 Nov 2011 21:41:01 -0800
Message-ID: <7vr518sjyq.fsf@alter.siamese.dyndns.org>
References: <20111115211514.GE27706@comcast.net>
 <7vpqgtt1kb.fsf@alter.siamese.dyndns.org>
 <7vlirht1fw.fsf@alter.siamese.dyndns.org>
 <20111116014842.GF27706@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Walberg <twalberg@comcast.net>
X-From: git-owner@vger.kernel.org Wed Nov 16 06:41:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQYFI-0004a1-H6
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 06:41:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077Ab1KPFlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 00:41:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45476 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752916Ab1KPFlE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 00:41:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6ED4068C4;
	Wed, 16 Nov 2011 00:41:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gKqj19pgoUGPTdXp6J35QgAG5Bg=; b=ZO2r3V
	O5vV6FYNwEchx0ooiLISGiLC6FOv2LgJRLysDHbwCsW/7pf4z3Aof3WRKsJCNOfJ
	iIYSvYI6qVA3Y25wLk04j5bnPQzhj++KoPrJiteL/8abdptrQcPF8zFjl0svY7mi
	aYSLstyrRoPTxuBqjvnWp0zqGivadnuIXbZTA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KOkYVPQlEl6GUY/PW3jcUu4B4WTT0W7K
	mhUs9MaNvSgvgeYgNBhqExY9tDiEl614ePcT41L3RrKhZCTNVYv8kmn4M6XTafJn
	uQ0DYL/TZRg6+DFHNt9igdQTD8+ggQ8qjIBTWzADRPt7ZlBMcik6V7UXvKtIWSxC
	L6HEqt33Frg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66E8868C3;
	Wed, 16 Nov 2011 00:41:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F0D0868C2; Wed, 16 Nov 2011
 00:41:02 -0500 (EST)
In-Reply-To: <20111116014842.GF27706@comcast.net> (Tim Walberg's message of
 "Tue, 15 Nov 2011 19:48:42 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 92234584-1015-11E1-B586-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185506>

Tim Walberg <twalberg@comcast.net> writes:

> That does indeed seem to work on first try. Not sure it was
> a particularly critical issue - just unexpected.

I didn't think it is particularly critical, either, and that is why I said
it has been like this for eons at least since v1.6.0.

And it turns out that this was pretty much from day one of name-rev at
bd321bc (Add git-name-rev, 2005-10-26).
