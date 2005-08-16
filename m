From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Patches exchange is bad?
Date: Tue, 16 Aug 2005 22:39:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508162238400.19656@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <20050816200132.88287.qmail@web26304.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 22:41:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E58Dq-0003jE-1L
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 22:39:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbVHPUjn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 16:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbVHPUjn
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 16:39:43 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:2001 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932422AbVHPUjm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 16:39:42 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B21D0E1022; Tue, 16 Aug 2005 22:39:41 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9A1A499BEF; Tue, 16 Aug 2005 22:39:41 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6DC1C99B94; Tue, 16 Aug 2005 22:39:41 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 46CCCE1022; Tue, 16 Aug 2005 22:39:41 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Marco Costalba <mcostalba@yahoo.it>
In-Reply-To: <20050816200132.88287.qmail@web26304.mail.ukl.yahoo.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 16 Aug 2005, Marco Costalba wrote:

> Suppose a possible scenario involves using a couple of git archives, one 
> for releases and stable code, say MAIN, and one for experimental stuff  
> or new development, say HEAD.
> 
> Suppose there is stuff in HEAD you don't want merged in MAIN, more,
> you need to update MAIN with only a subset of patches in HEAD, peraphs 
> in different order. Or simply, you are not interested to see the history 
> of the HEAD tree when looking MAIN. All this points could keep you 
> from merging.

This looks like a good description of cherry picking. See StGIT (and to a 
certain extent, git-cherry) for that.

Ciao,
Dscho
