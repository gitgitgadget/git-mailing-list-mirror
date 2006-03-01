From: Greg KH <greg@kroah.com>
Subject: Re: git doesn't like big files when pushing
Date: Wed, 1 Mar 2006 14:08:40 -0800
Message-ID: <20060301220840.GB18250@kroah.com>
References: <20060301220802.GA18250@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Mar 01 23:08:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEZUq-0007FJ-N7
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 23:08:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWCAWIe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 17:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWCAWId
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 17:08:33 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:14026
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751319AbWCAWId (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Mar 2006 17:08:33 -0500
Received: from press.kroah.org ([192.168.0.25] helo=localhost)
	by aria.kroah.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.54)
	id 1FEZUi-0004uq-3K
	for git@vger.kernel.org; Wed, 01 Mar 2006 14:08:28 -0800
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060301220802.GA18250@kroah.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17019>

On Wed, Mar 01, 2006 at 02:08:02PM -0800, Greg KH wrote:
> I have a mail archive stored with git, in mbox form, and I made some
> changes to a few of the files and checked them back in.
> 
> That worked fine, but when I went to push the stuff to my server, I got
> the following errors:
> 
> $ git push origin
> updating 'refs/heads/master'
>   from 490badd9bec9ada3a21be275c97fb2a3a390f49e
>   to   16be8985abc8a9c89ad2cc8f46a0d8e9786e832f
> Generating pack...
> Done counting 8 objects.
> Deltifying 8 objects.
> fatal: Out of memory, malloc failed
> fatal: early EOF
> unpack unpacker exited with error code
> ng refs/heads/master n/a (unpacker error)

Oh, and I'm using:
	$ git --version
	git version 1.2.3.g8c2f

if that helps or not.

thanks,

greg k-h
