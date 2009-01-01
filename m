From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Subject: [PATCH] Documentation/git-merge: deprecated syntax
 moved to end
Date: Thu, 01 Jan 2009 13:00:55 -0800
Message-ID: <7vsko2hhbs.fsf@gitster.siamese.dyndns.org>
References: <87bpuqvpfz.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Thu Jan 01 22:02:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIUgc-0005rK-7D
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 22:02:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbZAAVBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 16:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752943AbZAAVBD
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 16:01:03 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51637 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926AbZAAVBC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 16:01:02 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0316E8C150;
	Thu,  1 Jan 2009 16:01:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3F9668C14F; Thu,
  1 Jan 2009 16:00:57 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4AC94192-D847-11DD-B033-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104327>

jidanni@jidanni.org writes:

> Moving the deprecated syntax moved to the end of the document.
> Or please at least stamp it *deprecated* in the SYNOPSIS, in case the
> user reads no further down the page.

To my mind, there is a difference between something being kept (and will
be kept for foreseeable future), and something being deprecated (and
eventual removal is at least contemplated).  The original merge syntax
falls into the first category, and the current description is correct and
fine as-is.

The wording "for historical reasons" does not refer to the reason why the
second syntax is still kept.  It merely refers to the reason why two
syntaxes exist in the first place.
