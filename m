X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: Cleaning up git user-interface warts
Date: Sat, 18 Nov 2006 11:09:14 +0000
Message-ID: <200611181109.14675.alan@chandlerfamily.org.uk>
References: <87k61yt1x2.wl%cworth@cworth.org> <200611150917.23756.andyparkins@gmail.com> <Pine.LNX.4.64.0611151023160.2591@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 18 Nov 2006 11:09:29 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0611151023160.2591@xanadu.home>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31767>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlO4b-0002uq-GV for gcvg-git@gmane.org; Sat, 18 Nov
 2006 12:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756291AbWKRLJU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 06:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756290AbWKRLJU
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 06:09:20 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk
 ([82.44.22.127]:41669 "EHLO home.chandlerfamily.org.uk") by vger.kernel.org
 with ESMTP id S1756120AbWKRLJT (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18
 Nov 2006 06:09:19 -0500
Received: from kanger.home ([192.168.0.21]) by home.chandlerfamily.org.uk
 with esmtp (Exim 4.63) (envelope-from <alan@chandlerfamily.org.uk>) id
 1GlO4U-00067f-5V for git@vger.kernel.org; Sat, 18 Nov 2006 11:09:18 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wednesday 15 November 2006 15:41, Nicolas Pitre wrote:
> On Wed, 15 Nov 2006, Andy Parkins wrote:
> >  * Don't use the name "origin" twice.  In fact, don't use it at all.  In
> > a distributed system there is no such thing as a true origin.
>
> I agree, sort of.  Not because"origin" is ambigous as a name.  But
> rather because there is a magic translation from "master" to "origin",
> and I think this is wrong to do that.
>
> As mentioned elsewhere (and let's start using "get" instead of "pull" as
> suggested by Johannes), a "get" should probably always create a branch
> group even if it contains only one branch.  This way the remote branch
> called "master" will still be called "master" locally, under the branch
> group used to represent the remote repository.  And if a local name is
> not provided then let's just call it "default".  This way, amongst the
> remote references, there would be a "default/master" that would be used
> when nothing else is provided by the user. So...
>
> 	git get repo.com/time_machine.git
>
> would create a local branch named "remotes/default/master" if the remote
> repo has only a master branch.

Why not call it remotes/repo.com/time_machine.git/master and have a 
DEFAULT_ORIGIN that is a symref to it in the same way as HEAD is a symref to 
a local branch

-- 
Alan Chandler
