X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: Patch to tutorial.txt
Date: Mon, 20 Nov 2006 20:11:22 +0000
Message-ID: <200611202011.22787.alan@chandlerfamily.org.uk>
References: <4d8e3fd30611191444r710f23e5uc488d35aa4abaf06@mail.gmail.com> <4d8e3fd30611200030p1d117445qd3f7d619c18a0633@mail.gmail.com> <200611200949.32722.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Mon, 20 Nov 2006 20:13:02 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <200611200949.32722.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31935>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmFVb-0006M9-Sw for gcvg-git@gmane.org; Mon, 20 Nov
 2006 21:12:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966643AbWKTUL0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 15:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966641AbWKTUL0
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 15:11:26 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk
 ([82.44.22.127]:56802 "EHLO home.chandlerfamily.org.uk") by vger.kernel.org
 with ESMTP id S966640AbWKTULY convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 15:11:24 -0500
Received: from kanger.home ([192.168.0.21]) by home.chandlerfamily.org.uk
 with esmtp (Exim 4.63) (envelope-from <alan@chandlerfamily.org.uk>) id
 1GmFUB-0004kM-7l for git@vger.kernel.org; Mon, 20 Nov 2006 20:11:23 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Monday 20 November 2006 08:49, Jakub Narebski wrote:
> On Mon, 20 Nov 2006, Paolo Ciarrocchi wrote:
> >>> -made in each.  To merge the changes made in the two branches, run
> >>> +made in each.  To merge the changes made in experimental into master

> >> I would rather say:
> >>   To merge the changes made in the two branches into master, run
> >
> > Why Jakub? There are only two branches, master and experimental.
> > While sitting in master and doing git pull . experimental I would
> > expect to merge I did in experimental into master. Changes did in
> > master are alreay merged in master. Am I wrong?
>
> For me, "merge" in "to merge the changes" phrase is merge in common-sense
> meaning of the world, not the SCM jargon. Merge the changes == join the
> changes, so you have to give both sides, both changes you join.
>
> Merge the changes == take changes in branch 'experimental' since forking,
> take changes in branch 'master' since forking, join those changes
> together (merge), and put the result of this joining (this merge) into
> branch 'master'.
>
> On the contrary, in "merge branch 'experimenta' into 'master'" phrase
> "merge" is in the SCM meaning of this word.
>
>
> Just my 2 eurocoents of not native English speaker...

As a native English speaker the way the tutorial was before any of these 
changes meant that the contents of experimental and master had merged into 
one, but there was not specific indication of where this merged result had 
been put 

From _your_ phrasing I took the meaning that there were two independent 
branches which then got merged into master although that leaves me puzzled 
because there is only one other independant branch and thats the experimental 
one 

I think the wording Paolo used is clearer and precisely right - we are merging 
the experimental stuff into master and experimental remains as it was 
(although in a fast forward experimental and master end up the same - this is 
not true in the example in the tutorial which says that changes are made on 
both branches).



-- 
Alan Chandler
