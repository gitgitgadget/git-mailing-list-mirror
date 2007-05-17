From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Smart fetch via HTTP?
Date: Fri, 18 May 2007 01:14:49 +0200
Organization: At home
Message-ID: <f2inc6$hl5$1@sea.gmane.org>
References: <20070515201006.GD3653@efreet.light.src> <46a038f90705152225y529c9db3x8615822e876c25a8@mail.gmail.com> <Pine.LNX.4.64.0705161232120.6410@racer.site> <46a038f90705161426n3b928086t2d3e68749557f866@mail.gmail.com> <Pine.LNX.4.64.0705170152470.6410@racer.site> <vpq8xbnlmdv.fsf@bauges.imag.fr> <46a038f90705170610mf9c9b0eu7b40af709469a601@mail.gmail.com> <Pine.LNX.4.64.0705171445100.6410@racer.site> <46a038f90705170709j7eb23d4fy6811fc2985dd888d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 18 01:10:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hop7L-0008S3-5l
	for gcvg-git@gmane.org; Fri, 18 May 2007 01:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755649AbXEQXKh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 19:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755746AbXEQXKh
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 19:10:37 -0400
Received: from main.gmane.org ([80.91.229.2]:50619 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755578AbXEQXKg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 19:10:36 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hop72-0001OP-6n
	for git@vger.kernel.org; Fri, 18 May 2007 01:10:24 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 May 2007 01:10:24 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 May 2007 01:10:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47564>

Martin Langhoff wrote:

> On 5/18/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> If you have a solution for that problem, please enlighten me: I don't.
> 
> Ok - worst case scenario - have a minimal hints file that tells me the
> ranges to fetch all commits and all trees. To reduce that Add to the
> hints file data to name the hashes (or even better - offsets) for the
> delta chains that contain commits+trees relevant to all the heads -
> minus 10, 20, 30, 40 commits and 1,2,4,8 and 16 days.
> 
> So there's a good chance the client can get the commits+trees needed
> efficiently. For blobs, all you need is the index to mark the delta
> chains you need.

By the way, I think we always should get the whole delta chain, unless we
are absolutely sure that we have base object(s) in repo.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
