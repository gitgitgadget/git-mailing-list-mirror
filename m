From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 00/40] MinGW port
Date: Mon, 3 Mar 2008 19:34:25 +0100
Message-ID: <200803031934.25569.johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <200803022220.59711.johannes.sixt@telecom.at> <alpine.LSU.1.00.0803022200070.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 19:35:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWFVC-00008l-80
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 19:35:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754261AbYCCSe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 13:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754203AbYCCSe2
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 13:34:28 -0500
Received: from smtp1.srv.eunet.at ([193.154.160.119]:43444 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753928AbYCCSe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 13:34:27 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id 032A233BB6;
	Mon,  3 Mar 2008 19:34:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id C4BB560FA1;
	Mon,  3 Mar 2008 19:34:25 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LSU.1.00.0803022200070.22527@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75965>

On Sunday 02 March 2008 23:07, Johannes Schindelin wrote:
> On Sun, 2 Mar 2008, Johannes Sixt wrote:
> > diff --git a/Makefile b/Makefile
> > index 53a4e2a..2ea53c0 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -265,6 +265,7 @@ PROGRAMS = \
> >  	git-pack-redundant$X git-var$X \
> >  	git-merge-tree$X \
> >  	git-merge-recursive$X \
> > +	$(POSIX_ONLY_PROGRAMS) \
> >  	$(EXTRA_PROGRAMS)
>
> Clever name!  But shouldn't EXTRA_PROGRAMS go?

No. It was there before I messed around with it.

> > -			/* Thanks, Bill. You'll burn in hell for that. */
>
> Boo.  My nice comment.  You just deleted it.  ;-)

It's not my fault, I swear it. It went like this: I erased the line, but then 
changed my mind and hit Undo. But then I thought, this is a serious project, 
we don't need such language. And hit Redo. Which made me think again... So I 
said to my little rascal, who was playing Lego: "Say 'stop'", and I hit Undo 
and Redo as fast as I could. And when he said "Stop", oh well, I had just hit 
Redo. So here we have it - no longer.

;-)

-- Hannes
