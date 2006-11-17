X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: Cleaning up git user-interface warts
Date: Fri, 17 Nov 2006 01:05:17 +0100
Message-ID: <455CFCBD.8040901@xs4all.nl>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org> <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home> <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org> <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org> <455BBCE9.4050503@xs4all.nl> <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org> <Pine.LNX.4.63.0611162353250.13772@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0611161508530.3349@woody.osdl.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 17 Nov 2006 00:06:00 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 30
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <Pine.LNX.4.64.0611161508530.3349@woody.osdl.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31640>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkrEy-0005Vq-K7 for gcvg-git@gmane.org; Fri, 17 Nov
 2006 01:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424614AbWKQAFi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 19:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424617AbWKQAFi
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 19:05:38 -0500
Received: from main.gmane.org ([80.91.229.2]:4268 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1424614AbWKQAFg (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 19:05:36 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GkrET-0005SY-VF for git@vger.kernel.org; Fri, 17 Nov 2006 01:05:25 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Fri, 17 Nov 2006 01:05:25 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 17 Nov 2006 01:05:25
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org



Linus Torvalds escreveu:
> My real point was/is that usually it's really not the "naming details" 
> that people _really_ have problems with. The real problems tend to be in 
> learning a new workflow.

I agree that discussions on naming may cloud the issue, but "learning
the workflow" implies that people should adapt to the limitations of
their tools.  That's only a viable stance when the tools are finished
and completely perfect.

Until that time, it would be good goal to remove all idiosyncrasies,
all gratuitious asymetries and needless limitations in the commands of
git, eg.

 - clone but not a put-clone,

 - pull = merge + fetch, but no command for merge + throw

 - clone for getting all branches of a repo, but no command for
   updating all branches of a repo.  

Of course, when all warts are fixed, backward compatibility will force
us to choose some new names. At that point, a discussion on naming is
in place.


-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
