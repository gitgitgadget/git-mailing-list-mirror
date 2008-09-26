From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@strlen.de>
Subject: Re: mysterious error message
Date: Fri, 26 Sep 2008 10:20:03 +0200
Message-ID: <20080926082003.GA6772@strlen.de>
References: <20593.1222378418@as220.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tom Sgouros <tomfool@as220.org>
X-From: git-owner@vger.kernel.org Fri Sep 26 10:22:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kj8Zg-0008CZ-Nl
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 10:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753476AbYIZIUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 04:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753388AbYIZIUH
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 04:20:07 -0400
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:47441 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753223AbYIZIUF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2008 04:20:05 -0400
Received: id: ukleinek by Chamillionaire.breakpoint.cc authenticated by ukleinek with local
	(easymta 1.00 BETA 1)
	id 1Kj8YV-0001nB-9w; Fri, 26 Sep 2008 10:20:03 +0200
Content-Disposition: inline
In-Reply-To: <20593.1222378418@as220.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96838>

Hello,

On Thu, Sep 25, 2008 at 05:33:38PM -0400, Tom Sgouros wrote:
> I receive the following error message when I try to do a 'git push':
> 
>   tomfool@toms-box:hpl$ git push
>   updating 'refs/heads/master'
>     from ad4ae7925d3dd23798e7c5b733d2d8f930f7410f
>     to   5b5f5fae014a4f3535fa10b0f6e28b4bf3225dc3
>    Also local refs/remotes/origin/master
>   Generating pack...
>   Done counting 10 objects.
>   Deltifying 10 objects...
>   error: pack-objects died with strange error
>   unpack eof before pack header was fully read
>   ng refs/heads/master n/a (unpacker error)
>   error: failed to push to 'ssh://tomfool@as220.org/home/tomfool/hpl.git'
>   tomfool@toms-box:hpl$
> 
> I haven't been able to interpret this message, and haven't found it in
> the documentation, and google has let me down, too.  Can anyone tell me
> what is causing it?
I think it's a problem on the pushing side.  Maybe out of disk space (in
$GIT_DIR or $TMP_DIR)?  Does git repack work?

HTH
Uwe
