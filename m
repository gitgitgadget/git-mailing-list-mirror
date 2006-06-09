From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Figured out how to get Mozilla into git
Date: Fri, 9 Jun 2006 16:17:26 -0400
Message-ID: <9e4733910606091317p26d66579mdf93db293f93fb50@mail.gmail.com>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
	 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
	 <9e4733910606091113vdc6ab06l2d3582cb82b8fd09@mail.gmail.com>
	 <Pine.LNX.4.64.0606091158460.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 09 22:17:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FonQC-0000he-1T
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 22:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030487AbWFIUR2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 16:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030489AbWFIUR2
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 16:17:28 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:15447 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030488AbWFIUR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jun 2006 16:17:27 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1160538nze
        for <git@vger.kernel.org>; Fri, 09 Jun 2006 13:17:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hI0UPcHzJRfTmd6xOx8IPtMz7n1ZabUDLYRa+N/iu/NEldi08Ry3hcUJMKMPjOL8VXd4zcnjR8+2ox4u8DeOhJJVrXtIAEs00YMblf8PYeB4Da7TU3NB2TpFAZj2JguRBtwr396hej4iY3HRLxYXHuMCYddo3QU925UydKSFUNk=
Received: by 10.37.12.10 with SMTP id p10mr4700247nzi;
        Fri, 09 Jun 2006 13:17:26 -0700 (PDT)
Received: by 10.36.37.15 with HTTP; Fri, 9 Jun 2006 13:17:26 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606091158460.5498@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21547>

On 6/9/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Fri, 9 Jun 2006, Jon Smirl wrote:
> >
> > That looks too small. My svn git import is 2.7GB and the source CVS is
> > 3.0GB. The svn import wasn't finished when I stopped it.
>
> Git is much better at packing than either CVS or SVN. Get used to it ;)

The git tree that Martin got from cvsps is much smaller that the git
tree I got from going to svn then to git.  I don't why the trees are
700KB different, it may be different amounts of packing, or one of the
conversion tools is losing something.

Earlier he said:
>git-repack -a -d but it OOMs on my 2GB+2GBswap machine :(

> > My cvsps process is still running from last night. The error file is
> > 341MB. How big is it when the conversion is finished? My machine is
> > swapping to death.
>
> Do you have all the cvsps patches? There's a few important ones floating
> around, and David Mansfield never did a 2.2 release..

I am running cvsps-2.1-3.fc5 so I may be wasting my time. Error out is
535MB now.
He sent me some git patches, but none for cvsps.

> I'm pretty sure Martin doesn't run plain 2.1.

I haven't come up with anything that is likely to result in Mozilla
switching over to git. Right now it takes three days to convert the
tree. The tree will have to be run in parallel for a while to convince
everyone to switch. I don't have a solution to keeping it in sync in
near real time (commits would still go to CVS). Most Mozilla
developers are interested but the infrastructure needs some help.

Martin has also brought up the problem with needing a partial clone so
that everyone doesn't have to bring down the entire repository. A
trunk checkout is 340MB and Martin's git tree is 2GB (mine 2.7GB).  A
kernel tree is only 680M.

-- 
Jon Smirl
jonsmirl@gmail.com
