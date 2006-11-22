X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: Struggling with tangled
Date: Wed, 22 Nov 2006 19:15:58 +0000
Message-ID: <200611221915.59073.alan@chandlerfamily.org.uk>
References: <E1GmpTj-000235-2n@home.chandlerfamily.org.uk> <ek1aj0$u09$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 22 Nov 2006 19:16:59 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <ek1aj0$u09$1@sea.gmane.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32094>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmxZs-0003YY-9a for gcvg-git@gmane.org; Wed, 22 Nov
 2006 20:16:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756692AbWKVTQE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 14:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756694AbWKVTQE
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 14:16:04 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk
 ([82.44.22.127]:32923 "EHLO home.chandlerfamily.org.uk") by vger.kernel.org
 with ESMTP id S1756692AbWKVTQB (ORCPT <rfc822;git@vger.kernel.org>); Wed, 22
 Nov 2006 14:16:01 -0500
Received: from kanger.home ([192.168.0.21]) by home.chandlerfamily.org.uk
 with esmtp (Exim 4.63) (envelope-from <alan@chandlerfamily.org.uk>) id
 1GmxZf-0003Fm-II for git@vger.kernel.org; Wed, 22 Nov 2006 19:15:59 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wednesday 22 November 2006 11:01, Jakub Narebski wrote:
> Alan Chandler wrote:
...
> > 2) Some files get completely munged with conflict resolution markers
> > every few lines.  Is there a simple way to say "don't use this file, but
> > use the [stage2/stage3] sources of the merge". (ie one of the original
> > inputs to the merge - and if so, which one is which)
>
> "git cat-file -p :<stage>: <filename> > <filename>", where stage = 1 means
> version from the ancestor, stage = 2 means version from the HEAD (from the
> base), and stage = 3 means version from the remote/other branch (from the
> branch being rebased).

Just a comment for the list.  There have been lots of documentation ideas 
floating around recently.  One thing that could be done is to cross reference 
the key sections in the man pages somewhat.  I read the man page for 
git-cat-file, and that just says the non flag parameter is <object> and its 
an SHA1.

Once I saw this, I was puzzled and eventually found a reference to in in 
git-rev-parse.


>
> > 3) I sometime hit a merge conflict in a file which I know will actually
> > be deleted at the tip of the topic I am rebasing.  Is there a way at this
> > point to just tell the conflict resolution to say make this file go away.
>
> "git rm <filename>" plus "git update-index <filename>" doesn't work?

Well I _thought_ I tried git-update-index --remove and that hadn't worked.

>
> > 4) I repeat the question I asked in a thread above.  What is the --merge
> > switch on git-rebase actually do.  The man page starts talking about
> > merge strategies, but there already is a -s switch for that.
>
> "git rebase" uses "git format-patch" + "git-am --3way" machinery by
> default. The --merge option makes it use merge machinery instead (similar
> to the way "git checkout -m" uses merge strategy IIRC).

Yes but ...

... what does that mean in usage terms?

Why would I want to use one rather than the other?



-- 
Alan Chandler
