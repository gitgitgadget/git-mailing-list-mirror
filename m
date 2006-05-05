From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] Git wiki
Date: Fri, 05 May 2006 20:27:40 +0200
Organization: At home
Message-ID: <e3g5em$q0f$1@sea.gmane.org>
References: <20060505005659.9092.qmail@science.horizon.com> <20060505181540.GB27689@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri May 05 20:28:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fc52A-0002aO-4v
	for gcvg-git@gmane.org; Fri, 05 May 2006 20:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWEES2H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 14:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWEES2H
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 14:28:07 -0400
Received: from main.gmane.org ([80.91.229.2]:31713 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751206AbWEES2F (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 May 2006 14:28:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Fc51v-0002VF-5K
	for git@vger.kernel.org; Fri, 05 May 2006 20:27:55 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 May 2006 20:27:55 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 May 2006 20:27:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19623>

Petr Baudis wrote:

> The automatic vs. explicit movement tracking is a lot more
> controversial. Explicit movement tracking is pretty easy to provide for
> file-level movements, it's just that the user says "I _did_ move file
> A to file B" (I never got the Linus' argument that the user has no idea
> - he just _performed_ the move, also explicitly, by calling *mv).
> 
> However, I guess the explicit movement tracking completely fails if you
> go sub-file (without being extremely bothersome for the user) - you
> would have to have control over the editor and the clipboard and even
> then I'm not sure if you could reach any sensible results.

If I remember correctly there are some problems if the explicit file-level
contents movement tracking (aka. file rename tracking) is done via
equivalent of file-id, inodes, or persistent names. Although it works for
many (most?) cases.

-- 
Jakub Narebski
Warsaw, Poland
