From: Michael Dressel <MichaelTiloDressel@t-online.de>
Subject: Re: [PATCH 2/2] allow '%d' pretty format specifier to show
 decoration
Date: Wed, 20 Aug 2008 21:51:18 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0808202138340.4070@pollux>
References: <20080820175325.GD27773@sigill.intra.peff.net> <20080820180034.GB32005@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 20 21:53:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVtjm-0008Fm-5R
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 21:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754267AbYHTTvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 15:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753767AbYHTTvy
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 15:51:54 -0400
Received: from mailout05.t-online.de ([194.25.134.82]:40790 "EHLO
	mailout05.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753380AbYHTTvx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 15:51:53 -0400
Received: from fwd30.aul.t-online.de 
	by mailout05.sul.t-online.de with smtp 
	id 1KVtiW-0006SC-04; Wed, 20 Aug 2008 21:51:40 +0200
Received: from [192.168.2.100] (Sx2N7+ZQghOwMRYtU76-KKeCQROvg9V+UsM8QYquupkXc-6PqTgquZ3vu2Y6MNPZCv@[84.163.212.83]) by fwd30.t-online.de
	with esmtp id 1KVtiC-1qWrw00; Wed, 20 Aug 2008 21:51:20 +0200
X-X-Sender: michael@pollux
In-Reply-To: <20080820180034.GB32005@sigill.intra.peff.net>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
X-ID: Sx2N7+ZQghOwMRYtU76-KKeCQROvg9V+UsM8QYquupkXc-6PqTgquZ3vu2Y6MNPZCv
X-TOI-MSGID: 3f26e033-cd94-43a1-945a-ac3f680f3a06
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93022>


On Wed, 20 Aug 2008, Jeff King wrote:

> Previously, specifying
>
>  git log --pretty=format:'%H %s' --decorate
>
> would calculate decorations, but not show them. You can now
> do:
>
>  git log --pretty=format:'%H (%d) %s' --decorate
>
> to see them.
>

Wow that was fast! Thanks for the help.


For those who care:
I use it in a script to extract the log title of commits between certain
tags. And to compile a simple log history of what has changed between
tags. It was a bit more tricky than I initially thought it would be,
because of merges. So what I do basically is to do a git log A..B
where A and B are two of the tags I found using --decorate. My problem
was that my script got confused when I had braces in the log title. That was
why I wanted to use format in the first place. I know there is a web
interface to git which probably does all that, but I wanted to compile an as 
simple as possible text file.

Cheers,
Michael
