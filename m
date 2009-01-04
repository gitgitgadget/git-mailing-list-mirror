From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 2/3] unpack-trees: fix path search bug in verify_absent
Date: Sun, 4 Jan 2009 21:01:35 +0100
Message-ID: <20090104200133.GA2202@localhost>
References: <1230843273-11056-1-git-send-email-drizzd@aon.at> <1230843273-11056-2-git-send-email-drizzd@aon.at> <1230843273-11056-3-git-send-email-drizzd@aon.at> <alpine.DEB.1.00.0901022248070.27818@racer> <20090103103904.GA4479@localhost> <alpine.DEB.1.00.0901031353090.30769@pacific.mpi-cbg.de> <7vtz8fz8yd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 04 21:03:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJZCK-0007lu-5J
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 21:03:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758837AbZADUCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 15:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758687AbZADUB6
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 15:01:58 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:33652 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758608AbZADUB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 15:01:58 -0500
Received: from darc.dyndns.org ([80.123.242.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 4 Jan 2009 21:01:50 +0100
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1LJZAF-0000zx-Gy; Sun, 04 Jan 2009 21:01:35 +0100
Content-Disposition: inline
In-Reply-To: <7vtz8fz8yd.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 04 Jan 2009 20:01:54.0063 (UTC) FILETIME=[4A3941F0:01C96EA7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104538>

Hi,

On Sun, Jan 04, 2009 at 02:01:14AM -0800, Junio C Hamano wrote:
>     The function's purpose is ....  Before entering the loop to count the
>     number of entries to skip, this check to detect if we do not even have
>     to count appears.  When this check triggers, we know we do not want to
>     skip anything, and returning constant 0 is much clearer than returning
>     a variable cnt that was initialized to 0 near the beginning of the
>     function; we haven't even started using it to count yet.
> 
> But the point is, if that is the reason the author thinks it is an
> improvement, that probably needs to be stated.

If you want to check the validity of the patch you have to view it in
context anyways. Compared to understanding the change to the code, it takes
much longer to parse and understand the above paragraph _plus_ verify its
agreement with the code. I think you will agree that there is a limit to the
amount of documentation that's still useful.

My estimate of this limit is apparently much lower than what is expected by
the main contributors to this project. I respect that and I will try not to
waste your time any further.

What's sad, however, is that we are now discussing style and commenting
issues of a line of code, which, as by my analysis of [PATCH 3/3] never
actually gets executed in the first place. I would have been much more
curious about your comments on that.

Best regards,
Clemens
