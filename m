From: Michael Dressel <MichaelTiloDressel@t-online.de>
Subject: Re: branch description
Date: Tue, 22 Apr 2008 19:57:36 +0200 (CEST)
Message-ID: <alpine.DEB.1.10.0804221945060.3452@pollux.milkiway.cos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 20:27:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoNCs-0008Jg-5F
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 20:27:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926AbYDVS0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 14:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753877AbYDVS0T
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 14:26:19 -0400
Received: from mailout11.t-online.de ([194.25.134.85]:42366 "EHLO
	mailout11.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154AbYDVS0S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 14:26:18 -0400
X-Greylist: delayed 1692 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Apr 2008 14:26:18 EDT
Received: from fwd25.aul.t-online.de 
	by mailout11.sul.t-online.de with smtp 
	id 1JoMkm-0004wl-00; Tue, 22 Apr 2008 19:58:04 +0200
Received: from pollux.local (ZqzupeZ1Zh-28gVbcPX+SBSAp5UdjidxGc8r2g3ykdifrb78hsGo5-xmE+CtAiUwwf@[84.163.244.200]) by fwd25.t-online.de
	with esmtp id 1JoMkP-1Q436W0; Tue, 22 Apr 2008 19:57:41 +0200
X-X-Sender: michael@pollux.milkiway.cos
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
X-ID: ZqzupeZ1Zh-28gVbcPX+SBSAp5UdjidxGc8r2g3ykdifrb78hsGo5-xmE+CtAiUwwf
X-TOI-MSGID: 39fd6399-904d-4892-a54e-631c4a382912
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80155>


On Friday 18 April 2008, Jakub Narebski wrote:
> Let me sum up here proposals where to put branch description:

what's the opinion of having a new branch object? Actually the tag object 
probably already does the job? This would spoil the elegant light weight 
current branch references. But tags are not that heavy.

In this approach the tags would not reference commits but tags. And tags 
have annotation. The difference to the normal tags would be that these 
tags are referenced from refs/heads/<branch> instead of refs/tags.

I have no clue how involved this change would become and if the benefit 
would justify the effort. I guess using proper objects for branches 
would only be justified if additional advantages could be achieved.

Cheers,
 	Michael
