From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: recent patch breaks the build ?
Date: Thu, 17 Nov 2005 13:00:19 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511171258440.2104@wbgn013.biozentrum.uni-wuerzburg.de>
References: <437B6997.8010903@mc.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 13:03:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EciRT-0007ln-F2
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 13:00:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbVKQMAW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 07:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbVKQMAW
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 07:00:22 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:4283 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750764AbVKQMAV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 07:00:21 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8ADB013FB2B; Thu, 17 Nov 2005 13:00:20 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6FDA69F33C; Thu, 17 Nov 2005 13:00:20 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 374EA98FA6; Thu, 17 Nov 2005 13:00:20 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B348713FB2F; Thu, 17 Nov 2005 13:00:19 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Andrew Wozniak <awozniak@mc.com>
In-Reply-To: <437B6997.8010903@mc.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12106>

Hi,

On Wed, 16 Nov 2005, Andrew Wozniak wrote:

> It appears that a recent patch "Fix for multiple alternates requests in 
> http" references curlm without the necessary #ifdef USE_CURL_MULTI

Note that I had no success making http-fetch work without USE_CURL_MULTI. 
So maybe you can compile it, but maybe you experience the same problems as 
I had.

Hth,
Dscho
