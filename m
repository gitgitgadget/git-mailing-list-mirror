From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v3] git-add--interactive: manual hunk editing mode
Date: Mon, 09 Jun 2008 07:46:22 +0200
Message-ID: <200806090746.22512.johan@herland.net>
References: <200805232221.45406.trast@student.ethz.ch>
 <200806090032.27516.trast@student.ethz.ch>
 <alpine.DEB.1.00.0806090018350.1783@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 09 07:48:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5aEq-00055e-7G
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 07:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378AbYFIFrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 01:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752964AbYFIFrW
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 01:47:22 -0400
Received: from smtp.getmail.no ([84.208.20.33]:33439 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752775AbYFIFrV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 01:47:21 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K2600I0PLETN300@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 09 Jun 2008 07:47:17 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K26001B8LDANN60@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 09 Jun 2008 07:46:22 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K260096LLDARTT2@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 09 Jun 2008 07:46:22 +0200 (CEST)
In-reply-to: <alpine.DEB.1.00.0806090018350.1783@racer>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84362>

On Monday 09 June 2008, Johannes Schindelin wrote:
> Hi,
>
> On Mon, 9 Jun 2008, Thomas Rast wrote:
> > Compared to the competing bikeshed
> >   http://article.gmane.org/gmane.comp.version-control.git/83894
>
> If you really think this is a bikeshed, I better spend my time elsewhere.

Is there a good reason against having *both*?

AFAICS, there's nothing stopping us from having both a "-e"-option to 
git-add, and an "e"-command inside git-add--interactive.

...just like we have "-p" and "p" today...

("git-add -e" would open the entire diff in an editor, as would "e" from the 
*main* menu of git-add--interactive. However, "e" from the *single hunk* 
menu would of course open only that single hunk within the editor. We could 
even have an "E" command to open all remaining/undecided hunks in an 
editor.)


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
