From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn dcommit losing/detaching head when commit message empty
Date: Sat, 26 Feb 2011 18:50:39 -0800
Message-ID: <20110227025039.GB26643@dcvr.yhbt.net>
References: <AANLkTi=A-UG2aOcwwNbjoBK4pYDtKp=0nFmcwrgVv0f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Hin-Tak Leung <hintak.leung@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 03:50:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtWim-0005tN-ES
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 03:50:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383Ab1B0Cul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Feb 2011 21:50:41 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:50064 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751351Ab1B0Cuk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 21:50:40 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 246271F89E;
	Sun, 27 Feb 2011 02:50:40 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <AANLkTi=A-UG2aOcwwNbjoBK4pYDtKp=0nFmcwrgVv0f8@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168006>

Hin-Tak Leung <hintak.leung@gmail.com> wrote:
> Hi,
> 
> I have just encountered a small problem with git-svn dcommit, which
> while not fatal, were quite worrying as
> it resulted in a detached head(?) for a while. This is with
> git-1.7.4-1.fc14.x86_64 .

This is a known issue for a while that nobody's had time to get around
to fixing just yet.  I think setting aside a temporary branch should
work...

> Hope this helps. BTW, git-svn is a great tool, and thanks a lot for
> that - I wouldn't use anything else (including the "authentic" svn
> client) to interact with svn repositories these days.

Thanks for the encouragement.  I hardly need git svn nowadays so I
need all the encouragement I can get to set aside time for it from
other projects :)

-- 
Eric Wong
