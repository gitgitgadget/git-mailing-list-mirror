From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/2] Use a common function to get the pretty name of
 refs
Date: Mon, 9 Mar 2009 12:00:11 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903091159000.19665@iabervon.org>
References: <alpine.LNX.1.00.0903082104410.19665@iabervon.org> <alpine.DEB.1.00.0903091036420.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 09 17:01:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LghvH-0002p0-UN
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 17:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbZCIQAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 12:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751603AbZCIQAR
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 12:00:17 -0400
Received: from iabervon.org ([66.92.72.58]:56277 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751441AbZCIQAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 12:00:16 -0400
Received: (qmail 5100 invoked by uid 1000); 9 Mar 2009 16:00:11 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Mar 2009 16:00:11 -0000
In-Reply-To: <alpine.DEB.1.00.0903091036420.10279@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112709>

On Mon, 9 Mar 2009, Johannes Schindelin wrote:

> Hi,
> 
> On Sun, 8 Mar 2009, Daniel Barkalow wrote:
> 
> > The result should be consistent between fetch and push, so we ought to 
> > use the same code in both cases, even though it's short.
> 
> You might want to mention that we cannot use skip_prefix() here, as that 
> function does not give us any clue if something was skipped at all, and we 
> must _not_ skip multiple prefixes.

I didn't even know about the skip_prefix() function; I just moved code 
around.

	-Daniel
*This .sig left intentionally blank*
