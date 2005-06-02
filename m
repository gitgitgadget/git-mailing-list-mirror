From: Dan Holmsand <holmsand@gmail.com>
Subject: Re: Problem with cogito and Linux tree tags
Date: Thu, 02 Jun 2005 21:48:00 +0200
Message-ID: <429F6270.50009@gmail.com>
References: <429F5FA5.2030306@gorzow.mm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jun 02 21:51:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ddvi9-0004VP-9j
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 21:50:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVFBTxC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 15:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVFBTxC
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 15:53:02 -0400
Received: from main.gmane.org ([80.91.229.2]:58241 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261301AbVFBTwr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2005 15:52:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DdveW-0003ys-7g
	for git@vger.kernel.org; Thu, 02 Jun 2005 21:46:52 +0200
Received: from h65n2fls35o265.telia.com ([217.211.115.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Jun 2005 21:46:52 +0200
Received: from holmsand by h65n2fls35o265.telia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Jun 2005 21:46:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: h65n2fls35o265.telia.com
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
In-Reply-To: <429F5FA5.2030306@gorzow.mm.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Radoslaw Szkodzinski wrote:
  The v2.6.12-rc5 tag hash isn't a tree or commit hash, it is unusable.
> I don't know what causes that...

It's a tag object. If you cg-pull via http, you won't get any of those, 
though.

Try rsync instead:

$ cg-branch-add kernel 
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
$ cg-pull kernel

/dan

