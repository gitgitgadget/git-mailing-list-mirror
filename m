From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] t9118 (git-svn): prevent early failure from taking
	down later tests
Date: Thu, 8 Jul 2010 20:59:56 +0000
Message-ID: <20100708205956.GA21961@dcvr.yhbt.net>
References: <4C352EB5.5020005@gmail.com> <20100708133602.GA1882@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: A Large Angry SCM <gitzilla@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Torsten Schmutzler <git-ts@theblacksun.eu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 23:00:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWyCU-0000kS-VS
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 23:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758628Ab0GHU76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 16:59:58 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:44088 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757167Ab0GHU75 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 16:59:57 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 343161F488;
	Thu,  8 Jul 2010 20:59:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20100708133602.GA1882@burratino>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150612>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> When test #2 fails, the cwd is project/, causing all the
> remaining tests in the same script to get confused and fail.
> 
> So in the spirit of v1.7.1.1~53^2~10 (t5550-http-fetch: Use subshell
> for repository operations, 2010-04-17), use a subshell for svn
> working copy operations.  This way, the cwd will reliably return
> to the top of the trash directory and later tests can still be run
> when a command has failed.
> 
> Reported-by: A Large Angry SCM <gitzilla@gmail.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---

Thanks.

Acked and pushed out to git://git.bogomips.org/git-svn
for Junio to pull:

Jonathan Nieder (1):
      t9118 (git-svn): prevent early failure from taking down later tests

Michael J Gruber (1):
      t9118: avoid PEG revision identifier in tests

-- 
Eric Wong
