From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Get rid of .git/branches/ and .git/remotes/?
Date: Tue, 22 Nov 2005 18:56:50 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511221854120.27872@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0511200935081.13959@g5.osdl.org> <200511210026.30280.Josef.Weidendorfer@gmx.de>
 <200511221831.03954.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 18:59:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EecOI-0006HB-0H
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 18:57:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbVKVR5J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 12:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbVKVR5J
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 12:57:09 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:48103 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965036AbVKVR4y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 12:56:54 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A26A113FFC9; Tue, 22 Nov 2005 18:56:51 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 61D7DB52BD; Tue, 22 Nov 2005 18:56:51 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 03327B52B6; Tue, 22 Nov 2005 18:56:51 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CC1DC13FF9E; Tue, 22 Nov 2005 18:56:50 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200511221831.03954.Josef.Weidendorfer@gmx.de>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12561>

Hi,

On Tue, 22 Nov 2005, Josef Weidendorfer wrote:

>   [remote:origin]
>     url = master.kernel.org:/pub/scm/git/git.git
>     pull = master:origin
> 
> For this, the parser could return
>     remote.url = master.kernel.org:/pub/scm/git/git.git for origin
>     remote.pull = master:origin for origin
> 
> By introducing such a scheme, multi-value vars would fit perfectly
> for use for .git/remotes or .git/branches.

I don't know if you missed it, but hierarchical config keys were 
introduced by b17e659dd4007cb1d3eb5ac32b524c0c5ab59601:

[remote.origin]
	url = master.kernel.org:/pub/scm/git/git.git
	pull = master:origin

is parsable by

	git-config-set --get remote.origin.url

now.

Hth,
Dscho
