From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cvsexportcommit: be graceful when "cvs status" reorders
 the arguments
Date: Mon, 18 Feb 2008 16:27:00 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802181624490.30505@racer.site>
References: <alpine.LSU.1.00.0802180127100.30505@racer.site> <7vbq6fvudp.fsf@gitster.siamese.dyndns.org> <7vwsp3uf0u.fsf@gitster.siamese.dyndns.org> <47B9A354.7070905@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Mon Feb 18 17:27:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR8qL-0003Wt-4w
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 17:27:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754607AbYBRQ1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 11:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754006AbYBRQ1O
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 11:27:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:34691 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753519AbYBRQ1O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 11:27:14 -0500
Received: (qmail invoked by alias); 18 Feb 2008 16:27:12 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp008) with SMTP; 18 Feb 2008 17:27:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19PGj8YP2tPluKYlMIrekQ13qAzbFCUwtqpMMAEOu
	ur3yPotrvmEvK5
X-X-Sender: gene099@racer.site
In-Reply-To: <47B9A354.7070905@catalyst.net.nz>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74307>

Hi,

On Tue, 19 Feb 2008, Martin Langhoff wrote:

> Junio C Hamano wrote:
> > A related naming guideline I failed to follow (because I was mostly 
> > copying your code) suggests that the hash here should be named 
> > %fullname, instead of %basename.  Then logically:
> 
> Double ACK on your logic and arguments - I was thinking "fullname" as I 
> read your first email.

Okay, will change.

> Not sure how stable the output is across CVS versions/ports WRT leading 
> slashes, might be a good idea to try to canonicalise the paths.

Note that for this reason, only the "File:" output -- which does not show 
slashes, but only the basenames -- is used to match the files.  We need 
the full path in the git repository, though, to apply the patches.

> I am travelling at the moment, but I'll try and review the patch with 
> the actual code.

Thanks.  I am confident that I will have posted another version by the 
time you come around to review it.

Ciao,
Dscho
