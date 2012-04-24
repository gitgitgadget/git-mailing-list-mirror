From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 0/3] git-svn: fixes for intermittent SIGPIPE
Date: Tue, 24 Apr 2012 09:45:41 +0000
Message-ID: <20120424094541.GA30803@dcvr.yhbt.net>
References: <cover.1335250396.git.rkagan@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Roman Kagan <rkagan@mail.ru>
X-From: git-owner@vger.kernel.org Tue Apr 24 11:45:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMcJm-0006oE-Er
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 11:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756550Ab2DXJpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 05:45:43 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40596 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753831Ab2DXJpm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 05:45:42 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DB3C1F5B9;
	Tue, 24 Apr 2012 09:45:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <cover.1335250396.git.rkagan@mail.ru>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196217>

Roman Kagan <rkagan@mail.ru> wrote:
> This is the third version of the series; compared to the previous submission
> the log message of the first patch was reworded to make it more palatable.
> 
> Roman Kagan (3):
>   git-svn: use POSIX::sigprocmask to block signals
>   git-svn: ignore SIGPIPE
>   git-svn: drop redundant blocking of SIGPIPE

Thanks for this series, acked and pushed to git://bogomips.org/git-svn
