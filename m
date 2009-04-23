From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: [EGit PATCH] IgnoreAction to add to .gitignore files
Date: Thu, 23 Apr 2009 22:17:56 +0200
Message-ID: <49F0CCF4.20808@pelagic.nl>
References: <20090423115042.743E6D9CDC@apple.int.bandlem.com> <200904231427.29832.fge@one2team.com> <0A94BEDB-37A1-44D2-BE54-D05F0C3124EE@bandlem.com> <200904232119.36707.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alex Blewitt <alex@bandlem.com>,
	Francis Galiegue <fge@one2team.com>, git@vger.kernel.org,
	spearce@spearce.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 22:19:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx5OU-0005Hd-7S
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 22:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbZDWUSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 16:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752393AbZDWUSD
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 16:18:03 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:58287 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752553AbZDWUSB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Apr 2009 16:18:01 -0400
Received: from [192.168.0.51] (unknown [192.168.0.51])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id BFB2358BD9F;
	Thu, 23 Apr 2009 22:17:56 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <200904232119.36707.robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117380>

Robin Rosenberg wrote:
> torsdag 23 april 2009 14:32:46 skrev Alex Blewitt <alex@bandlem.com>:
>> Actually, that's pretty much exactly the format that Eclipse users  
>> will be expecting.
>>
>> CVS: Add to .cvsignore
>> SVN: Add to svn:ignore
>>
>> I suggest that we go with that style of format for the menu items, in  
>> order to achieve consistency with the way that the other team  
>> providers work.
> 
> Ouch, top posting....
> 
> Anyway, I agree  with Alex. My motivation is that there are more
> than one way to specify ignore. There's .gitignore, .git/info/excludedes
> and the Team ignore settings themselves. This option specifically
> messes with .gitignore. 
> 
while we're on the subject...
how about also adding the reverse: when a file is ignored then add it to
the .gitignore file for 'un-ignoring' (the '!' pattern)
