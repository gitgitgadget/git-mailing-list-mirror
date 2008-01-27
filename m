From: Mike Hommey <mh@glandium.org>
Subject: Re: Is there a reason to keep walker.c ?
Date: Sun, 27 Jan 2008 21:51:55 +0100
Organization: glandium.org
Message-ID: <20080127205155.GA5476@glandium.org>
References: <20080127204535.GA4702@glandium.org> <alpine.LSU.1.00.0801272045490.23907@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 27 22:02:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJEe7-0003Ij-B2
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 22:02:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754169AbYA0VCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 16:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754144AbYA0VCA
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 16:02:00 -0500
Received: from vuizook.err.no ([85.19.215.103]:39393 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753454AbYA0VB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 16:01:59 -0500
Received: from aputeaux-153-1-83-190.w86-205.abo.wanadoo.fr ([86.205.41.190] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JJEe6-0002jr-UC; Sun, 27 Jan 2008 22:02:31 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JJETr-0001Qv-Lw; Sun, 27 Jan 2008 21:51:55 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0801272045490.23907@racer.site>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71831>

On Sun, Jan 27, 2008 at 08:46:59PM +0000, Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 27 Jan 2008, Mike Hommey wrote:
> 
> > While working on the http code refactoring, I got to wonder if the 
> > walker.c "wrapper", that is only used for the http transport, is still 
> > worth keeping. If there are plans for others transport to use this code, 
> > obviously, it would be worth keeping, but on the contrary, I think it 
> > would simplify the http transport code even more. What do you think ?
> 
> Really, I was waiting for somebody needing ftp and/or sftp support badly 
> enough, so let's keep it.
> 
> I mean, one of those guys asking for ftp push support _got_ to just start 
> scratching that itch, right?

Though, technically, ftp push could work with the curl code.

Mike
