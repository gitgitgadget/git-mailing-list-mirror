From: Stefan =?utf-8?b?TsOkd2U=?= <stefan.naewe@googlemail.com>
Subject: Re: [tig] compilation error: undefined reference to =?utf-8?b?YHNldF90YWJzaXplJw==?=
Date: Mon, 20 Sep 2010 18:36:03 +0000 (UTC)
Message-ID: <loom.20100920T203217-346@post.gmane.org>
References: <20100920174200.GA13017@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 20:40:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxlHn-0007Fd-Gd
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 20:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754560Ab0ITSkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 14:40:10 -0400
Received: from lo.gmane.org ([80.91.229.12]:34847 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750778Ab0ITSkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 14:40:09 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OxlHY-000781-1C
	for git@vger.kernel.org; Mon, 20 Sep 2010 20:40:04 +0200
Received: from dslc-082-083-192-154.pools.arcor-ip.net ([82.83.192.154])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 20:40:04 +0200
Received: from stefan.naewe by dslc-082-083-192-154.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 20:40:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 82.83.192.154 (Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/534.3 (KHTML, like Gecko) Chrome/6.0.472.62 Safari/534.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156648>

Nicolas Sebrecht <nicolas.s.dev <at> gmx.fr> writes:

> 
> Hi,
> 
> tig don't compile anymore here:
> 
>   % make
>   gcc   tig.o  -lncursesw  -o tig
>   tig.o: In function `init_display': tig.c:7113: undefined reference to 
`set_tabsize'
>   collect2: ld returned 1 exit status
>   make: *** [tig] Error 1
>   %
> 
> and bisected on
> 
> commit f1fe753be71ef3ce5abcbb16c2a359f97e5c7e7d
> Author: Stefan Naewe <>
> Date:   Sun Sep 12 11:03:52 2010 +0200
> 
>     Use function set_tabsize()
> 
>     this fixes the following compile error on cygwin:
>     tig.c: In function `init_display':
>     tig.c:7112: error: invalid lvalue in assignment

That change works for me on Cygwin, Ubuntu 10.04, Debian 5.0.6


Maybe you should say something about your system/OS version ?

Regards,

Stefan
