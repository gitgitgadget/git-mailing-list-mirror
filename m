X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: multi-project repos (was Re: Cleaning up git user-interface warts)
Date: Fri, 17 Nov 2006 02:52:38 +0100
Message-ID: <20061117015238.GD7201@pasky.or.cz>
References: <Pine.LNX.4.64.0611160814560.3349@woody.osdl.org> <455C94FA.3050903@xs4all.nl> <Pine.LNX.4.64.0611160904010.3349@woody.osdl.org> <455CA2A8.5010700@xs4all.nl> <Pine.LNX.4.64.0611160958170.3349@woody.osdl.org> <Pine.LNX.4.63.0611162315110.13772@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0611161436230.3349@woody.osdl.org> <Pine.LNX.4.63.0611170013590.13772@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0611161642320.3349@woody.osdl.org> <Pine.LNX.4.63.0611170216190.13772@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 01:55:20 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Han-Wen Nienhuys <hanwen@xs4all.nl>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0611170216190.13772@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31660>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GksuJ-0005wm-Bh for gcvg-git@gmane.org; Fri, 17 Nov
 2006 02:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424902AbWKQBwk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 20:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424906AbWKQBwk
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 20:52:40 -0500
Received: from w241.dkm.cz ([62.24.88.241]:32902 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1424902AbWKQBwk (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 20:52:40 -0500
Received: (qmail 8811 invoked by uid 2001); 17 Nov 2006 02:52:38 +0100
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On Fri, Nov 17, 2006 at 02:22:35AM CET, Johannes Schindelin wrote:
> On Thu, 16 Nov 2006, Linus Torvalds wrote:
> > For example, if you used one of the old-fashioned commit walkers, maybe we 
> > got the initial commit, but we may not have gotten the whole _chain_. See?
> 
> Huh? I am quite certain that FETCH_HEAD is not updated in that case. If it 
> is, that's a bug.

It may be updated and then things may break _afterwards_. git-prune will
happily blow anything referenced by FETCH_HEAD, it's not considered by
the fsck-objects reachability analysis.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
