From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git merge --no-commit <branch>; does commit
Date: Fri, 14 Dec 2007 08:49:25 +0100
Message-ID: <20071214074925.GA3525@steel.home>
References: <alpine.LSU.0.99999.0712132151080.5326@castor.milkiway.cos> <81b0412b0712131319h63609810m593f0e552d02a83c@mail.gmail.com> <alpine.LSU.0.99999.0712132224280.5606@castor.milkiway.cos>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Dressel <MichaelTiloDressel@t-online.de>
X-From: git-owner@vger.kernel.org Fri Dec 14 08:49:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J35Iu-0004P2-HM
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 08:49:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbXLNHta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 02:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbXLNHta
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 02:49:30 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:49282 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbXLNHt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 02:49:29 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3Cculzxto3kTA==
Received: from tigra.home (Faa3a.f.strato-dslnet.de [195.4.170.58])
	by post.webmailer.de (mrclete mo16) (RZmta 14.6)
	with ESMTP id L069a2jBE6k9DL ; Fri, 14 Dec 2007 08:49:26 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 658E9277AE;
	Fri, 14 Dec 2007 08:49:26 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id BF8EE56D22; Fri, 14 Dec 2007 08:49:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.0.99999.0712132224280.5606@castor.milkiway.cos>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68258>

Michael Dressel, Thu, Dec 13, 2007 22:28:30 +0100:
> On Thu, 13 Dec 2007, Alex Riesen wrote:
>> On 13/12/2007, Michael Dressel <MichaelTiloDressel@t-online.de> wrote:
>>> git merge --no-commit <branch> does "create" a commit. At lesat the
>>> head and index are moved to the new commit fetched from <branch>. Maybe
>>> that is because git was able to do a fast forward?
>>
>> Yes. Because fast-forward is what it called: fast-forward.
>> It does not do any commits at all.
>>
>
> It looks like I misunderstood the meaning of --no-commit. I have to use 
> --squash in this case.
>

Maybe. Or maybe you misunderstood the meaning of --squash, which also
is not a merge.
