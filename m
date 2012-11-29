From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8] Add function strbuf_addstr_xml_quoted() and more
Date: Thu, 29 Nov 2012 13:41:32 -0800
Message-ID: <7v38zsozn7.fsf@alter.siamese.dyndns.org>
References: <1353841721-16269-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeremy White <jwhite@codeweavers.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Nov 29 22:41:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeBrk-0003ua-3a
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 22:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754931Ab2K2Vlg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 16:41:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52881 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754803Ab2K2Vlf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 16:41:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3262AAD6;
	Thu, 29 Nov 2012 16:41:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r2YYIX/0OuA+SW6fxwy3Wq+NI6E=; b=C6WqT5
	/cmtmooMjov1KsGhM0Bh1+iIRNHD2OAnx2uV74wuLk9mvxPo9ucJhmYR0ClIB+6N
	y5hQLQt71XZpE1knUV79ol8tO/AtD5agSwj/ERPVnBO2nxwmSeh2eJ4/qPQ38Xd0
	sRVOF1M802moSMN+vV2ZPv1CFqFALSJ4vfjbA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LNtwg9JGiG5HNORuEsWdhyNBxEx8ZBZ/
	apEjoumJhhlCtAM5LUvrXNYgAzOOYvHyKdaZNYOp0R9MoWGuYOZRG1w7oxKpv2LV
	UYL4Yqy+VxMthKpA6EE2mggYoa6n201ITRV9FKAEFiepg1KuDH0uv1Q43IY0lPB5
	pn3IW+eLuE4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FF48AAD3;
	Thu, 29 Nov 2012 16:41:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 19D35AAD0; Thu, 29 Nov 2012
 16:41:34 -0500 (EST)
In-Reply-To: <1353841721-16269-1-git-send-email-mhagger@alum.mit.edu>
 (Michael Haggerty's message of "Sun, 25 Nov 2012 12:08:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8B852EE4-3A6D-11E2-A733-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210878>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> There were two functions doing almost the same XML quoting of
> character entities, so implement a library function
> strbuf_addstr_xml_quoted() and use that in both places.
>
> Along the way, do a lot of simplification within imap-send.c, which
> was doing a lot of its own string management instead of using strbuf.

Overall the series looked good to me.  Thanks; will queue.
