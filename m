From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] gitweb: optionally read config from GITWEB_CONFIG
Date: Wed, 2 Aug 2006 22:31:57 +0200
Message-ID: <E1G8NNl-0006ez-6J@moooo.ath.cx>
References: <20060802192333.GA30861@coredump.intra.peff.net> <ear1fp$j9p$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 02 22:32:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8NNu-0006d3-Sx
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 22:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbWHBUcA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 16:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbWHBUcA
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 16:32:00 -0400
Received: from moooo.ath.cx ([85.116.203.178]:10135 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1750872AbWHBUb7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Aug 2006 16:31:59 -0400
To: Jakub Narebski <jnareb@gmail.com>
Mail-Followup-To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <ear1fp$j9p$2@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24679>

Jakub Narebski <jnareb@gmail.com> wrote:
> Jeff King wrote:
> > @@ -56,7 +50,7 @@ # URI of GIT logo
> >  our $logo = "@@GITWEB_LOGO@@";
> >  
> >  # source of projects list
> > -our $projects_list = "@@GITWEB_LIST@@" || "$projectroot";
> > +our $projects_list = "@@GITWEB_LIST@@";
> >  
> >  # default blob_plain mimetype and default charset for text/plain blob
> >  our $default_blob_plain_mimetype = 'text/plain';
> 
> But why that change?
Earlier this was undef if the user did not change it.  Now this is
always a string so the second one will probably never come into play
except the user chooses to set the string to undef again.
