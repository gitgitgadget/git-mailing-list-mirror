From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC 2/2] Automatically transform .git/{branches,remotes} into
 .git/config
Date: Mon, 21 Nov 2005 16:57:07 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511211653420.2569@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0511211455120.13775@wbgn013.biozentrum.uni-wuerzburg.de>
 <200511211644.16789.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 16:59:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeE2e-00053u-0L
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 16:57:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbVKUP5M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 10:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbVKUP5L
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 10:57:11 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:33217 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932339AbVKUP5K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 10:57:10 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 31C9B14047F; Mon, 21 Nov 2005 16:57:09 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9C7479F3AB; Mon, 21 Nov 2005 16:57:07 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8AA3B9F3A0; Mon, 21 Nov 2005 16:57:07 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7A93914051C; Mon, 21 Nov 2005 16:57:07 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200511211644.16789.Josef.Weidendorfer@gmx.de>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12451>

Hi,

On Mon, 21 Nov 2005, Josef Weidendorfer wrote:

> On Monday 21 November 2005 14:56, Johannes Schindelin wrote:
> > With this patch, git automatically extracts the information from 
> > .git/branches and .git/remotes, puts it into .git/config, and renames the 
> > directories to .git/branches.old and .git/remotes.old, respectively.
> 
> Please... don't trash .git/branches.
> This is about Cogito, not about Git. You will render every repository cloned
> with Cogito useless, as it expects a per-branch configuration with the same
> name as heads.
> 
> The part about .git/branches has to be sent to Pasky, not Junio. 

I was aware that .git/branches was introduced by Pasky, but as it is 
handled in git-parse-remote.sh, I thought that it may be a bit more 
general than just cogito.

Anyways, I sent this out as an *RFC*, but the "C" obviously stands for 
"Comments"...

What do people say? Is it useless to move that information into the 
config, where it can be queried/replaced/set/removed by the config "API", 
or should we continue with two incompatible ad-hoc formats? (If that 
sounds biased, it was not meant to be.)

Ciao,
Dscho
