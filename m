From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-branch --with=commit
Date: Thu, 8 Nov 2007 03:02:03 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711080300100.4362@racer.site>
References: <7vpryl8x5t.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0711080008050.4362@racer.site> <7vk5ot7aqz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 04:02:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipxf0-0007dx-Ic
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 04:02:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372AbXKHDCL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 22:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753308AbXKHDCK
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 22:02:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:41368 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753241AbXKHDCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 22:02:09 -0500
Received: (qmail invoked by alias); 08 Nov 2007 03:02:06 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp016) with SMTP; 08 Nov 2007 04:02:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19dg50+Zbxds4DqodZzDbDYc4aEu8gH1s9qgqTbuL
	wGNldgW4kzkVh8
X-X-Sender: gene099@racer.site
In-Reply-To: <7vk5ot7aqz.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63927>

Hi,

On Wed, 7 Nov 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > would it not be better to call it --containing=commit?  Besides, I 
> > think that the opt_parse_with_commit() function would be better named 
> > opt_parse_commit() and be put into parse-options.[ch].
> 
> git-describe has "--contains" so that may be a better match.

I just thought what I would understand when reading "git branch 
--with=master".  I would have expected that it branches off of master.

> I do not know the particular function is generic enough to be in 
> parse-options.

Maybe not, you're right.  And we can always come back later, and expose 
the function if need be.

Ciao,
Dscho
