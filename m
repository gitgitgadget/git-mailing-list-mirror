From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: respect in-reply-to regardless of threading
Date: Mon, 02 Mar 2009 23:16:11 -0800
Message-ID: <7veixfgjpg.fsf@gitster.siamese.dyndns.org>
References: <200903012237.40891.trast@student.ethz.ch>
 <74fdbb84d14a6d39f1b61e18ab9588ca08926292.1235947339.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Mar 03 08:17:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeOst-0007YD-49
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 08:17:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754125AbZCCHQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 02:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753871AbZCCHQS
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 02:16:18 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59463 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbZCCHQS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 02:16:18 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2A73F1037;
	Tue,  3 Mar 2009 02:16:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7D3361035; Tue, 
 3 Mar 2009 02:16:13 -0500 (EST)
In-Reply-To: <74fdbb84d14a6d39f1b61e18ab9588ca08926292.1235947339.git.trast@student.ethz.ch> (Thomas Rast's message of "Sun, 1 Mar 2009 23:45:41 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2F5278A6-07C3-11DE-A691-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112009>

Thomas Rast <trast@student.ethz.ch> writes:

> git-send-email supports the --in-reply-to option even with
> --no-thread.  However, the code that adds the relevant mail headers
> was guarded by a test for --thread.
>
> Remove the test, so that the user's choice is respected.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>
> Thomas Rast wrote:
>> But it also turns out, as you can see, that git-send-email happily
>> ignores --in-reply-to if threading is disabled. :-(
>
> This is the minimally intrusive fix.  It would be more consistent to
> ask for the in-reply-to regardless of thread setting, but it would
> also be less of a fix and more of a behaviour change.

I agree.  Tests?
