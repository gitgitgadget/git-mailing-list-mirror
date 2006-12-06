X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: using xdl_merge(), was Re: Resolving conflicts
Date: Wed, 6 Dec 2006 11:02:10 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612061058360.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <456FD461.4080002@saville.com> <Pine.LNX.4.64.0611302330000.3695@woody.osdl.org>
 <456FDF24.1070001@saville.com> <Pine.LNX.4.64.0612012018490.3476@woody.osdl.org>
 <7vejri20mf.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612021131140.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <4575B32F.5060108@ramsay1.demon.co.uk> <Pine.LNX.4.64.0612051023460.3542@woody.osdl.org>
 <Pine.LNX.4.63.0612051949290.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vac22glzz.fsf@assigned-by-dhcp.cox.net> <7vwt5573sy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 6 Dec 2006 10:02:27 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vwt5573sy.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33417>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrtbX-00087E-BY for gcvg-git@gmane.org; Wed, 06 Dec
 2006 11:02:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760413AbWLFKCO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 05:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760417AbWLFKCO
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 05:02:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:33459 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1760418AbWLFKCM
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 05:02:12 -0500
Received: (qmail invoked by alias); 06 Dec 2006 10:02:11 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp016) with SMTP; 06 Dec 2006 11:02:11 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 6 Dec 2006, Junio C Hamano wrote:

> Junio C Hamano <junkio@cox.net> writes:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> >> On Tue, 5 Dec 2006, Linus Torvalds wrote:
> >>
> >>>  - take every single merge in git (or the kernel, if you want even more)
> >
> > The attached is the script I am using.  The test checks the
> > output from 'master' (merge from RCS) and 'next' (with xdl-merge)
> > and also tries to see how different the conflicts look like.
> >
> > In the git.git archive, there is no "clean" merge on which
> > 'master' and 'next' did not agree.  It is not a proof of
> > correctness at all but it gives a sense of assurance.
> 
> And all merges in linux-2.6.git archive either result in
> conflict with both 'merge' implementations, or cleanly resolves
> the same way with both 'merge' implementations.  I have not
> compared the conflicted cases yet, but at least it gives me a
> warm fuzzy feeling to see that autocommitted stuff are sensible.

Thank you! Slowly I also get a warm fuzzy feeling...

My idea, to have an inbuilt work-alike to RCS merge, was not only 
instigated by my liking the zealous option, but also to be able to add 
relatively fast tests.

Originally, I thought that building in git-merge-one-file, and enhancing 
it to recognize by the parameters if it should act as a merge replacement, 
would be the way to go. Should I do this, or rather add 
builtin-merge-file?

Ciao,
Dscho
