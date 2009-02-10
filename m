From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/RFH] Fun things with git-notes, or: patch tracking
 backwards
Date: Tue, 10 Feb 2009 14:59:27 -0800
Message-ID: <7v7i3xlwz4.fsf@gitster.siamese.dyndns.org>
References: <200902091508.11460.trast@student.ethz.ch>
 <200902102342.29962.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Feb 11 00:01:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX1bB-0005Y5-Tk
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 00:01:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756646AbZBJW7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 17:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756497AbZBJW7d
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 17:59:33 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58933 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756441AbZBJW7d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 17:59:33 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EBCEA2ADD3;
	Tue, 10 Feb 2009 17:59:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5A9CA2ADCB; Tue,
 10 Feb 2009 17:59:29 -0500 (EST)
In-Reply-To: <200902102342.29962.trast@student.ethz.ch> (Thomas Rast's
 message of "Tue, 10 Feb 2009 23:42:27 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7A5D3A6E-F7C6-11DD-8E2D-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109333>

Thomas Rast <trast@student.ethz.ch> writes:

> I have imported all commits, and mails since roughly July 2008
> (starting with Gmane 89000).  In this timeframe there were 1802
> non-merge commits, and the mailnotes tree now holds 1122 annotations.

How do you match the mails to commits?

I am curious what the right balance for the matching algorithm should be,
between being forgiving about amending of commit log message and the patch
text to fix minor typos and obvious bugs, and being strict not to cause
false matches to a message that contains the second iteration of the
patch, when what was committed was the first iteration.
