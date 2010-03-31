From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: Import ClearCaase with history?
Date: Wed, 31 Mar 2010 17:39:05 +0200
Message-ID: <20100331153905.GA14999@m62s10.vlinux.de>
References: <1270035189.2785.11.camel@chumley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: David Hagood <david.hagood@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 17:39:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nx00j-0001kY-EE
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 17:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756942Ab0CaPjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Mar 2010 11:39:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:39913 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755842Ab0CaPjL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 11:39:11 -0400
Received: (qmail invoked by alias); 31 Mar 2010 15:39:07 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp062) with SMTP; 31 Mar 2010 17:39:07 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX19QeO8VdsVQeKjU32nWE6xrsVkhl4a7900fV1URq3
	0FIorfZx5Oh3hr
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 0AF95D4002; Wed, 31 Mar 2010 17:39:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1270035189.2785.11.camel@chumley>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65000000000000002
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143681>

On Wed, Mar 31, 2010 at 06:33:09AM -0500, David Hagood wrote:
> I am trying to drag where I work into a more modern software development
> process, but I am getting resistance from one division that has a large
> amount of history for some projects in a Clearcase repository. If I
> could show them that we could import all that history into git, it would
> go a long way to removing that resistance.
> 
> I've seen programs that purport to import Subversion (which is also
> good, as they also are using Subversion for other projects....) but do
> any such programs exist for Clearcase?
> 
> I know that, in theory, it would be possible to 
>   for all checkins to Clearcase
>      check out of Clearcase
>      check into git
>   done
> 
> but that would take an incredibly long time in practice, wouldn't it?
> 

I don't think you can build anything which will import from ClearCase 
*without* loosing *some* history. At least I have build a script which imported
something from CC into git in my former job and allow me to sync bidirectional
with CC. 

The problems where no bidirectional mapping exists are the following:

  - CC is file based, where as GIT is tree (the whole repository) based

  - This leads to problems where you merge a file on differen CC branches,
    because in GIT a merge is only on the whole tree, so at least this
    information is lost. (see cleartool lstree for a file with merges)

Peter
