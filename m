From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Re: /bin/sh portability question
Date: Fri, 23 Sep 2005 14:17:05 +0200
Message-ID: <20050923121705.GA11377@sunq05.gbar.dtu.dk>
References: <20050923075058.GA25473@bohr.gbar.dtu.dk> <7vmzm4duf8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Sep 23 14:20:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EImUx-00045z-Qv
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 14:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbVIWMRI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 08:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbVIWMRI
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 08:17:08 -0400
Received: from sunq05.gbar.dtu.dk ([192.38.95.20]:31367 "HELO
	sunq05.gbar.dtu.dk") by vger.kernel.org with SMTP id S1750906AbVIWMRH
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 08:17:07 -0400
Received: (qmail 14577 invoked by uid 5842); 23 Sep 2005 12:17:05 -0000
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vmzm4duf8.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9180>

On Fri, Sep 23, 2005 at 02:07:07AM -0700, Junio C Hamano wrote:
> "Peter Eriksen" <s022018@student.dtu.dk> writes:
> 
> > It seems things are progressing nicely with regard to
> > Solaris portability.
> 
> Good to have a Solaris user.  I have one patch that I've been
> keeping in the proposed updates branch, waiting for a
> comfirmation or 'not-good-enough-for-me' answer from people that
> have cURL installed in nonstandard places.

GCC is not complaining.  :-)

My current make command is like this:

gmake NO_STRCASESTR=YesPlease CURLDIR=/opt/sfw/  \
      SHELL_PATH=/bin/bash INSTALL=ginstall install

There are two problems:

* First of all there really needs to be a TAR variable, 
  since Solaris tar doesn't like the C option. 

* Secondly I've noticed that git.sh and gitk don't get 
  their /bin/sh line changed during install.

/Peter
