From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/7] Provide API to invalidate refs cache
Date: Mon, 10 Oct 2011 17:02:09 -0700
Message-ID: <7vty7ggzum.fsf@alter.siamese.dyndns.org>
References: <1318225574-18785-1-git-send-email-mhagger@alum.mit.edu>
 <1318235064-25915-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 11 02:02:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDPnU-0005Mo-3o
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 02:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753551Ab1JKACM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 20:02:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60105 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751760Ab1JKACL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 20:02:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E7A456C1;
	Mon, 10 Oct 2011 20:02:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=vHNeIi1toPbMc2aTr1pKrdkNipg=; b=sd482W8j7FjoqdJNf1R6
	jgxOL0l/P13+5/F4rnXKa4BQtmZYbaNR3TcXk/xGcQJ0hTfKIEDkai+KTtI/E3VM
	DhuJ9kR4QDGEVjk8GuRpbPJikSUeMEKAVLzc0gkBP2QwswTlx5Ys8Byr1/50KGzk
	78H9lWLZB/LNrlg5ctY0TFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=b/iqbUS9YqnyXOmwkLkfI3KsZEFuUg88pznCACP966Gn5C
	5kqBdEKfnSqRSHr2XSl0pT5oH5B2BIG0Zss+L9av2VE7cb+dun08g/8Lpxkjv9SK
	KN1Ku+5ZR0f+w5HGuEx1jcGbdi+iBIR46JLPi7QDOztJDv+p0J2OsUJH0x+y8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0616256C0;
	Mon, 10 Oct 2011 20:02:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 949A856BF; Mon, 10 Oct 2011
 20:02:10 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4439B4BA-F39C-11E0-8822-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183276>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> These patches apply on top of mh/iterate-refs, which is in next but
> not in master.

Building your series on mh/iterate-refs would unfortunately make the
conflict resolution worse. It would have been better if this were based on
a merge between mh/iterate-refs and jp/get-ref-dir-unsorted (which already
has happened on 'master' as of fifteen minutes ago).

I could rebase your series, but it always is more error prone to have
somebody who is not the original author rebase a series than the original
author build for the intended base tree from the beginning.

Thanks.
