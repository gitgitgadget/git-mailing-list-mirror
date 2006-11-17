X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 16:13:44 -0800
Message-ID: <7vmz6r2amf.fsf@assigned-by-dhcp.cox.net>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
	<87hcx1u934.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611141518590.2591@xanadu.home>
	<87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
	<Pine.LNX.4.64.0611141633430.2591@xanadu.home>
	<7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142007010.2591@xanadu.home>
	<7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142306090.2591@xanadu.home>
	<Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
	<455BBCE9.4050503@xs4all.nl>
	<Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
	<Pine.LNX.4.63.0611162353250.13772@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0611161508530.3349@woody.osdl.org>
	<455CFCBD.8040901@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 00:13:58 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <455CFCBD.8040901@xs4all.nl> (Han-Wen Nienhuys's message of "Fri,
	17 Nov 2006 01:05:17 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31642>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkrMe-0006hP-8n for gcvg-git@gmane.org; Fri, 17 Nov
 2006 01:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424797AbWKQANr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 19:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424798AbWKQANr
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 19:13:47 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:2179 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S1424797AbWKQANq
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 19:13:46 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061117001345.MJNY5575.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>; Thu, 16
 Nov 2006 19:13:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id ncDr1V00a1kojtg0000000; Thu, 16 Nov 2006
 19:13:52 -0500
To: hanwen@xs4all.nl
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys <hanwen@xs4all.nl> writes:

>  - clone but not a put-clone,

What's put-clone?  Care to explain?

>  - pull = merge + fetch, but no command for merge + throw

What's merge+throw?  Care to explain?

>  - clone for getting all branches of a repo, but no command for
>    updating all branches of a repo.  

This one I can understand, but how would you propose to "update
all branches", in other words what's your design for mapping
remote branch names to local branch namespaces?

It would be nice if the design does not straightjacket different
repository layouts different people seem to like, but I think it
would be Ok to limit ourselves only to support the straight
one-to-one mapping and support only separate-remote layout.
