From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Newbie question:  equiv of:  cvs co -p <filename>  ?
Date: Wed, 10 Aug 2005 00:10:02 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508100009210.10311@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <ddb8vl$ifq$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 10 00:10:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2cIX-0006Xq-Dj
	for gcvg-git@gmane.org; Wed, 10 Aug 2005 00:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbVHIWKH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Aug 2005 18:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbVHIWKG
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Aug 2005 18:10:06 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:46211 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964995AbVHIWKF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2005 18:10:05 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 95E63E325A; Wed, 10 Aug 2005 00:10:04 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7B8BB9CC78; Wed, 10 Aug 2005 00:10:04 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 67B4B99334; Wed, 10 Aug 2005 00:10:04 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1D493E325A; Wed, 10 Aug 2005 00:10:02 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: John Ellson <ellson@research.att.com>
In-Reply-To: <ddb8vl$ifq$1@sea.gmane.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 9 Aug 2005, John Ellson wrote:

> How can we cat the latest committed state of a file to stdout?
> 
> I hacked this:
> 
> 	#!/bin/bash
> 	ID=`git-ls-files -s | grep $1 | cut -d ' ' -f 2`

and now:

	git-cat-file blob $ID

Voila,
Dscho
