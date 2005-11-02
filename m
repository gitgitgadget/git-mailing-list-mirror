From: Chris Mason <mason@suse.com>
Subject: Re: hgmq vs. StGIT
Date: Wed, 2 Nov 2005 10:41:08 -0500
Message-ID: <20051102154108.GM26847@watt.suse.com>
References: <7vk6ftcp0d.fsf@assigned-by-dhcp.cox.net> <20051031224246.GP11488@ca-server1.us.oracle.com> <20051101002554.GA7634@thunk.org> <20051101090804.GA11618@pasky.or.cz> <b0943d9e0511010123i1f9eb679w@mail.gmail.com> <436787BD.9080705@citi.umich.edu> <20051101153650.GB26847@watt.suse.com> <b0943d9e0511010918ob2dbcfcv@mail.gmail.com> <20051101181352.GD26847@watt.suse.com> <b0943d9e0511011330v7045c568u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chuck Lever <cel@citi.umich.edu>, Petr Baudis <pasky@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Joel Becker <Joel.Becker@oracle.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 16:44:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXKjo-00060p-JM
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 16:41:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965091AbVKBPlR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 10:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965092AbVKBPlR
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 10:41:17 -0500
Received: from cantor.suse.de ([195.135.220.2]:3992 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965091AbVKBPlR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 10:41:17 -0500
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id E7888E304;
	Wed,  2 Nov 2005 16:41:11 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <b0943d9e0511011330v7045c568u@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11025>

On Tue, Nov 01, 2005 at 09:30:06PM +0000, Catalin Marinas wrote:
> On 01/11/05, Chris Mason <mason@suse.com> wrote:
> > I would suggest just putting the .git/patches directory under revision
> > control.
> 
> Putting them under a separate revisions repository, i.e. having a
> .git/patches/,git directory? Otherwise there would be some problems
> with the modified files automatically included in a patch.
> 
> > More importantly, you can reuse gitk and all of the other history
> > functionality in the SCM.
> 
> Doing it the above way wouldn't be of much help with gitk. You would
> get files like .git/patches/master/patchX/top etc. under revision
> control which only contain some hash strings, not meaningful. With GIT
> you have the advantage of being able to specify the DAG structure. It
> is pretty simple to just link the commit objects corresponding to a
> patch into a DAG and using gitk would allow you to navigate through
> the history and also look at the diff itself.

I think we're talking past each other a little, partially because
I'm not sure exactly what features you want from revision control on the
patches.

But, my suggestion is to remember that once you add some sort of
revision control, people are going to want all of the features they are
used to with git/hg/their favorite SCM.  You'll probably get better
results if you patch git to your needs then if you try to reimplement
things all over again. 

-chris
