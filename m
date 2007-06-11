From: Kevin Green <Kevin.T.Green@morganstanley.com>
Subject: Re: Asking again... [Re: how to properly import perforce history?]
Date: Mon, 11 Jun 2007 12:41:27 -0400
Message-ID: <20070611164127.GS25093@menevado.ms.com>
References: <20070608202236.GJ25093@menevado.ms.com> <20070611142525.GN25093@menevado.ms.com> <200706111656.33696.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Mon Jun 11 18:41:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxmxR-0006xF-3Z
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 18:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752733AbXFKQlb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 12:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752910AbXFKQlb
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 12:41:31 -0400
Received: from hqmtabh4.ms.com ([205.228.12.104]:45163 "EHLO hqmtabh4.ms.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752754AbXFKQl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 12:41:28 -0400
Received: from hqmtabh4 (localhost.ms.com [127.0.0.1])
	by hqmtabh4.ms.com (output Postfix) with ESMTP id 0657B482BD;
	Mon, 11 Jun 2007 12:41:28 -0400 (EDT)
Received: from ny37im01.ms.com (unknown [144.14.31.40])
	by hqvsbh1.ms.com (internal Postfix) with ESMTP id D80621969;
	Mon, 11 Jun 2007 12:41:27 -0400 (EDT)
Received: from menevado.ms.com (menevado [144.14.26.134])
	by ny37im01.ms.com (Sendmail MTA Hub) with ESMTP id l5BGfR907986;
	Mon, 11 Jun 2007 12:41:27 -0400 (EDT)
Received: (kgreen@localhost) by menevado.ms.com (8.12.11.20060308/sendmail.cf.client v1.05) id l5BGfRqU032541; Mon, 11 Jun 2007 12:41:27 -0400
X-Authentication-Warning: menevado.ms.com: kgreen set sender to Kevin.T.Green@morganstanley.com using -f
Mail-Followup-To: Simon Hausmann <simon@lst.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200706111656.33696.simon@lst.de>
User-Agent: Mutt/1.5.6i
X-Anti-Virus: Kaspersky Anti-Virus for MailServers 5.5.15/RELEASE, bases: 11062007 #321140, status: clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49864>

On 06/11/07 10:56:33, Simon Hausmann wrote:
> On Monday 11 June 2007 16:25:25 Kevin Green wrote:
> > Reading this again, the subject was probably misleading...  Sorry for that.
> >
> > In the meantime I've been scouring the archives looking for the proper way
> > to import p4 history into a project.
> >
> > I'm attempting to use git-p4import.py as that's what came with my version
> > of git.  I ran into the problems below.
> >
> > How can I properly migrate a project from perforce to git?
> 
> *plug* You could try with git-p4 from http://repo.or.cz/w/fast-export.git . It 
> should be just a matter of calling
> 
> 	git-p4 clone //depot/path
> 
> or
> 
> 	git-p4 clone //depot/path@all
> 
> (the former if you just want perforce #head, the latter if you want to import 
> all revisions).
> 

Thanks...  I'll try this today and post back on my experience.  From your
usage example here, it seems to behave the way I thought git-p4import.py
would.

Is git-p4import.py still used and maintained?  I submitted a patch to fix
something trivial on Friday, but didn't here any response to that either,
which led me to believe that it's not the tool being used most often for
p4->git migration...


--Kevin
