From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: Why does gpg.program work for commit but not log?
Date: Wed, 18 Jun 2014 08:38:32 -0400
Organization: PD Inc
Message-ID: <9B9CF0F915BD4325BC92BBA1339B1B4E@black>
References: <ABACA8639E2A49BA8A1E602DBE815867@black> <20140618073645.GA24769@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Jeff King'" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 18 14:38:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxF8V-0000x3-RZ
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 14:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966441AbaFRMik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 08:38:40 -0400
Received: from mail.pdinc.us ([67.90.184.27]:47536 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966138AbaFRMij (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 08:38:39 -0400
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id s5ICcWvt018065;
	Wed, 18 Jun 2014 08:38:32 -0400
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20140618073645.GA24769@sigill.intra.peff.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Thread-Index: Ac+KyBZYVUjntEcaQme5feUx+r3vuwAKdz6g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251983>

> -----Original Message-----
> From: git-owner@vger.kernel.org 
> [mailto:git-owner@vger.kernel.org] On Behalf Of Jeff King
> Sent: Wednesday, June 18, 2014 3:37
> To: Jason Pyeron
> Cc: git@vger.kernel.org
> Subject: Re: Why does gpg.program work for commit but not log?
> 
> On Wed, Jun 18, 2014 at 12:18:35AM -0400, Jason Pyeron wrote:
> 
> > jpyeron@black /projects/microsoft-smartcard-sign/tmp
> > $ git --version
> > git version 1.7.9
> 
> That's rather old. In the meantime we have:
> 
> 	commit 6005dbb9bf21d10b209f7924e305bd04b9ab56d2
> 	Author: Jacob Sarvis <jsarvis@openspan.com>
> 	Date:   Wed Mar 27 10:13:39 2013 -0500
> 	
> 	    log: read gpg settings for signed commit verification
> 	    
> 	    "show --show-signature" and "log --show-signature" 
> do not read the
> 	    gpg.program setting from git config, even though, 
> commit signing,
> 	    tag signing, and tag verification honor it.
> 
> which is in v1.8.3.  In general, please double-check your problem
> against a recent version of "master" when making a bug report.
> 

I will (try to) compile master and test. This is the latest version in cygwin.

--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.

 
