From: Elrond <elrond+kernel.org@samba-tng.org>
Subject: Re: Compression speed for large files
Date: Mon, 3 Jul 2006 12:42:20 +0000 (UTC)
Message-ID: <loom.20060703T143544-407@post.gmane.org>
References: <loom.20060703T124601-969@post.gmane.org> <81b0412b0607030503p63b4ee31v7776bd155d3dab29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jul 03 14:43:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxNla-0004Lv-Cc
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 14:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbWGCMm5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 08:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbWGCMm5
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 08:42:57 -0400
Received: from main.gmane.org ([80.91.229.2]:38096 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750915AbWGCMm4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 08:42:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FxNlA-0004Gk-68
	for git@vger.kernel.org; Mon, 03 Jul 2006 14:42:40 +0200
Received: from p54A7107A.dip0.t-ipconnect.de ([84.167.16.122])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Jul 2006 14:42:40 +0200
Received: from elrond+kernel.org by p54A7107A.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Jul 2006 14:42:40 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 84.167.16.122 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4) Gecko/20060406 Firefox/1.5.0.4 (Debian-1.5.dfsg+1.5.0.4-1))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23173>

Joachim B Haga <cjhaga <at> fys.uio.no> writes:
[...]
>   method                 time (s)  object size (kB)
>   Z_BEST_COMPRESSION     62.0      17136
>   Z_DEFAULT_COMPRESSION  10.4      16536
>   Z_BEST_SPEED            4.8      17071
> 
> In this case Z_BEST_COMPRESSION also compresses worse,
[...]

I personally find that very interesting, is this a known "issue" with zlib?
It suggests, that with different options, it's possible to create smaller
repositories, despite the 'advertised' (by zlib, not git) "best" compression.


Alex Riesen <raa.lkml <at> gmail.com> writes:
[...]
> Probably yes, as a per-repo config option.

The option probably should be the size for which to start using
"default" compression.


    Elrond
