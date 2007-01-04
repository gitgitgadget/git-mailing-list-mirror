From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [0/2 PATCH] FastCGI and nginx support for gitweb
Date: Thu, 4 Jan 2007 01:25:59 -0800
Message-ID: <20070104092559.GA17473@localdomain>
References: <11678969111362-git-send-email-normalperson@yhbt.net> <enif9a$9ve$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 04 10:26:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2OrX-0001Yn-Lq
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 10:26:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbXADJ0F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 04:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbXADJ0F
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 04:26:05 -0500
Received: from hand.yhbt.net ([66.150.188.102]:60334 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932344AbXADJ0D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 04:26:03 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 20FE87DC094;
	Thu,  4 Jan 2007 01:26:00 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 04 Jan 2007 01:25:59 -0800
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <enif9a$9ve$1@sea.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35926>

Jakub Narebski <jnareb@gmail.com> wrote:
> Eric Wong wrote:
> 
> > I was looking at nginx for another project and got sidetracked
> > into writing instaweb support for it; so I ended up writing a
> > simple FCGI wrapper for gitweb as well.
> 
> FCGI, not CGI::Fast?

CGI::Fast is just a wrapper on top of FCGI but gives access to functions
in the CGI module.  We already use the CGI module explicitly in gitweb;
and I didn't want to make deeper changes in gitweb nor introduce extra
dependencies.

-- 
Eric Wong
