From: Michael Dressel <MichaelTiloDressel@t-online.de>
Subject: Re: git-gc --prune interferes cogito?
Date: Wed, 17 Oct 2007 20:55:18 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0710172034270.4755@castor.milkiway.cos>
References: <1IiA7L-1AWmmW0@fwd35.aul.t-online.de> <20071017153841.GL18279@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Oct 17 20:55:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiE3d-00066j-Hj
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 20:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755133AbXJQSzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 14:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754600AbXJQSzn
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 14:55:43 -0400
Received: from mailout09.sul.t-online.de ([194.25.134.84]:49736 "EHLO
	mailout09.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753213AbXJQSzm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Oct 2007 14:55:42 -0400
Received: from fwd29.aul.t-online.de 
	by mailout09.sul.t-online.com with smtp 
	id 1IiE3R-0000ZN-00; Wed, 17 Oct 2007 20:55:41 +0200
Received: from [192.168.2.100] (XRy5DQZZYhZe09XHNgahLY5C9V04XO0TMX+osMWSpX4L0kzN6GMuKtHhTcNQcimwAk@[84.163.211.177]) by fwd29.t-online.de
	with esmtp id 1IiE38-1mz9rE0; Wed, 17 Oct 2007 20:55:22 +0200
X-X-Sender: michael@castor.milkiway.cos
In-Reply-To: <20071017153841.GL18279@machine.or.cz>
X-ID: XRy5DQZZYhZe09XHNgahLY5C9V04XO0TMX+osMWSpX4L0kzN6GMuKtHhTcNQcimwAk
X-TOI-MSGID: d96ee1f1-c918-4c6f-838d-2ce497e62e20
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61408>

Hi,


On Wed, 17 Oct 2007, Petr Baudis wrote:

>   Hi,
> 
> On Wed, Oct 17, 2007 at 04:43:27PM +0200, MichaelTiloDressel@t-online.de wrote:
> > I'm using git-1.5.3.2 and cogito-0.18.1.
> > 
> > After I did a git-gc --prune cg-status didn't show my branches anymore.
> > git-branch -a still showed the branches.
> > I think that git-gc removed all files from .git/refs/heads/ except for
> > origin. Git seams to be fine with the branches in 
> >  .git/logs/refs/heads/. 
> > 
> > So should git-gc not be used together with cogito?
> 
>   Cogito doesn't support packed heads - I guess setting gc.packrefs to
> false should fix the issue. Cogito should support packed tags, I guess;
> I don't know if there's a way to make git-gc pack only tags.
> 

Thank you. I tried it at home too where I had an older version of git. 
With the older git version git-gc --prune didn't disturbe cogito.
I upgradet to git version 1.5.3.4 and tried gc.packrefs=false and it 
seams to be ok forr cogito.

Cheers,
Michael
