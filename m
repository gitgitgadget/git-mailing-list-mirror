From: Greg KH <gregkh@linuxfoundation.org>
Subject: no diffstat for 'git request-pull' (was Re: [GIT PATCH] char/misc
 changes for 3.7-rc1)
Date: Mon, 1 Oct 2012 10:57:11 -0700
Message-ID: <20121001175711.GB10092@kroah.com>
References: <20121001175433.GA10092@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>
X-From: git-owner@vger.kernel.org Mon Oct 01 19:57:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIkFQ-0004MH-MS
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 19:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967Ab2JAR5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 13:57:14 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:53639 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751828Ab2JAR5N (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Oct 2012 13:57:13 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id AE4EA2089C;
	Mon,  1 Oct 2012 13:57:12 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Mon, 01 Oct 2012 13:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=smtpout;
	 bh=/VJjBgGNW1TMRobzf/tsEaC23Kg=; b=oXDYkyPj97OUh/tg4RVCMB0N8q6f
	JJOvcgs1ew47y2myjDFY+62C6wu4hy7uj2rP9fWwGYjeqbh2CJ0BOTMQcxHJGCC9
	VAB80OWkU7+knW1RBaQXkCM4wJgH9BHCd8NKT1+XrmNdeEoL69WnF+DKVkIeWdTa
	vY762z+J/fWhzEI=
X-Sasl-enc: f1vUuFI/7n918QWaVziCLhuUNKTKSPqncEPz+VRtfCxV 1349114232
Received: from localhost (unknown [67.168.183.230])
	by mail.messagingengine.com (Postfix) with ESMTPA id 477504827AD;
	Mon,  1 Oct 2012 13:57:12 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20121001175433.GA10092@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206750>

On Mon, Oct 01, 2012 at 10:54:33AM -0700, Greg KH wrote:
> The following changes since commit fea7a08acb13524b47711625eebea40a0ede69a0:
> 
>   Linux 3.6-rc3 (2012-08-22 13:29:06 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/ tags/char-misc-3.6
> 
> for you to fetch changes up to fea7a08acb13524b47711625eebea40a0ede69a0:
> 
>   Linux 3.6-rc3 (2012-08-22 13:29:06 -0700)
> 
> ----------------------------------------------------------------
> char/misc driver merge for 3.7-rc1
> 
> Here is the "big" char/misc driver tree update for the 3.7-rc1 merge
> window.
> 
> Nothing major, just a number of driver updates and fixes, all of which
> have been in the linux-next releases for a while now either in my tree,
> or in Andrew's (the lis3l driver changes came from his tree last week).
> 
> ----------------------------------------------------------------


Wait, what happened to the diffstat?  Does the latest version of git not
send out the diffstat for 'git request-pull'?  It used to on older
versions, I just updated the version on my machine that generated this
to
	git version 1.7.12.2.421.g261b511

Do I have to give a new option to request-pull to have the diffstat show
up?  I'm using
	git request-pull master git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/ char-misc-3.6

For this specific request pull.

greg k-h
