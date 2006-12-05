X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Cleaning up git user-interface warts
Date: Tue, 5 Dec 2006 23:42:46 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612052340260.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
 <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home>
 <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
 <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
 <455BBCE9.4050503@xs4all.nl> <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
 <455C412D.1030408@xs4all.nl> <7v7ixvbq80.fsf@assigned-by-dhcp.cox.net>
 <455C618A.7080309@xs4all.nl> <ejkd6g$vog$1@sea.gmane.org> <4566E512.4010405@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 5 Dec 2006 22:42:57 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <4566E512.4010405@xs4all.nl>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33381>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grj00-0000mQ-4K for gcvg-git@gmane.org; Tue, 05 Dec
 2006 23:42:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936871AbWLEWmt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 17:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936870AbWLEWmt
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 17:42:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:49379 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S936871AbWLEWms
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 17:42:48 -0500
Received: (qmail invoked by alias); 05 Dec 2006 22:42:46 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp001) with SMTP; 05 Dec 2006 23:42:46 +0100
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org

Hi,

On Fri, 24 Nov 2006, Han-Wen Nienhuys wrote:

> The recently posted patch documenting is an improvement, but why not
> add an option so you can do
> 
>   --format 'committer %c\nauthor %a\n'
>   
> this catches all combinations, and is easier for scripting.

Yes, it would be easier for scripting, and it would probably be relatively 
easy, what with the addition of interpolate.[ch] to git. However, it is 
work, and I am lazy.

What information would you like, anyway? IOW can you provide me with a 
list like this:

%c	committer
%a	author
%d	committer_date
...

Ciao,
Dscho
