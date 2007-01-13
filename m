From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Sat, 13 Jan 2007 10:33:22 +0100
Message-ID: <20070113093322.GA4825@xp.machine.xx>
References: <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com> <7virfct737.fsf@assigned-by-dhcp.cox.net> <slrneqfnb8.a6s.Peter.B.Baumann@xp.machine.xx> <7vejq0t4ij.fsf@assigned-by-dhcp.cox.net> <20070112210403.GB6262@xp.machine.xx> <7v7ivrpx9y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 10:32:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5fFl-0005Pv-BD
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 10:32:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbXAMJcd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 04:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbXAMJcd
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 04:32:33 -0500
Received: from matlock.hofmann.stw.uni-erlangen.de ([131.188.24.35]:43109 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751254AbXAMJcc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jan 2007 04:32:32 -0500
Received: (qmail 6643 invoked by uid 0); 13 Jan 2007 09:32:28 -0000
Received: from p54aaa36b.dip0.t-ipconnect.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@84.170.163.107)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 13 Jan 2007 09:32:28 -0000
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v7ivrpx9y.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36742>

On Fri, Jan 12, 2007 at 04:48:09PM -0800, Junio C Hamano wrote:
> Peter Baumann <waste.manager@gmx.de> writes:
> 
> > Yes. I fully second Linus opinion. But I think there should be
> > a difference in adding completly new content to the index
> > (number of entries in the index grows) or replacing content in
> > the index.
> 
> Huh?
> 
> > ? So take five minutes to really think about that. Take an hour. Take a 
> > ? week. Ponder it.
> 
> I'd second this ;-).
> 
> > ? What does it mean to "add" something to a project? It has _nothing_ to do 
> > ? with "filenames". Yeah, the filename obviously exists, but it's not 
> > ? something that exists on its own. You add the ONLY thing that git tracks. 
> > ? 
> > ? You add CONTENT.
> > ? 
> > ? When you do "git add file.c" you aren't adding a filename to the list of 
> > ? files that git knows about. Not even CLOSE. No. You are really adding 
> > ? _content_ to the project you are tracking.
> 
> Read this again, please.  Ponder it if you may.
> 

Yes. I am adding content. And not a file. But at least to me, it makes a
*BIG* difference if I'm adding totally new content (reserving one more
bucket where to place to content) or just replacing the content *in* one
of those already reserved buckets. And that has nothing to do with
files (or at least the silly me can't grok it).

> > ? So even without an index, "git add" should work the way it works, once you 
> > ? can just let go of the broken model that is CVS.
> > ? 
> > ? Please. Join me, Luke. The power of the git side is stronger. I am your 
> > ? father. 
> > ? 
> > ?			Linus
> 
> And probably I am your uncle ;-).
> 

You are welcome :-)

-Peter
