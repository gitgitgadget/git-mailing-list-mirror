From: Nicolas Vilz <niv@iaglans.de>
Subject: Re: Track /etc directory using Git
Date: Fri, 14 Sep 2007 23:26:43 +0200
Message-ID: <20070914212643.GA10970@amy.inscure.wireless.home.vilz.de>
References: <38b2ab8a0709130511q7a506c5cvb0f8785a1d7ed7ad@mail.gmail.com> <20070913123137.GA31735@piper.oerlikon.madduck.net> <38b2ab8a0709140108v2a9c3569i93b39f351f1d4ec3@mail.gmail.com> <20070914091545.GA26432@piper.oerlikon.madduck.net> <e47324780709141031t79981b04q3a91984668ea723e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	Francis Moreau <francis.moro@gmail.com>
To: "Thomas Harning Jr." <harningt@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 23:27:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWIgz-0002Bo-1b
	for gcvg-git-2@gmane.org; Fri, 14 Sep 2007 23:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757075AbXINV1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 17:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757100AbXINV1H
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 17:27:07 -0400
Received: from geht-ab-wie-schnitzel.de ([217.20.118.28]:55104 "EHLO
	pandorra.geht-ab-wie-schnitzel.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757045AbXINV1G (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Sep 2007 17:27:06 -0400
Received: from localhost (point-14.secure.wireless.home.vilz.de [::ffff:192.168.151.14])
  by pandorra.geht-ab-wie-schnitzel.de with esmtp; Fri, 14 Sep 2007 23:27:02 +0200
  id 0015AF06.46EAFCA6.00000B73
Content-Disposition: inline
In-Reply-To: <e47324780709141031t79981b04q3a91984668ea723e@mail.gmail.com>
X-message-flag: Please send plain text messages only. Thank you.
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58185>

On Fri, Sep 14, 2007 at 01:31:06PM -0400, Thomas Harning Jr. wrote:
> On 9/14/07, martin f krafft <madduck@madduck.net> wrote:
> > also sprach Francis Moreau <francis.moro@gmail.com> [2007.09.14.1008 +0200]:
> > > Did you find an alternative to git in this case ?
> >
> > No, and I did not look anywhere, but I know of no other VCS that can
> > adequatly track permissions.
> Has anyone checked out metastore?  http://repo.or.cz/w/metastore.git
> ... there's an XML error in there somewhere, so its not loading the
> 'main' page, but http://repo.or.cz/w/metastore.git?a=shortlog should
> work.
> 
> It looks like it could work.... any thoughts on this?

I use that tool. If you just have one branch, it works. With the
commit-hook, which also updates the metadata, you have current
permission tracking. 

There is a lack of a checkout-hook, which sets the permissions, so you
have to remeber todo a metastore -a after you checked out a revision.

But if you have several branches which fork the master branch and try to
rebase the branches on master, you get trouble, because the metadata gets
corrupted somehow. I will think about a solution on this sometime.

Nicolas
