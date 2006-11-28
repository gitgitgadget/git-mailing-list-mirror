X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicholas Allen <nick.allen@onlinehome.de>
Subject: Re: git and bzr
Date: Tue, 28 Nov 2006 23:36:03 +0100
Message-ID: <456CB9D3.4060900@onlinehome.de>
References: <45357CC3.4040507@utoronto.ca>	 <845b6e870611280410j58bdcd99nc05d0f67489293e4@mail.gmail.com>	 <ekhaeg$etk$1@sea.gmane.org>	 <Pine.LNX.4.63.0611281433270.30004@wbgn013.biozentrum.uni-wuerzburg.de>	 <Pine.LNX.4.64.0611280754050.30076@woody.osdl.org>	 <456C7592.6020700@ableton.com> <ekhtnt$rkk$1@sea.gmane.org>	 <456C9DFF.1040407@onlinehome.de>	 <46a038f90611281340u521fb5fct745ebe1ded9a630e@mail.gmail.com>	 <456CADE9.7060503@onlinehome.de> <46a038f90611281414y165ed376r80e3dbc3c7888985@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 22:36:24 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>,
	"bazaar-ng@lists.canonical.com" <bazaar-ng@lists.canonical.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
In-Reply-To: <46a038f90611281414y165ed376r80e3dbc3c7888985@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:8f68dfdb39f9894a8a7411e7c5df1048
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32600>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpBYi-0002Gx-1j for gcvg-git@gmane.org; Tue, 28 Nov
 2006 23:36:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756821AbWK1WgJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 17:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757285AbWK1WgI
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 17:36:08 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:10464 "EHLO
 moutng.kundenserver.de") by vger.kernel.org with ESMTP id S1756821AbWK1WgG
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 17:36:06 -0500
Received: from [84.190.155.117] (helo=[192.168.1.100]) by
 mrelayeu.kundenserver.de (node=mrelayeu5) with ESMTP (Nemesis), id
 0ML25U-1GpBYa12NE-0003HP; Tue, 28 Nov 2006 23:36:04 +0100
To: Martin Langhoff <martin.langhoff@gmail.com>
Sender: git-owner@vger.kernel.org

Martin Langhoff wrote:
> On 11/29/06, Nicholas Allen <nick.allen@onlinehome.de> wrote:
>> yes I can see if you just use plain patches. In bzr though there are
>> bundles that store extra data along with the patch and if you use this
>> instead of a simple patch this will never be a problem as bzr can then
>> notice the same bundle being merged into 2 branches.
> 
> Well, there you start depending on everyone using bzr and providing
> metadata-added patches. Git is really good at dealing with scenarios
> where not everyone is using Git.. so the
> content-is-kind-and-metadata-be-damned pays off handsomely.
> 
> And the "scenarios where not everyone is using Git" are everytime that
> we are tracking a project that uses a different SCM. For me, the
> "killer-app" of git is that, as it does not rely on magic metadata, it
> is perfectly useful on projects that I track that use CVS or SVN.
> 
> I submit or commit patches upstream and git spots the commits being
> echoed back in just right because it does not rely on the metadata.
> Only on the content.
> 
> cheers,
> 
> 
> martin
> ps: hope you don't mind I re-added the CC to git@vger in my reply

Of course not - I also added bzr mailing list back on this discussion too...

I have to agree that's pretty cool!

For the kind of development we do this is not really a big deal though
as all developers can agree on using one RCS. But if you mix git and svn
in this way then the changes can only go one way (from svn to git) can't
they as svn is not so intelligent so this somewhat limits its usefulness
doesn't it?

I know bzr it has some beta level plugin support for SVN foreign
branches (git, mercurial and svk ones too I think) and I believe this
works in both directions. So you can commit to bzr, push that to an svn
repository and also pull changes from svn. Merge branches in bzr and
commit back to svn with log messages and history intact. So bzr still
allows the use of multiple RCS systems...

