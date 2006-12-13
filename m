X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: StGit repo & gitweb, was Re: [PATCH] merge-recursive: add/add
 really is modify/modify with an empty base
Date: Thu, 14 Dec 2006 00:50:19 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612140048120.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061207101707.GA19139@spearce.org> 
 <Pine.LNX.4.63.0612100056090.28348@wbgn013.biozentrum.uni-wuerzburg.de> 
 <Pine.LNX.4.63.0612100114440.28348@wbgn013.biozentrum.uni-wuerzburg.de> 
 <7vmz5w5tuw.fsf@assigned-by-dhcp.cox.net> 
 <Pine.LNX.4.63.0612122347590.2807@wbgn013.biozentrum.uni-wuerzburg.de> 
 <7vvekgog0r.fsf@assigned-by-dhcp.cox.net> 
 <Pine.LNX.4.63.0612130402300.2807@wbgn013.biozentrum.uni-wuerzburg.de> 
 <7vvekgl2z2.fsf@assigned-by-dhcp.cox.net> 
 <Pine.LNX.4.63.0612131232270.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <b0943d9e0612131409x4a894f72if9c4d44cfa970be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 13 Dec 2006 23:50:31 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <b0943d9e0612131409x4a894f72if9c4d44cfa970be@mail.gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34264>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gudrk-0003mP-T8 for gcvg-git@gmane.org; Thu, 14 Dec
 2006 00:50:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751668AbWLMXuW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 18:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751672AbWLMXuW
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 18:50:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:38891 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1751668AbWLMXuV
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006 18:50:21 -0500
Received: (qmail invoked by alias); 13 Dec 2006 23:50:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp039) with SMTP; 14 Dec 2006 00:50:19 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 13 Dec 2006, Catalin Marinas wrote:

> On 13/12/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Tue, 12 Dec 2006, Junio C Hamano wrote:
> > 
> > > Although I would feel very happy about this change, Catalin
> > > might want to be informed about potential interaction this
> > > change might have with his commit 8d41555 in StGIT.
> > 
> > Indeed. Catalin, do you have any suggestion how to proceed? Do you want to
> > introduce a check if the file exists prior to re-generating it? Or do you
> > need some version check?
> 
> It currently checks whether the file exists and, if it doesn't, it is
> re-generated. I think the patch is good idea.

Thanks.

> > BTW why is StGit not on kernel.org?
> 
> Why would it be? Unless you know who to talk to for this :-), it's not 
> really a derivative of the Linux kernel.

There is plenty of stuff on kernel.org which is only related to the Linux 
kernel. And StGit (even if I did not try it yet), seems to be very 
valuable for working on the kernel.

> > Not that it matters: repo.or.cz has a nice mirror. Pasky, how powerful is
> > that machine? I am a happy user of the gitweb interface on that box...
> 
> Hopefully, when I get a bit of time, I'll try to give up the
> http-hosted repository and use Pasky's one exclusively.
> 
> BTW, how can I notify people that only pull from the http repository 
> that it will no longer be updated (rather than them thinking the 
> development stopped)? One solution would be to create a file with a 
> meaningful name in the top dir and hope people will notice it.

IMHO removing it altogether would be a good idea. The website should carry 
the news of the new repository site.

Ciao,
Dscho
