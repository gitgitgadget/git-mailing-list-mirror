From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: no diffstat for 'git request-pull' (was Re: [GIT PATCH]
 char/misc changes for 3.7-rc1)
Date: Mon, 1 Oct 2012 11:17:39 -0700
Message-ID: <20121001181739.GA10827@kroah.com>
References: <20121001175433.GA10092@kroah.com>
 <20121001175711.GB10092@kroah.com>
 <201210011803.48211.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
X-From: git-owner@vger.kernel.org Mon Oct 01 20:18:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIkZC-0004nG-Ol
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 20:18:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753801Ab2JASRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 14:17:42 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37749 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751379Ab2JASRl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Oct 2012 14:17:41 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id B3D2520653;
	Mon,  1 Oct 2012 14:17:40 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 01 Oct 2012 14:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=smtpout;
	 bh=Ftn/fFtHcAPOl9gKszQV5MJENa8=; b=VJQWWZIR9W94H36VHQEDJ+gtQmaC
	qpKHqFeadm3ponnzbGVZ8BYTKOCtAYz5njXTwXQhYKnzvDBMAjPLLa8qwHuwNYVQ
	K+Aurw/+E6RAm4BluaijdwPa3BqDMxSMhMh03+FkhIdQp7YhiQWm8v27V5wBDqUZ
	2/QNm08bzeM8HsI=
X-Sasl-enc: bPGe55M1CuQFejY2cz8E09WqJ0og40aG2HFVhCr+ySI4 1349115460
Received: from localhost (unknown [67.168.183.230])
	by mail.messagingengine.com (Postfix) with ESMTPA id 4A9AD4827BB;
	Mon,  1 Oct 2012 14:17:40 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <201210011803.48211.arnd@arndb.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206754>

On Mon, Oct 01, 2012 at 06:03:47PM +0000, Arnd Bergmann wrote:
> On Monday 01 October 2012, Greg KH wrote:
> > Wait, what happened to the diffstat?  Does the latest version of git not
> > send out the diffstat for 'git request-pull'?  It used to on older
> > versions, I just updated the version on my machine that generated this
> > to
> >         git version 1.7.12.2.421.g261b511
> > 
> > Do I have to give a new option to request-pull to have the diffstat show
> > up?  I'm using
> >         git request-pull master git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/ char-misc-3.6
> > 
> > For this specific request pull.
> 
> It looks more like you just sent an empty pull request from v3.6-rc3 to 
> v3.6-rc3 (fea7a08acb135).

Ah crap, you are right, totally my fault.

I'll blame it on being Monday morning...

sorry for the noise...

greg k-h
