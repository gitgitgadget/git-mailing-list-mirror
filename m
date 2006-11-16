X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 18:03:21 -0800
Message-ID: <7vhcx0gnbq.fsf@assigned-by-dhcp.cox.net>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 02:03:34 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <455BBCE9.4050503@xs4all.nl> (Han-Wen Nienhuys's message of "Thu,
	16 Nov 2006 02:20:41 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31543>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkWb9-0006DE-Iv for gcvg-git@gmane.org; Thu, 16 Nov
 2006 03:03:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162160AbWKPCDY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 21:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162165AbWKPCDX
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 21:03:23 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:3789 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S1162160AbWKPCDX
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 21:03:23 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061116020322.NUPG9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Wed, 15
 Nov 2006 21:03:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id nE3U1V00c1kojtg0000000; Wed, 15 Nov 2006
 21:03:29 -0500
To: hanwen@xs4all.nl
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys <hanwen@xs4all.nl> writes:

> FWIW, I regularly mess up with the differences between fetching,
> pulling and merging.  In particular, having to do a two step process
> to get remote changes in,
>
>   git pull url-to-server master:master
>      ..error message about not being a fast-forward..
>
>   git pull --update-head-ok url-to-server master:master
>      ..still an error message about update not being a fast-forward..
>
>       (sigh)

Sigh indeed.

Why don't you do the simple and obvious

	git pull url master

or "git pull url" if you already know the master is the branch
you are interested in.

The more advanced form of using tracking branches are there and
documentation talks about them for completeness but that does
not mean you have to use it.
