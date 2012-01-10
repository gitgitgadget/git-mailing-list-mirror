From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] Re-roll of the test fix for sed on solaris
Date: Mon, 09 Jan 2012 20:46:26 -0800
Message-ID: <7vpqesb1wd.fsf@alter.siamese.dyndns.org>
References: <7vd3b0vc6h.fsf@alter.siamese.dyndns.org>
 <1326163653-26565-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Tue Jan 10 05:46:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkTbb-0006GF-1N
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 05:46:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756119Ab2AJEqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 23:46:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48576 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756062Ab2AJEq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 23:46:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBC7560B4;
	Mon,  9 Jan 2012 23:46:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L4iHec9r4HLTUWwBR6L/mp5dqtI=; b=nnlmKj
	+uJKgDXmZmbLbgZlyeM2eLgSCIlFcRla8onpe5K5tjLXY2qaxxdEbfCs4I18hx38
	wl4TFQo3l/WHqRoSgcr6Slbm0yOyWa46ruxW37OzUphSODHGXdRxikT9EprnI7su
	5pyP7qHchfpzCJUng0M3JLVweWm6ggLHuDPQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gL1nBJFbmdNndlMZcJiypw9mIadkY0nP
	gyqXCz9j4DIKdo09wz9wDDDue3NyA8sir40hHurz14EuWK0Hpla1DTwVtBO0Mh3M
	XJgbkVOASDNp+cQ0KwI1WGgq67bkM0yjbQDn+g3AGh/Kuj2TOBN8P7ocbYn80QGV
	n3F+GF8CIzc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1F4C60B3;
	Mon,  9 Jan 2012 23:46:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 58D5360B1; Mon,  9 Jan 2012
 23:46:28 -0500 (EST)
In-Reply-To: <1326163653-26565-1-git-send-email-bwalton@artsci.utoronto.ca>
 (Ben Walton's message of "Mon, 9 Jan 2012 21:47:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F07C15A-3B46-11E1-BEA2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188214>

Ben Walton <bwalton@artsci.utoronto.ca> writes:

> It seems that you were correct in that it's the exit status from sed
> that ultimately causes the breakage.  I've updated the commit message
> to reflect this.

Thanks for being thorough. Very much appreciated.
