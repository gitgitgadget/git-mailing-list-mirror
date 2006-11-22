X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: StGit metadata grabbing with git clone
Date: Thu, 23 Nov 2006 00:56:14 +0100
Organization: Dewire
Message-ID: <200611230056.15795.robin.rosenberg.lists@dewire.com>
References: <87ac2jwutu.fsf@neumann.lab.ossystems.com.br> <200611222129.24369.robin.rosenberg.lists@dewire.com> <20061122213800.GM7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 22 Nov 2006 23:54:42 +0000 (UTC)
Cc: Otavio Salvador <otavio@debian.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
In-Reply-To: <20061122213800.GM7201@pasky.or.cz>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32111>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gn1v9-0001hT-Ai for gcvg-git@gmane.org; Thu, 23 Nov
 2006 00:54:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757192AbWKVXyY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 18:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757193AbWKVXyY
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 18:54:24 -0500
Received: from [83.140.172.130] ([83.140.172.130]:11882 "EHLO
 torino.dewire.com") by vger.kernel.org with ESMTP id S1757192AbWKVXyX (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 18:54:23 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id 9F348800784; Thu, 23 Nov 2006 00:50:44 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 11952-02; Thu, 23 Nov
 2006 00:50:44 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2]) by torino.dewire.com (Postfix)
 with ESMTP id 3C0228003E1; Thu, 23 Nov 2006 00:50:42 +0100 (CET)
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

onsdag 22 november 2006 22:38 skrev Petr Baudis:
> On Wed, Nov 22, 2006 at 09:29:24PM CET, Robin Rosenberg wrote:
> > onsdag 22 november 2006 13:05 skrev Otavio Salvador:
> > > Hello,
> > >
> > > I'm a happy user of stgit together with git to maintain a patch queue
> > > while I or the company team is working on patches that will be send
> > > for merging. Both works great but we're having troubles when we try to
> > > clone a stgit repository.
> > >
> > > When I clone the repository it grab the source but it loses the
> > > metadata. I would like to grab those too. Does anybody has a solution
> > > or a trick how I can do that?
> >
> > You can copy the repo using rsync or scp instead of git-clone or use stg
> > uncommit after the regular clone.
>
> How do you sync them then?

1) Don't. You're supposed to share stgit patches via email.

2) Want to mess try anyway?

At first I was thinking NO!,  but then again, it might be "interesting" to try 
it. 

You can publish the state of a branch using git push. This will look like the 
pu branch in the official Git repo, i.e. a branch whose list of commits get 
changed completely, rather than being appended to. This could be considered 
sane, ie. you publish the current state of your work.

You can also pull from a stgitted branch. Still sane, if you wan't to look at 
somebody else's work.

I mentioned uncommit. I'm not sure that was a wise suggestion. If you wan't to 
push and pull changes. don't uncommit incomming changes and don't pretend to 
work on the same patch and you'll probably be just fine. .....  

