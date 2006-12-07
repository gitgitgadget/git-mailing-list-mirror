X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Olivier Galibert <galibert@pobox.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Fri, 8 Dec 2006 00:50:39 +0100
Message-ID: <20061207235039.GA423@dspnet.fr.eu.org>
References: <Pine.LNX.4.64.0612061847190.3615@woody.osdl.org> <45778AA3.7080709@zytor.com> <Pine.LNX.4.64.0612061940170.3615@woody.osdl.org> <4577A84C.3010601@zytor.com> <Pine.LNX.4.64.0612070953290.3615@woody.osdl.org> <45785697.1060001@zytor.com> <Pine.LNX.4.64.0612071052560.3615@woody.osdl.org> <457868AA.2030605@zytor.com> <20061207193012.GA84678@dspnet.fr.eu.org> <4578722E.9030402@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 23:50:52 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Kernel Org Admin <ftpadmin@kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <4578722E.9030402@zytor.com>
User-Agent: Mutt/1.4.2.2i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33649>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsT0o-0002lz-Jg for gcvg-git@gmane.org; Fri, 08 Dec
 2006 00:50:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1164007AbWLGXuo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 18:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164016AbWLGXun
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 18:50:43 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:2234 "EHLO
 dspnet.fr.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1164007AbWLGXun (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 18:50:43 -0500
Received: by dspnet.fr.eu.org (Postfix, from userid 1007) id BAF80A4AD2; Fri,
  8 Dec 2006 00:50:39 +0100 (CET)
To: "H. Peter Anvin" <hpa@zytor.com>
Sender: git-owner@vger.kernel.org

On Thu, Dec 07, 2006 at 11:57:34AM -0800, H. Peter Anvin wrote:
> Olivier Galibert wrote:
> >On Thu, Dec 07, 2006 at 11:16:58AM -0800, H. Peter Anvin wrote:
> >>Unfortunately, the most common queries are also extremely expensive.
> >
> >Do you have a top-ten of queries ?  That would be the ones to optimize
> >for.
> 
> The front page, summary page of each project, and the RSS feed for each 
> project.

Hmmm, maybe you could have the summaries and rss feed generated on
push, which could also generate elementary files with lines of the
front page.  That would make these top offenders static page serving.

  OG.
