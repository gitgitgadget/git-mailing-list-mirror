From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Get rid of .git/branches/ and .git/remotes/?
Date: Wed, 23 Nov 2005 18:22:22 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511231746140.9446@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
 <200511230005.12957.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.63.0511231549320.8191@wbgn013.biozentrum.uni-wuerzburg.de>
 <200511231639.59866.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 18:25:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeyKP-0008En-Fn
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 18:22:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbVKWRWZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 12:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbVKWRWZ
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 12:22:25 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:35266 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751259AbVKWRWY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 12:22:24 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4EE3313FD19; Wed, 23 Nov 2005 18:22:23 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2E176B52C6; Wed, 23 Nov 2005 18:22:23 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0819DB529A; Wed, 23 Nov 2005 18:22:23 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DE5D513FDB9; Wed, 23 Nov 2005 18:22:22 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200511231639.59866.Josef.Weidendorfer@gmx.de>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12639>

Hi,

On Wed, 23 Nov 2005, Josef Weidendorfer wrote:

>  [myporcelain]
>     headproperties.merge.candidates = blabla

With such a config file, git complains loudly. Key names are only allowed 
to be alphanumerical, and the first letter cannot even be a digit. No 
dots.

> This suggestion is about easier reading of config files; IMHO far easier
> with some use cases; but yes, it is arguable if it's worth an added
> complexity of config.c/config-set.c.

Well, I'll be glad to help the implementation of whatever we agree on.

Ciao,
Dscho
