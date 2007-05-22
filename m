From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] revert/cherry-pick: allow the last parameter to be -h
Date: Wed, 23 May 2007 00:11:56 +0200
Message-ID: <20070522221156.GL30871@steel.home>
References: <20070522212945.GA8002@diku.dk>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Wed May 23 00:12:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqcaJ-0007Xc-II
	for gcvg-git@gmane.org; Wed, 23 May 2007 00:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756516AbXEVWMA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 18:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759653AbXEVWMA
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 18:12:00 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:11873 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756433AbXEVWL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 18:11:59 -0400
Received: from tigra.home (Fc8ee.f.strato-dslnet.de [195.4.200.238])
	by post.webmailer.de (klopstock mo10) (RZmta 6.5)
	with ESMTP id 7046afj4MJH18u ; Wed, 23 May 2007 00:11:57 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 14EE7277BD;
	Wed, 23 May 2007 00:11:57 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 64BE2D195; Wed, 23 May 2007 00:11:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070522212945.GA8002@diku.dk>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWow37lQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48126>

Jonas Fonseca, Tue, May 22, 2007 23:29:45 +0200:
> +	if (!strcmp(arg, "-h"))
> +		usage(usage_str);

    $ git rev-list --usage
    usage: git-rev-list [OPTION] <commit-id>... [ -- paths... ]
      limiting output:
	--max-count=nr
	--max-age=epoch
    ...

Why should cherry-pick be different?
