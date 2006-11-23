X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Some tips for doing a CVS importer
Date: Thu, 23 Nov 2006 20:45:06 +0100
Organization: Dewire
Message-ID: <200611232045.06974.robin.rosenberg.lists@dewire.com>
References: <9e4733910611201349s4d08b984g772c64982f148bfa@mail.gmail.com> <456359E2.8010403@cc.jyu.fi> <20061121200508.GB22461@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 23 Nov 2006 19:44:08 +0000 (UTC)
Cc: lamikr <lamikr@cc.jyu.fi>, Jon Smirl <jonsmirl@gmail.com>,
	Carl Worth <cworth@cworth.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
In-Reply-To: <20061121200508.GB22461@spearce.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32155>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnKTt-0004ZU-2V for gcvg-git@gmane.org; Thu, 23 Nov
 2006 20:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933572AbWKWTnT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 14:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933590AbWKWTnT
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 14:43:19 -0500
Received: from [83.140.172.130] ([83.140.172.130]:42265 "EHLO
 torino.dewire.com") by vger.kernel.org with ESMTP id S933572AbWKWTnQ (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 14:43:16 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id ADCD1802810; Thu, 23 Nov 2006 20:39:33 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 21277-08; Thu, 23 Nov
 2006 20:39:33 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3]) by torino.dewire.com (Postfix)
 with ESMTP id 2365D800784; Thu, 23 Nov 2006 20:39:31 +0100 (CET)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

tisdag 21 november 2006 21:05 skrev Shawn Pearce:
> lamikr <lamikr@cc.jyu.fi> wrote:
> > Shawn Pearce wrote:
> > >   - No GUI.
> >
> > QGIT allows using some commands. I plan to try out the GIT eclipse
> > plugin in near future myself.
> > This mail list have some discussion and download link to it's repo in
> > archives.
> > (title: Java GIT/Eclipse GIT version 0.1.1, )
>
> I'm the author of that plugin.  :-)
>
> Its not even capable of making a commit yet.  The underling plumbing
> (aka jgit) can make commits but the Eclipse GUI has no function to
> actually invoke that plumbing and make a commit to the repository.
>
> The Eclipse plugin has apparently been a low priority for me.
> I haven't worked on it very recently.  Robin Rosenburg has supposedly
> gotten the revision compare interface to work, but its slow as a
> duck in November due to jgit's pack reading code not running as
> fast as it should.

Slow it is. It is somewhat usable though, especially the quickdiff. I worked 
the whole day with help from quickdiff today. The diff is computed against 
HEAD^ (i.e. I get to see the changes that my topmost StGit patch introduces).

The project contains 20000+ files and six years of history.  Reading the whole 
history is out of the question with the current performance so I restrict 
reading to 500 entries which is just about bearable. That's enough for 
practical use with quickdiff and compare though. Improving jgit's speed 50 
times will probably be enough to make jgit shine. 

Activating the Git connection seems to be a problem with the egit projects, 
i.e. it works sometimes, but not with my much bigger repo. The only problem 
is that the first time is dog slow. The structure is different though, as my 
repo has .project at the top, not one level down.

