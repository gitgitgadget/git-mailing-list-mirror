From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Rebasing stgit stacks
Date: Thu, 18 Jan 2007 12:06:20 +0000
Message-ID: <tnxmz4gv8sj.fsf@arm.com>
References: <8b65902a0701091335u160c6dfl81a523e4cd5adbee@mail.gmail.com>
	<8b65902a0701091341v5983c113tc5cd32c6c4c57719@mail.gmail.com>
	<20070109224125.GF17093@nan92-1-81-57-214-146.fbx.proxad.net>
	<8b65902a0701150526j5a954529xf45b2d0348a77573@mail.gmail.com>
	<20070115202412.GE9761@nan92-1-81-57-214-146.fbx.proxad.net>
	<b0943d9e0701151446l45eff9dbgcae718c1461d0725@mail.gmail.com>
	<20070115233958.GF9761@nan92-1-81-57-214-146.fbx.proxad.net>
	<b0943d9e0701161442t6b93e0d6nd88364600f2809ee@mail.gmail.com>
	<20070116231735.GF7029@nan92-1-81-57-214-146.fbx.proxad.net>
	<eojn5c$v9u$1@sea.gmane.org>
	<20070117205301.GH9761@nan92-1-81-57-214-146.fbx.proxad.net>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 13:30:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7WP9-0004mu-Em
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 13:30:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbXARMaB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 07:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbXARMaB
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 07:30:01 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:41737 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932220AbXARMaA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jan 2007 07:30:00 -0500
X-Greylist: delayed 1413 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jan 2007 07:29:59 EST
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id l0IC6MYo012044;
	Thu, 18 Jan 2007 12:06:23 GMT
Received: from localhost.localdomain ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Thu, 18 Jan 2007 12:07:03 +0000
To: Yann Dirson <ydirson@altern.org>
In-Reply-To: <20070117205301.GH9761@nan92-1-81-57-214-146.fbx.proxad.net> (Yann
 Dirson's message of "Wed, 17 Jan 2007 21:53:01 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 18 Jan 2007 12:07:03.0293 (UTC) FILETIME=[2A3802D0:01C73AF9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37084>

Yann Dirson <ydirson@altern.org> wrote:
> On Wed, Jan 17, 2007 at 12:30:18AM +0100, Jakub Narebski wrote:
>> I'm all for calling this command "stg rebase".
>
> After all, my current implementation as "pull --to" mostly bypasses
> the fetch, so it probably makes sense to use a new command.
>
> However, "stg rebase <target>" does not sound right.  I'm not very
> happy with "stg rebaseto <target>" (or rebase-to) either.

I think something 'stg rebase <newbase>' sounds OK.

-- 
Catalin
