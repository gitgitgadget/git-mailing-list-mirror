From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Re: specify charset for commits (Was: [PATCH] Fix documentation copy&paste typo)
Date: Thu, 21 Dec 2006 16:23:13 +0600
Message-ID: <200612211623.14236.litvinov2004@gmail.com>
References: <11655782712452-git-send-email-zeisberg@informatik.uni-freiburg.de> <20061221085907.GA2244@cepheus> <Pine.LNX.4.63.0612211050450.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
	<zeisberg@informatik.uni-freiburg.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 11:23:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxL5D-00064r-LJ
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 11:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422933AbWLUKXY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 05:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422940AbWLUKXY
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 05:23:24 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:1322 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422933AbWLUKXX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 05:23:23 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2577042uga
        for <git@vger.kernel.org>; Thu, 21 Dec 2006 02:23:22 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WpoSULC3yhZyIDmkUm+wgHQqDozyD2cWIy2hhnayfy4MwRjsDGE7kkG2hLutV9ck4v4eV6JU4Xg5itG7baNWa7UXJ/PNCAIzEERt749HbKMMUA3ZkHPQETCBN5XvMT0ZZ7xmzpbPHT7rZrA7M7t3unLjL/mI690g20T6Wxj+Bc4=
Received: by 10.78.183.15 with SMTP id g15mr342274huf.1166696601474;
        Thu, 21 Dec 2006 02:23:21 -0800 (PST)
Received: from lan.ac-sw.lcl ( [81.1.223.2])
        by mx.google.com with ESMTP id 38sm12409648hua.2006.12.21.02.23.19;
        Thu, 21 Dec 2006 02:23:20 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.63.0612211050450.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35047>

> > What do you think about a patch that makes git-commit-tree call iconv on
> > its input to get it to UTF-8 (or any other charset).
>
> We had this discussion over and over again. Last time (I think) was here:
> http://article.gmane.org/gmane.comp.version-control.git/11710
> Summary: we do not want to force the use of utf8.

May we can add new header into commit with commit text encoding ?
