From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH GSoC 2/3] git-instaweb: Configure it to work with a
	global server root and projects list
Date: Tue, 18 May 2010 15:54:45 -0700
Message-ID: <20100518225445.GA15414@dcvr.yhbt.net>
References: <1273953520-25990-1-git-send-email-pavan.sss1991@gmail.com> <1273953520-25990-2-git-send-email-pavan.sss1991@gmail.com> <m3ljbhcp46.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 19 00:54:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEVga-0001fR-BF
	for gcvg-git-2@lo.gmane.org; Wed, 19 May 2010 00:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423Ab0ERWyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 May 2010 18:54:46 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:56004 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751400Ab0ERWyq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 May 2010 18:54:46 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA5BF1F509;
	Tue, 18 May 2010 22:54:45 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <m3ljbhcp46.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147312>

Jakub Narebski <jnareb@gmail.com> wrote:
> Second, in my opinion it is not a good change at all.  Currently you
> can run "git instaweb" when inside git repository, and get a web
> browser (or a new tab in existing session of a running web browser)
> with current repository in it, to browse its history.  It is similar
> to running gitk (or other graphical history browser, like qgit, tig,
> etc.), or running "git log", but with web interface.
> 
> Now, current git-instaweb behavior has its quirks, but having
> git-instaweb show _current_ repository is a very important feature,
> and I'd rather we didn't lose it in transition.

I agree completely with Jakub here.  My original inspiration for
instaweb was being able to make local commits, fire up instaweb in my
working directory, and then to get a non-git-using cow-orker on my LAN
to review some changes before I pushed them upstream.

I'm no longer in a situation with non-git-using cow-orkers anymore, but
I suspect many folks still are.

-- 
Eric Wong
