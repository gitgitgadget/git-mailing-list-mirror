From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Get rid of .git/branches/ and .git/remotes/?
Date: Wed, 23 Nov 2005 15:53:02 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511231549320.8191@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
 <200511221831.03954.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.63.0511221854120.27872@wbgn013.biozentrum.uni-wuerzburg.de>
 <200511230005.12957.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 15:55:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eevzh-0005UU-35
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 15:53:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbVKWOxF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 09:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750875AbVKWOxF
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 09:53:05 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:39322 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750843AbVKWOxD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 09:53:03 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C8B3913FDAC; Wed, 23 Nov 2005 15:53:02 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A1AF59F3DB; Wed, 23 Nov 2005 15:53:02 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8D2BB9F3D2; Wed, 23 Nov 2005 15:53:02 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 68C1213FDC1; Wed, 23 Nov 2005 15:53:02 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200511230005.12957.Josef.Weidendorfer@gmx.de>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12631>

Hi,

On Wed, 23 Nov 2005, Josef Weidendorfer wrote:

> My suggestion complements hierarchical keys:
> 
>  [myporcelain.headproperties: my/head.name]
>     merge.candidates = my/other.head
>     merge.default = your/master
> 
> would be the same as
> 
>  [myporcelain.headproperties]
>     merge.candidates = my/other.head for my/head.name
>     merge.default = your/master for my/head.name

Okay. What about this config file?

-- snip --
	[myporcelain.headproperties: my/head.name]
		merge.candidates = my/other.head
	[myporcelain.headproperties]
		merge.candidates = blabla for my/head.name
-- snap --

I am not totally opposed to what you are trying, but I think it 
contradicts the KISS principle. (Note: the restriction that key names must
not start with a digit is also a contradiction to that.)

Ciao,
Dscho
