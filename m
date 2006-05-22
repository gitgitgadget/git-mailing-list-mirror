From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: irc usage..
Date: Mon, 22 May 2006 19:51:42 +0200
Organization: At home
Message-ID: <e4stna$o1g$1@sea.gmane.org>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org> <446F95A2.6040909@gentoo.org> <Pine.LNX.4.64.0605201543260.3649@g5.osdl.org> <446FA262.7080900@gentoo.org> <Pine.LNX.4.64.0605211209080.3649@g5.osdl.org> <Pine.LNX.4.64.0605212053590.3697@g5.osdl.org> <44713BE4.9040505@gentoo.org> <Pine.LNX.4.64.0605212132570.3697@g5.osdl.org> <46a038f90605220042v369e9ff5o3dc7841472171d02@mail.gmail.com> <Pine.LNX.4.64.0605220203200.3697@g5.osdl.org> <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com> <Pine.LNX.4.64.0605221013020.3697@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon May 22 19:52:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiEZu-0005YF-Ct
	for gcvg-git@gmane.org; Mon, 22 May 2006 19:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWEVRwR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 13:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWEVRwR
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 13:52:17 -0400
Received: from main.gmane.org ([80.91.229.2]:11452 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751093AbWEVRwQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 13:52:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FiEZN-0005Mg-WE
	for git@vger.kernel.org; Mon, 22 May 2006 19:51:54 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 May 2006 19:51:53 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 May 2006 19:51:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20516>

Linus Torvalds wrote:

>                       git repack -a
>                       #
>                       # Stupid sleep to make sure that nobody is still
>                       # using any unpacked objects after the pack got
>                       # generated
>                       #
>                       sleep 10
>                       git prune-packed

Is it really necessary (on Linux at least)? Git boast it's atomicity...

-- 
Jakub Narebski
Warsaw, Poland
