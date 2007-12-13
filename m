From: Michael Dressel <MichaelTiloDressel@t-online.de>
Subject: Re: git merge --no-commit <branch>; does commit
Date: Thu, 13 Dec 2007 22:28:30 +0100 (CET)
Message-ID: <alpine.LSU.0.99999.0712132224280.5606@castor.milkiway.cos>
References: <alpine.LSU.0.99999.0712132151080.5326@castor.milkiway.cos> <81b0412b0712131319h63609810m593f0e552d02a83c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Michael Dressel <MichaelTiloDressel@t-online.de>,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 22:30:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2vcG-000652-LU
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 22:29:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753111AbXLMV2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 16:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754007AbXLMV2u
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 16:28:50 -0500
Received: from mailout10.sul.t-online.de ([194.25.134.21]:43855 "EHLO
	mailout10.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753111AbXLMV2t (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Dec 2007 16:28:49 -0500
Received: from fwd34.aul.t-online.de 
	by mailout10.sul.t-online.com with smtp 
	id 1J2vbr-0004TA-00; Thu, 13 Dec 2007 22:28:47 +0100
Received: from [192.168.2.100] (Sm-OpmZvohYP8iDBOCHByvCNrDlpIfMDIpakvmPAlEK9ozKuQ++mNvZ35DJaY2DgeG@[84.163.237.176]) by fwd34.t-online.de
	with esmtp id 1J2vbe-0AP6jg0; Thu, 13 Dec 2007 22:28:34 +0100
X-X-Sender: michael@castor.milkiway.cos
In-Reply-To: <81b0412b0712131319h63609810m593f0e552d02a83c@mail.gmail.com>
User-Agent: Alpine 0.99999 (LSU 796 2007-11-08)
X-ID: Sm-OpmZvohYP8iDBOCHByvCNrDlpIfMDIpakvmPAlEK9ozKuQ++mNvZ35DJaY2DgeG
X-TOI-MSGID: 82596990-1113-4a6b-8f7a-ce04379478af
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68195>



On Thu, 13 Dec 2007, Alex Riesen wrote:

> On 13/12/2007, Michael Dressel <MichaelTiloDressel@t-online.de> wrote:
>> git merge --no-commit <branch> does "create" a commit. At lesat the
>> head and index are moved to the new commit fetched from <branch>. Maybe
>> that is because git was able to do a fast forward?
>
> Yes. Because fast-forward is what it called: fast-forward.
> It does not do any commits at all.
>

It looks like I misunderstood the meaning of --no-commit. I have 
to use --squash in this case.

Cheers,
Michael
