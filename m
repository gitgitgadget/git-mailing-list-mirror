From: Greg KH <greg@kroah.com>
Subject: Re: git applymbox is too anal
Date: Fri, 9 Sep 2005 10:07:56 -0700
Message-ID: <20050909170756.GB24894@kroah.com>
References: <20050908232535.GA7700@kroah.com> <Pine.LNX.4.58.0509081754150.3051@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 19:17:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDmTX-0007PU-9r
	for gcvg-git@gmane.org; Fri, 09 Sep 2005 19:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbVIIRPf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Sep 2005 13:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbVIIRPf
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Sep 2005 13:15:35 -0400
Received: from mail.kroah.org ([69.55.234.183]:22152 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030267AbVIIRPf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2005 13:15:35 -0400
Received: from [192.168.0.10] (c-24-22-115-24.hsd1.or.comcast.net [24.22.115.24])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id j89HFXw01147;
	Fri, 9 Sep 2005 10:15:33 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1EDmM0-6Xl-00; Fri, 09 Sep 2005 10:07:56 -0700
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509081754150.3051@g5.osdl.org>
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8245>

On Thu, Sep 08, 2005 at 05:58:18PM -0700, Linus Torvalds wrote:
> 
> 
> On Thu, 8 Sep 2005, Greg KH wrote:
> > 
> > Or am I missing some option to 'git applymbox' that I can't seem to
> > find?
> 
> No. git-apply wants an exact bit-for-bit match. Partly because fuzz is 
> hard, but mostly because I don't like it. I apply a _lot_ of patches, and 
> if a unforgiving "git-apply" works for me, it should work for you too.

Ok, as I've been using quilt to stage patches before they are ready to
send to you, sometimes, when I build up the final tree, there are tiny
fuzz issues.  I'll just make sure to fix this up before running
applymbox in the future.

thanks,

greg k-h
