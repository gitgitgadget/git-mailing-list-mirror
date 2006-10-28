X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Sat, 28 Oct 2006 13:38:39 +0200
Message-ID: <200610281338.40111.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <Pine.LNX.4.64.0610211353070.3962@g5.osdl.org> <20061027045137.GB3179@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 28 Oct 2006 11:38:05 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Erik B?gfors <zindar@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	bazaar-ng@lists.canonical.com, Sean <seanlkml@sympatico.ca>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Ka+ruK+Pc07CUxdHdoBXodQ3gYHfAdvNajxFYBxQTSeKjDPtfsiClvm86nQt5DXR4u8c6PMxzgF5dWrhAarDOSnz+eTx1kZx6qawCoTqWfHJDDt5CIlaacpPLtZDltMxpLJcIro42oMxzCcGL+ldgfa4cIwUIdjeQuOj2DUpzEg=
User-Agent: KMail/1.9.3
In-Reply-To: <20061027045137.GB3179@artax.karlin.mff.cuni.cz>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30373>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdmVj-0006FH-Fj for gcvg-git@gmane.org; Sat, 28 Oct
 2006 13:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752140AbWJ1Lh4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 07:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752150AbWJ1Lh4
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 07:37:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:49349 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1752140AbWJ1Lhz
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 07:37:55 -0400
Received: by ug-out-1314.google.com with SMTP id 32so864956ugm for
 <git@vger.kernel.org>; Sat, 28 Oct 2006 04:37:54 -0700 (PDT)
Received: by 10.66.221.19 with SMTP id t19mr1098042ugg; Sat, 28 Oct 2006
 04:37:54 -0700 (PDT)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id e34sm605076ugd.2006.10.28.04.37.53; Sat, 28 Oct
 2006 04:37:53 -0700 (PDT)
To: Jan Hudec <bulb@ucw.cz>
Sender: git-owner@vger.kernel.org

Jan Hudec wrote:
> Actually bzr used to have slightly different numbering scheme not long
> ago. There was a revision-history in each branch listing the revisions
> in order in which they were commited or merged in. Some time ago it was
> changed to numbering along the leftmost parent, which was, IIRC, deemed
> simpler and a little more logical. But in the light of these arguments,
> maybe the former system was better -- it was more dependent on the
> actual location, but on the other hand it allowed (or could allow --
> IIRC there was some problem with it) to fast-forward merge while
> _locally_ keeping the meaning of old revision numbers. In fact, the
> revision-history used to be almost exactly the same as git reflog,
> except it only stored the revids, not the times.

Which is very fine if you don't modify the history (amending commits,
rewinding history to earlier point, rebasing the branch, merging branch
in and starting it anew aka. dovetail approach if I remember correctly),
and if you are not concerned with performance when fetching larger
number of commits into branch (as you have to assign number to them).

Which was perhaps why bzr changed from revnolog to leftmost/first parent
as a way to keep branch-as-path/assing revision numbers to revisions.
Which has it's own disadvantages as enumerated multiple times here
on the list.
-- 
Jakub Narebski
