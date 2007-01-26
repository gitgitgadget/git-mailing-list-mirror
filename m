From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: git fetch over ssh trouble
Date: Fri, 26 Jan 2007 09:23:56 -0500
Message-ID: <20070126142356.GA1947@fieldses.org>
References: <20070126050842.GA18058@fieldses.org> <7vmz462wdh.fsf@assigned-by-dhcp.cox.net> <20070126053400.GB18058@fieldses.org> <7vejpi2u91.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 26 15:24:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HARzt-0002w2-Mv
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 15:24:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbXAZOX6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 09:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbXAZOX6
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 09:23:58 -0500
Received: from mail.fieldses.org ([66.93.2.214]:44079 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030251AbXAZOX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 09:23:57 -0500
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HARzg-0000aA-Av; Fri, 26 Jan 2007 09:23:56 -0500
Content-Disposition: inline
In-Reply-To: <7vejpi2u91.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 25, 2007 at 10:10:34PM -0800, Junio C Hamano wrote:
> "J. Bruce Fields" <bfields@fieldses.org> writes:
> 
> >> I wonder what should happen when you do not have anything
> >> defined for "linus-nfs" shorthand.
> >
> > Oops; I didn't notice that!
> >
> >> Should it fetch HEAD?
> >
> > In my case I'd want it to either default to what I actually wanted
> > (+refs/heads/*:refs/remotes/linux-nfs/*), or just fail with something
> > helpful:
> >
> > 	"Nothing to fetch"?
> > 	"No refspec given, and no default fetch configured for linux-nfs"?
> > 	"What do you want me to fetch?"?
> >
> > I don't know.
> 
> Saying "let's grab everything" is certainly tempting, but I
> think it is a bit too much.

Yeah.

> How about doing this instead, then?

Works for me, thanks!

bfields@pickle:git$ git fetch linux-nfs
Password:
Nothing specified for fetching with remote.linux-nfs.fetch
Password:

Oh, OK, the password requests are a little excessive.  I should go
generate an ssh key.

--b.
