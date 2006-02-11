From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Don't send copies to the From: address
Date: Fri, 10 Feb 2006 20:52:56 -0800
Message-ID: <20060211045256.GA23066@kroah.com>
References: <11396260373307-git-send-email-cbiesinger@web.de> <7vk6c2sg66.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Biesinger <cbiesinger@web.de>, git@vger.kernel.org,
	Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 05:53:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7mlO-00089m-HA
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 05:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWBKEx0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 23:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWBKEx0
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 23:53:26 -0500
Received: from mail.kroah.org ([69.55.234.183]:48337 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932249AbWBKExZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2006 23:53:25 -0500
Received: from [192.168.0.10] (dsl093-040-174.pdx1.dsl.speakeasy.net [66.93.40.174])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id k1B4rIK15745;
	Fri, 10 Feb 2006 20:53:18 -0800
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1F7mki-60B-00; Fri, 10 Feb 2006 20:52:56 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk6c2sg66.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15926>

On Fri, Feb 10, 2006 at 07:55:13PM -0800, Junio C Hamano wrote:
> Christian Biesinger <cbiesinger@web.de> writes:
> 
> > Sending copies to the from address is pointless.
> 
> Ryan, care to defend this part of the code?  This behaviour
> might have been inherited from Greg's original version.
> 
> I cannot speak for Ryan or Greg, but I think the script
> deliberately does this to support this workflow:
> 
>  (1) The original author sends in a patch to a subsystem
>      maintainer;
> 
>  (2) The subsystem maintainer applies the patch to her tree,
>      perhaps with her own sign-off and sign-offs by other people
>      collected from the list.  She examines it and says this
>      patch is good;
> 
>  (3) The commit is formatted and sent to higher level of the
>      foodchain.  The message is CC'ed to interested parties in
>      order to notify that the patch progressed in the
>      foodchain.
> 
> Me, personally I do not like CC: to people on the signed-off-by
> list, but dropping a note to From: person makes perfect sense to
> me, if it is to notify the progress of the patch.

Yes, they specifically should be notified of the progress of their
patch.  And I like the fact that everyone else on the signed-off-by
chain also get's cc: too.  It keeps everyone in the loop so they know
what is going on.

> What you are after _might_ be not CC'ing it if it was your own
> patch.  Maybe something like this would help, but even if that
> is the case I suspect many people want to CC herself so it needs
> to be an optional feature.

Heh, getting a patch sent back to yourself this way is not a real big
deal at all :)

So, I really do not like this proposed patch at all.

thanks,

greg k-h
