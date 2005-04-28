From: Dan Holmsand <holmsand@gmail.com>
Subject: Re: Cogito nit: cg-update should default to "origin".
Date: Thu, 28 Apr 2005 03:52:22 +0200
Message-ID: <d4pfac$koj$1@sea.gmane.org>
References: <20050426214338.32e9ac27.akpm@osdl.org> <20050427235115.GN22956@pasky.ji.cz> <42702F20.3050200@dwheeler.com> <20050428005337.GA3422@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Apr 28 03:48:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQy8M-0006Xk-RW
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 03:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVD1BxV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 21:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbVD1BxV
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 21:53:21 -0400
Received: from main.gmane.org ([80.91.229.2]:62094 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261706AbVD1Bw5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 21:52:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DQy7c-0006UH-WD
	for git@vger.kernel.org; Thu, 28 Apr 2005 03:47:21 +0200
Received: from 217-211-177-12-o871.telia.com ([217.211.177.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Apr 2005 03:47:20 +0200
Received: from holmsand by 217-211-177-12-o871.telia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Apr 2005 03:47:20 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 217-211-177-12-o871.telia.com
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
In-Reply-To: <20050428005337.GA3422@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:
> Actually, I wasn't too happy with the current update-to-HEAD special
> case. Sure, it's similar to SVN, but SVN's concepts are totally
> different here, and this special case wart (which does really do
> something entirely different than normal cg-update) is one of the
> Cogito-related shadows in my mind. What about moving this special case
> to something like
> 
> 	cg-restore
> 
> and changing the defaulting of update and pull back to 'origin'? I think
> people do this cg-update without arguments so seldom that changing this
> now shouldn't hurt much, right?

How about making the restore thing a special case of cg-cancel instead? 
"Restore deleted files", and "restore deleted and modified files and 
unseek" are similar enough that people will now where to look. Something 
like "cg-cancel -C" (for careful), that only restores deleted files 
would do it, I think.

/dan

