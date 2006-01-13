From: Adrian Bunk <bunk@stusta.de>
Subject: Re: git pull on Linux/ACPI release tree
Date: Fri, 13 Jan 2006 15:50:27 +0100
Message-ID: <20060113145027.GN29663@stusta.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com> <Pine.LNX.4.64.0601081111190.3169@g5.osdl.org> <20060108230611.GP3774@stusta.de> <Pine.LNX.4.64.0601081909250.3169@g5.osdl.org> <20060110201909.GB3911@stusta.de> <20060112013706.GA3339@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	"Brown, Len" <len.brown@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 15:50:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExQG9-0000Yv-6g
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 15:50:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422705AbWAMOua (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 09:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422708AbWAMOu3
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 09:50:29 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:44043 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422703AbWAMOu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 09:50:28 -0500
Received: (qmail 22516 invoked from network); 13 Jan 2006 14:50:26 -0000
Received: from r063144.stusta.swh.mhn.de (10.150.63.144)
  by mailhub.stusta.mhn.de with SMTP; 13 Jan 2006 14:50:26 -0000
Received: by r063144.stusta.swh.mhn.de (Postfix, from userid 1000)
	id B49FB197422; Fri, 13 Jan 2006 15:50:27 +0100 (CET)
To: Greg KH <greg@kroah.com>
Content-Disposition: inline
In-Reply-To: <20060112013706.GA3339@kroah.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14627>

On Wed, Jan 11, 2006 at 05:37:06PM -0800, Greg KH wrote:
> On Tue, Jan 10, 2006 at 09:19:09PM +0100, Adrian Bunk wrote:
> > 
> > I am using the workaround of carrying the patches in a mail folder, 
> > applying them in a batch, and not pulling from your tree between 
> > applying a batch of patches and you pulling from my tree.
> 
> Ick, I'd strongly recommend using quilt for this.  It works great for
> just this kind of workflow.

It works in my case because I'm only going through the folder with the 
trivial patches in batches and ask Linus to pull from my tree 
immediately after I'm finished.

That would certainly not be a recommended practice for a subsystem 
maintainer, but I'm handling only trivial patches.

> thanks,
> 
> greg k-h

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
