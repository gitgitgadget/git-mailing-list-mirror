From: Johan Herland <johan@herland.net>
Subject: Re: Working copy revision and push pain
Date: Mon, 24 Mar 2008 19:00:38 +0100
Message-ID: <200803241900.38816.johan@herland.net>
References: <47E64F71.3020204@jwatt.org> <200803231720.44320.johan@herland.net>
 <alpine.LSU.1.00.0803241621210.4353@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Watt <jwatt@jwatt.org>,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 19:01:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdqzH-0005Ld-Dz
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 19:01:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755758AbYCXSAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 14:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757091AbYCXSAu
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 14:00:50 -0400
Received: from smtp.getmail.no ([84.208.20.33]:50490 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755758AbYCXSAt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 14:00:49 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JY80031YY1CIR00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 24 Mar 2008 19:00:48 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JY800IV0Y13U7D0@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 24 Mar 2008 19:00:39 +0100 (CET)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JY80093GY12FXF0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 24 Mar 2008 19:00:39 +0100 (CET)
In-reply-to: <alpine.LSU.1.00.0803241621210.4353@racer.site>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78068>

On Monday 24 March 2008, Johannes Schindelin wrote:
> On Sun, 23 Mar 2008, Johan Herland wrote:
> > I'm starting to think it's worth changing the default behaviour of push 
> > as follows:
> > 
> > Upon receiving a push into a non-bare repository, if the working copy is 
> > on the same branch as is being pushed, then refuse the push with a 
> > helpful message describing why the push was refused, and how to resolve 
> > this issue (i.e. referring to the tutorials you mention).
> > 
> > This would:
> > - Not clobber the working copy
> > - Tell newbies what happened and why
> > - Hopefully make this issue pop up less frequently
> > - Not affect you if you only push into bare repos
> > - Not affect you if you take care to never push into a checked-out 
> >   branch
> > 
> > Of course, you should be able to set a config option to get the old 
> > behaviour, and from there you can write hooks to either update the 
> > working copy, or detach HEAD, or whatever you please.
> 
> I think I sent out a sensible patch, which does not change the behaviour 
> in existing repositories.  This should be safer (read: nicer) for 
> Git old-timers.

Yes, I'm following the discussion between you and Junio with great interest. Will post if I have anything worthwhile to contribute. So far you both make a lot of sense.

Thanks a lot for the patch.


Have fun! :)

...Johan
-- 
Johan Herland, <johan@herland.net>
www.herland.net
