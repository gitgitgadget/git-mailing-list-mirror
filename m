From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git blame crashes with internal error
Date: Sun, 14 Oct 2007 18:32:44 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710141830050.25221@racer.site>
References: <20071014143628.GA22568@atjola.homenet> <47122D02.9060204@op5.se>
 <20071014152327.GA24003@atjola.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, gitster@pobox.com,
	git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 14 19:33:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih7Kl-000377-On
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 19:33:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758155AbXJNRcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 13:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758159AbXJNRcu
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 13:32:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:59805 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753681AbXJNRct (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 13:32:49 -0400
Received: (qmail invoked by alias); 14 Oct 2007 17:32:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 14 Oct 2007 19:32:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1//Etxr6uz/Qh9NcBJybzDIJ/GPnexdELTI/U8E6n
	IR6aIw0CKB7mDi
X-X-Sender: gene099@racer.site
In-Reply-To: <20071014152327.GA24003@atjola.homenet>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60879>

Hi,

On Sun, 14 Oct 2007, Bj?rn Steinbrink wrote:

> On 2007.10.14 16:51:46 +0200, Andreas Ericsson wrote:
> > Bj?rn Steinbrink wrote:
> >> I tried all git releases from 1.5.3 to 1.5.3.4 as well as the current
> >> master and all of them crashed. A small shell script to reproduce the
> >> problem is attached.
> >
> > Manual bisect? Ugh. This *is* the century of the competent developer
> > tools, you know... ;-)
> 
> Then, how do I search for a good version with git bisect if I only have
> the one data-point "master is bad"?

AFAIK Junio introduced the option to start with just a bad commit, and no 
known "good" one.

Yep, just found it.  Since v1.5.2-rc0~77^2(git-bisect: allow bisecting 
with only one bad commit.) it is supported.

>From the commit message:

    This allows you to say:

        git bisect start
        git bisect bad $bad
        git bisect next

I don't know if it is in the documentation (I rarely read it), so if it is 
missing, it would be nice if you could add the description there.

Ciao,
Dscho
