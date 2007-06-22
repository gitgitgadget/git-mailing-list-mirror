From: Kevin Green <Kevin.T.Green@morganstanley.com>
Subject: Re: [RFC][PATCH] Fix assumption that git is installed in a standard place on the remote end ssh
Date: Thu, 21 Jun 2007 21:30:26 -0400
Message-ID: <20070622013026.GY14298@menevado.ms.com>
References: <20070615150351.GH14677@menevado.ms.com> <Pine.LNX.4.64.0706151628180.31972@reaper.quantumfyre.co.uk> <20070615154000.GK14677@menevado.ms.com> <Pine.LNX.4.64.0706190114110.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 22 03:30:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1Xyo-0004p9-61
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 03:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbXFVBa3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 21:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbXFVBa2
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 21:30:28 -0400
Received: from hqmtabh1.ms.com ([205.228.12.101]:41383 "EHLO hqmtabh1.ms.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164AbXFVBa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 21:30:28 -0400
Received: from hqmtabh1 (localhost.ms.com [127.0.0.1])
	by hqmtabh1.ms.com (output Postfix) with ESMTP id 755D948025;
	Thu, 21 Jun 2007 21:30:27 -0400 (EDT)
Received: from ny16im02.ms.com (pimail3.ms.com [144.14.206.243])
	by hqmtabh1.ms.com (internal Postfix) with ESMTP id 5C85B180010;
	Thu, 21 Jun 2007 21:30:27 -0400 (EDT)
Received: from menevado.ms.com (menevado [144.14.26.134])
	by ny16im02.ms.com (Sendmail MTA Hub) with ESMTP id l5M1URF11861;
	Thu, 21 Jun 2007 21:30:27 -0400 (EDT)
Received: (kgreen@localhost) by menevado.ms.com (8.12.11.20060308/sendmail.cf.client v1.05) id l5M1UQpk002429; Thu, 21 Jun 2007 21:30:26 -0400
X-Authentication-Warning: menevado.ms.com: kgreen set sender to Kevin.T.Green@morganstanley.com using -f
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0706190114110.4059@racer.site>
User-Agent: Mutt/1.5.6i
X-Anti-Virus: Kaspersky Anti-Virus for MailServers 5.5.15/RELEASE, bases: 22062007 #329137, status: clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50663>

On 06/18/07 20:16:47, Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 15 Jun 2007, Kevin Green wrote:
> 
> > I'm thinking I like the env var idea much more though.  I can just 
> > export it in my shell and it works in both cases.
> 
> And it completely breaks down when you have more than one remotes. Or when 
> you cd to another project with another remote. Or etc. IOW it is fragile.
> 
> Clearly, the config approach is the only one which makes sense. This 
> information is so closely coupled to a specific remote that you should 
> store it right where you store all the other remote information, too.
> 

You're absolutely right.  I agree, except that in _my_ environment git will
be in a non-standard path but *always* consistently in the same place.  I'm being
greedy here. :)

The config approach is clearly the most versatile.  The question I have is, is
there a good reason not to provide the third option of setting env var?  I suppose that in the
more likely case this could cause more harm than good, i.e. maybe
this is too specific for my use case.


Thanks

--Kevin
