From: Greg KH <greg@kroah.com>
Subject: Re: git doesn't like big files when pushing
Date: Wed, 1 Mar 2006 14:20:18 -0800
Message-ID: <20060301222018.GA9965@kroah.com>
References: <20060301220802.GA18250@kroah.com> <20060301220840.GB18250@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Mar 01 23:22:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEZgb-0001gn-Hr
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 23:20:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWCAWUg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 17:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWCAWUf
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 17:20:35 -0500
Received: from mail.kroah.org ([69.55.234.183]:53438 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751285AbWCAWUf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 17:20:35 -0500
Received: from [192.168.0.10] (dsl093-040-174.pdx1.dsl.speakeasy.net [66.93.40.174])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id k21MKYK29332
	for <git@vger.kernel.org>; Wed, 1 Mar 2006 14:20:34 -0800
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1FEZgA-2as-00 for <git@vger.kernel.org>; Wed, 01 Mar 2006 14:20:18
 -0800
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060301220840.GB18250@kroah.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17021>

On Wed, Mar 01, 2006 at 02:08:40PM -0800, Greg KH wrote:
> On Wed, Mar 01, 2006 at 02:08:02PM -0800, Greg KH wrote:
> > I have a mail archive stored with git, in mbox form, and I made some
> > changes to a few of the files and checked them back in.
> > 
> > That worked fine, but when I went to push the stuff to my server, I got
> > the following errors:
> > 
> > $ git push origin
> > updating 'refs/heads/master'
> >   from 490badd9bec9ada3a21be275c97fb2a3a390f49e
> >   to   16be8985abc8a9c89ad2cc8f46a0d8e9786e832f
> > Generating pack...
> > Done counting 8 objects.
> > Deltifying 8 objects.
> > fatal: Out of memory, malloc failed
> > fatal: early EOF
> > unpack unpacker exited with error code
> > ng refs/heads/master n/a (unpacker error)
> 
> Oh, and I'm using:
> 	$ git --version
> 	git version 1.2.3.g8c2f

Hm, 1.2.4.g6177 seems better, it's still trying to pack things, after
about 10 minutes, but at least it isn't dying yet.  I'll let you know if
it finishes properly or not...

thanks,

greg k-h
