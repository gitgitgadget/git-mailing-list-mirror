From: Greg KH <greg@kroah.com>
Subject: Re: Fw: [PATCH 31/49] PCI: PCI/Cardbus cards hidden, needs pci=assign-busses to fix
Date: Thu, 23 Mar 2006 16:46:54 -0800
Message-ID: <20060324004654.GA19763@kroah.com>
References: <20060323161521.28a874e6.akpm@osdl.org> <20060324002930.GA21184@kroah.com> <20060323163844.5fda7589.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 01:48:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMaU2-0007gn-Md
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 01:48:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbWCXAsw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 19:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWCXAsw
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 19:48:52 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:36264
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751456AbWCXAsv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Mar 2006 19:48:51 -0500
Received: from [192.168.0.13] (helo=localhost)
	by aria.kroah.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.54)
	id 1FMaSW-00059W-Te; Thu, 23 Mar 2006 16:47:20 -0800
To: Andrew Morton <akpm@osdl.org>
Content-Disposition: inline
In-Reply-To: <20060323163844.5fda7589.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17892>

On Thu, Mar 23, 2006 at 04:38:44PM -0800, Andrew Morton wrote:
> 
> (added Junio)

Added the git mailing list as everyone should get involved :)

> recap: the patch emails which Greg sends to linux-kernel do not identify
> their actual Author.
> 
> 
> Greg KH <greg@kroah.com> wrote:
> >
> > On Thu, Mar 23, 2006 at 04:15:21PM -0800, Andrew Morton wrote:
> > > 
> > > It's unclear from this email who the patch author was?
> > 
> > Git seems to strip that off when it converts them to emails.  It was:
> > 	From: Bernhard Kaindl <bk@suse.de>
> > 
> > If you look at the git changeset, it got it correct.
> > 
> 
> OK.   We really should have a
> 
> 	From: Bernhard Kaindl <bk@suse.de>
> 
> right at the start of the email, IMO.  Can you describe how you're producing
> them please?

I'm using:
	git format-patch -n origin..HEAD
to generate the raw patch files, and then:
	git-send-email --in-reply-to "<some_message_id>" --to some_mailing_list@somewhere.com

fixing the obvious message id and mailing list address to be the correct
one depending on the subsystem the patches are from.

thanks,

greg k-h
