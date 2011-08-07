From: Greg KH <greg@kroah.com>
Subject: Re: Suppressing auto-cc for specific addresses
Date: Sun, 7 Aug 2011 16:46:34 -0700
Message-ID: <20110807234634.GA3236@kroah.com>
References: <4E3EF38A.9010307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 08 01:47:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqD4X-0002YL-89
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 01:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752915Ab1HGXrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Aug 2011 19:47:51 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:38116 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752506Ab1HGXrv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Aug 2011 19:47:51 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 48E9220817;
	Sun,  7 Aug 2011 19:47:50 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Sun, 07 Aug 2011 19:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=smtpout;
	 bh=peNF+iJ8C9zblDqaCGXF7timccU=; b=RLiXjQMq3EaU95E7xhFJ8ix5z8Pd
	Vu3rSFwsiI8ENCBG5bTnP96kq3sg218hxOqnJ8R4ob4vJVIE+ZGosuzC8i/lb0ht
	Q/0l8fgdPXppJNIzrjLSTiEzd9qrp3Puz16QhokRlyElwGzXYvW5u2kVyXkHLgkC
	LWhHKMEJ26Htmhw=
X-Sasl-enc: DOxxTem8C5XLB4vAYCvYzOwoGJ4WdIWKpRCspMPQnVHR 1312760869
Received: from localhost (c-76-121-69-168.hsd1.wa.comcast.net [76.121.69.168])
	by mail.messagingengine.com (Postfix) with ESMTPSA id CC01745A7C7;
	Sun,  7 Aug 2011 19:47:49 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4E3EF38A.9010307@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178929>

On Sun, Aug 07, 2011 at 10:20:26PM +0200, Daniel Mack wrote:
> Hi,
> 
> I'm looking for a way to suppress certain Cc: fields that are
> normally automatically added for addresses mentioned in Cc: lines
> found in patches.
> 
> In particular, the kernel rules for marking patches for stable
> release inclusion wants users to add a "Cc: stable@kernel.org" line
> in the patch itself but to not actually send a copy of that patch to
> that address. It will be picked automatically once the patch was
> applied upstream.

There is no "rule" that says you can not send a copy of the patch to
stable@kernel.org, in fact that happens a lot and is fine and I have no
problem with that at all.

So please don't feel that you have to do anything different here with
git to properly follow the stable kernel rules, there should not be any
need.

thanks,

greg k-h
