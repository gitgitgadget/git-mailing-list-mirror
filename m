From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 4/3] Add example git-vcs-p4
Date: Sun, 11 Jan 2009 18:08:32 -0800
Message-ID: <7vy6xhl1i7.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0901110336380.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Jan 12 03:10:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMCFd-0005Sh-8r
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 03:10:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbZALCIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 21:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbZALCIi
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 21:08:38 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47692 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbZALCIh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 21:08:37 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 41A891C481;
	Sun, 11 Jan 2009 21:08:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C28D11C480; Sun,
 11 Jan 2009 21:08:33 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0901110336380.19665@iabervon.org> (Daniel
 Barkalow's message of "Sun, 11 Jan 2009 15:12:13 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EC4D287C-E04D-11DD-BCDD-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105279>

Hmm...

    CC vcs-p4.o
cc1: warnings being treated as errors
vcs-p4.c: In function 'output_data':
vcs-p4.c:253: warning: format '%d' expects type 'int', but argument 2 has type 'size_t'
vcs-p4.c: In function 'p4_where':
vcs-p4.c:291: warning: ISO C90 forbids mixed declarations and code
vcs-p4.c: In function 'p4_submit':
vcs-p4.c:363: warning: ISO C90 forbids mixed declarations and code
vcs-p4.c: In function 'p4_print':
vcs-p4.c:433: warning: format '%d' expects type 'int', but argument 2 has type 'size_t'
vcs-p4.c: In function 'p4_change':
vcs-p4.c:453: warning: ISO C90 forbids mixed declarations and code
vcs-p4.c: In function 'p4_filelog':
vcs-p4.c:504: warning: ISO C90 forbids mixed declarations and code
make: *** [vcs-p4.o] Error 1
