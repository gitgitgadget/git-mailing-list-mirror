From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-cvsserver runs hooks/post-receive
Date: Fri, 30 Nov 2007 12:03:15 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711301202230.27959@racer.site>
References: <1195809174-28142-1-git-send-email-mfwitten@mit.edu>
 <7v3aup291c.fsf@gitster.siamese.dyndns.org> <7F81126E-5A76-40CA-94BF-82B46C57AFF6@mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Fri Nov 30 13:03:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iy4b4-00088u-OE
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 13:03:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752496AbXK3MDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 07:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbXK3MDd
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 07:03:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:59219 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751761AbXK3MDd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 07:03:33 -0500
Received: (qmail invoked by alias); 30 Nov 2007 12:03:29 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp008) with SMTP; 30 Nov 2007 13:03:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/6Oxgg5Nv6Ywiqa+gsPFQJcS+pQCkG2Ax5SDkdoH
	Agy/jHcyjrh/5q
X-X-Sender: gene099@racer.site
In-Reply-To: <7F81126E-5A76-40CA-94BF-82B46C57AFF6@mit.edu>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66634>

Hi,

On Thu, 29 Nov 2007, Michael Witten wrote:

> In any case, I haven't taken a thorough look at how git-cvsserver works, 
> but it seems to duplicate a lot of git-receive-pack.
> 
> How about turning git-cvsserver into a true middleman, so that it 
> constructs a 'temporary git working tree' and then does a real git-push 
> into the final git repository.

That would yield a horrible performance.

Would be opposed, if a regular cvsserver user,
Dscho
