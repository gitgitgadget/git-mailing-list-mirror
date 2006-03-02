From: Greg KH <greg@kroah.com>
Subject: Re: Problems with using git
Date: Thu, 2 Mar 2006 15:58:24 -0800
Message-ID: <20060302235824.GA13436@kroah.com>
References: <44063B7C.40609@webdrake.net> <Pine.LNX.4.64.0603011651240.22647@g5.osdl.org> <4406F8B1.9050303@webdrake.net> <4406FA46.7080608@op5.se> <7vr75k5s4y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 03 00:59:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FExh8-0005yJ-Fh
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 00:58:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbWCBX6v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 18:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751746AbWCBX6v
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 18:58:51 -0500
Received: from mail.kroah.org ([69.55.234.183]:1968 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751087AbWCBX6u (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 18:58:50 -0500
Received: from [192.168.0.10] (dsl093-040-174.pdx1.dsl.speakeasy.net [66.93.40.174])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id k22NwiK25039;
	Thu, 2 Mar 2006 15:58:44 -0800
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1FExge-3Vt-00; Thu, 02 Mar 2006 15:58:24 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vr75k5s4y.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17123>

On Thu, Mar 02, 2006 at 03:44:13PM -0800, Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
> > Joseph Wakeling wrote:
> >> Thanks very much to all who offered advice on this. :-)
> >> Unfortunately openSUSE is somewhat out of sync not just with git but
> >> in
> >> libraries necessary to install the latest version (libcrypto.so.4,
> >> libssl.so.4).  The openssl (0.9.7g-2.4) and openssl-devel (0.9.7g-2)
> >> packages don't contain these but rather contain libcrypto.so.0.9.7 and
> >> libssl.0.9.7.  Just in case it's important to future git development.
> >
> > It might be useful for the openSuSE developers, but for git this is
> > totally irrelevant.
> 
> True, but I had an impression that we had active developers in
> git community who are close to Suse, and I wonder why this
> hadn't come up earlier.  Maybe our userbase and Suse's userbase
> do not overlap much?

Yes, some of us are quite close to SuSE :)

Anyway, the issue is that 10.0 was released about 6 months ago, and
contains the version of git at that time.  The latest development tree,
and the latest public betas contain 1.1.3.  If you think this should be
newer, I can easily go poke the proper people...

thanks,

greg k-h
