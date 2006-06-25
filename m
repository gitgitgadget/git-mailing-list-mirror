From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] git-grep: allow patterns starting with -
Date: Sun, 25 Jun 2006 18:18:52 +0200
Message-ID: <E1FuXK0-0001fy-1T@moooo.ath.cx>
References: <E1FuWh7-0008Ry-HX@moooo.ath.cx> <20060625184757.f8273820.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 18:19:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuXKI-0005SP-W5
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 18:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbWFYQS5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 12:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWFYQS5
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 12:18:57 -0400
Received: from moooo.ath.cx ([85.116.203.178]:4793 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1750894AbWFYQS4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jun 2006 12:18:56 -0400
To: Timo Hirvonen <tihirvon@gmail.com>
Mail-Followup-To: Timo Hirvonen <tihirvon@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060625184757.f8273820.tihirvon@gmail.com>
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22638>

> Matthias Lederhofer <matled@gmx.net> wrote:
> 
> > Signed-off-by: Matthias Lederhofer <matled@gmx.net>
> > ---
> > I did not find another way to use patterns starting with -, if it is
> > possible without the patch please tell me and ignore the patch :)
> > example:
> > % git grep -- --bla HEAD HEAD~1 -- --foo
> > HEAD:--foo/bla:test --bla foo
> 
> git grep -e --bla
Perhaps the original patch may be applied anyways for consistency with
the GNU grep? :)
But it's really not important to me and well, having -- twice in the
command line is a bit strange too.
