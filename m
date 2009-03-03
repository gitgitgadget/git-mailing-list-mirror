From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] send-email: add --confirm option and configuration
 setting
Date: Mon, 02 Mar 2009 22:53:06 -0800
Message-ID: <7vsklvgkrx.fsf@gitster.siamese.dyndns.org>
References: <7v1vtfjpad.fsf@gitster.siamese.dyndns.org>
 <1236055938-65407-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 07:54:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeOWY-0002qF-0J
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 07:54:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693AbZCCGxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 01:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753490AbZCCGxO
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 01:53:14 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58431 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753594AbZCCGxO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 01:53:14 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8B5483F2A;
	Tue,  3 Mar 2009 01:53:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BDC113F29; Tue, 
 3 Mar 2009 01:53:07 -0500 (EST)
In-Reply-To: <1236055938-65407-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Mon, 2 Mar 2009 23:52:18 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F6A15A84-07BF-11DE-B603-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112004>

Jay Soffian <jaysoffian@gmail.com> writes:

> There is a slight fib in message informing the user of the
> sendemail.confirm setting and this is intentional. Setting 'auto'
> differs from leaving sendemail.confirm unset in two ways: 1) 'auto'
> obviously squelches the informational message; 2) 'auto' prompts when
> the Cc list has been expanded even in the presence of a --suppress
> related option, where leaving sendemail.confirm unset does not. This is
> intentional to keep the message simple, and to avoid adding another
> sendemail.confirm value ('auto-except-suppress'?).

I suspect you may get bug reports and refinement patches on top of this to
fix the last issue up, but I think that better should happen once the base
patch is in-tree.

Let's queue this to 'pu' and see how people react. 

Thanks.
