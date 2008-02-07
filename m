From: Mike Hommey <mh@glandium.org>
Subject: Re: git-fetch in 1.5.4 fails versus 1.5.3.8
Date: Thu, 7 Feb 2008 23:02:43 +0100
Organization: glandium.org
Message-ID: <20080207220243.GA7237@glandium.org>
References: <pan.2008.02.04.18.25.26@progsoc.org> <20080205050741.GA4624@coredump.intra.peff.net> <pan.2008.02.06.21.56.35@progsoc.org> <20080207042332.GA7632@sigill.intra.peff.net> <pan.2008.02.07.10.15.05@progsoc.org> <20080207110601.GA8488@coredump.intra.peff.net> <20080207121042.GA10210@glandium.org> <20080207122842.GA17184@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 07 23:03:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNEpi-0003Rj-4A
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 23:03:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755739AbYBGWC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 17:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754800AbYBGWC1
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 17:02:27 -0500
Received: from vuizook.err.no ([85.19.215.103]:46611 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753130AbYBGWC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 17:02:26 -0500
Received: from aputeaux-153-1-42-109.w82-124.abo.wanadoo.fr ([82.124.6.109] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JNEpt-0000Gd-Hb; Thu, 07 Feb 2008 23:03:19 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JNEpP-0002Ku-Kh; Thu, 07 Feb 2008 23:02:43 +0100
Content-Disposition: inline
In-Reply-To: <20080207122842.GA17184@coredump.intra.peff.net>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73010>

On Thu, Feb 07, 2008 at 07:28:42AM -0500, Jeff King wrote:
> On Thu, Feb 07, 2008 at 01:10:43PM +0100, Mike Hommey wrote:
> 
> > > It would be nice if we could generate a minimal test case that
> > > demonstrates the problem, but I can't seem to reproduce it with a
> > > smaller program. If we could, then we could probably get advice from
> > > curl and/or gnutls people.
> > 
> > Did you try to run with the GIT_SSL_NO_VERIFY environment variable set ?
> 
> Yes (I even suggested this earlier in the thread). It returns a
> different error from gnutls (see Anand's earlier response).

Sorry, I've had trouble opening my eyes and actually reading messages I
reply to... anyways, I tried to reproduce with curl-gnutls and...
couldn't... How did you manage that ? Is the server you were trying on
public ? Do you have any http.ssl* variables set in your configuration ?

Mike
