From: Michael Weiser <michael@weiser.dinsnail.net>
Subject: Re: [PATCH] Extend runtime prefix computation
Date: Wed, 20 Apr 2016 19:52:07 +0200
Message-ID: <20160420175207.GA28640@weiser.dinsnail.net>
References: <alpine.DEB.2.20.1604180918500.2967@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	David Abdurachmanov <David.Abdurachmanov@cern.ch>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 20 21:00:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asxMM-0003SI-TD
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 21:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbcDTTAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 15:00:16 -0400
Received: from heinz.dinsnail.net ([85.214.155.104]:43744 "EHLO
	heinz.dinsnail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbcDTTAO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 15:00:14 -0400
X-Greylist: delayed 3576 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Apr 2016 15:00:14 EDT
Received: from heinz.dinsnail.net (localhost [127.0.0.1])
	by heinz.dinsnail.net (8.14.9/8.14.9) with ESMTP id u3KI08NN027094;
	Wed, 20 Apr 2016 20:00:08 +0200
Received: from eldalonde.UUCP (uucp@localhost)
	by heinz.dinsnail.net (8.14.9/8.14.9/Submit) with bsmtp id u3KI07oZ027093;
	Wed, 20 Apr 2016 20:00:07 +0200
Received: from eldalonde.weiser.dinsnail.net (localhost [127.0.0.1])
	by eldalonde.weiser.dinsnail.net (8.14.9/8.14.8) with ESMTP id u3KHq7xe028811;
	Wed, 20 Apr 2016 19:52:07 +0200
Received: (from michael@localhost)
	by eldalonde.weiser.dinsnail.net (8.14.9/8.14.8/Submit) id u3KHq7m3028810;
	Wed, 20 Apr 2016 19:52:07 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1604180918500.2967@virtualbox>
 <xmqqfuumddqm.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-dinsnail.net-MailScanner-ID: u3KI08NN027094
X-MailScanner: Found to be clean
X-MailScanner-From: michael@weiser.dinsnail.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292056>

Hi,

On Fri, Apr 15, 2016 at 09:43:29AM -0700, Junio C Hamano wrote:

> We tend to avoid system specific includes in individual *.c files.

> Perhaps implement platform specific bits in compat/?  E.g. each
> platform specific file in compat/ may implement and export the same
> git_extract_argv_path() function, perhaps, so that this file does
> not even need to know what platforms it supports?

On Mon, Apr 18, 2016 at 09:20:25AM +0200, Johannes Schindelin wrote:

> I have to admit that I am really, *really* skeptical. To me, it looks like
> this patch opens the door very wide to unintended consequences.

To make it short: I had received interest from another user for
relocatable git installations and an updated patch against current git
(based on my last post of the code to this list in 2012). This
confirmed to me that the use case is still valid. However, I do not see
myself in a position to iterate the code through the review and
improvement process that starting to unfold now. So if someone sometime
picks this up and carries on, I'd be happy. Otherwise please disregard.
-- 
Thanks,
Michael
