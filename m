From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 8/8] Docs: config: send-email config options included
Date: Sun, 28 Sep 2008 15:06:15 -0400
Message-ID: <20080928190615.GA32380@coredump.intra.peff.net>
References: <1222564196-84202-1-git-send-email-mfwitten@mit.edu> <1222564196-84202-2-git-send-email-mfwitten@mit.edu> <1222564196-84202-3-git-send-email-mfwitten@mit.edu> <1222564196-84202-4-git-send-email-mfwitten@mit.edu> <1222564196-84202-5-git-send-email-mfwitten@mit.edu> <1222564196-84202-6-git-send-email-mfwitten@mit.edu> <1222564196-84202-7-git-send-email-mfwitten@mit.edu> <1222564196-84202-8-git-send-email-mfwitten@mit.edu> <20080928032407.GC15696@sigill.intra.peff.net> <C0DC4F74-6157-44AE-A25A-4C74A415CDDA@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Sun Sep 28 21:07:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kk1c6-0006YO-KA
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 21:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391AbYI1TGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 15:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752393AbYI1TGR
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 15:06:17 -0400
Received: from peff.net ([208.65.91.99]:4032 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752380AbYI1TGR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 15:06:17 -0400
Received: (qmail 7903 invoked by uid 111); 28 Sep 2008 19:06:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 28 Sep 2008 15:06:16 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Sep 2008 15:06:15 -0400
Content-Disposition: inline
In-Reply-To: <C0DC4F74-6157-44AE-A25A-4C74A415CDDA@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96984>

On Sun, Sep 28, 2008 at 02:03:59PM -0500, Michael Witten wrote:

>> Note that this list is non-comprehensive and not necessarily complete.
>> For command-specific variables, you will find a more detailed  
>> description
>> in the appropriate manual page. You will find a description of non-core
>> porcelain configuration variables in the respective porcelain  
>> documentation.
>
> I think config.txt is not the place to put this stuff (though I've only
> given it a quick glance), and include:: will just cause us to litter
> the place with tool-config.txt include files, which looks yucky and is
> subject to neglect.

Ah, I hadn't read that before. So yes, I agree that it should go into
git-send-email.txt. I do think putting a note (similar to the one for
imap.*) into config.txt would be a nice addition, but it is obviously
independent of your other changes.

-Peff
