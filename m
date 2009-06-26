From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git svn: Support multiple branch and tag paths in the
	svn repository.
Date: Fri, 26 Jun 2009 13:57:38 -0700
Message-ID: <20090626205738.GB25118@dcvr.yhbt.net>
References: <4A3A4945.6050307@drmicha.warpmail.net> <1245335463-4488-1-git-send-email-git@drmicha.warpmail.net> <4A3F9A44.8070805@xiplink.com> <4A410A90.1090101@xiplink.com> <20090625093602.GA3997@dcvr.yhbt.net> <4A451F8A.9060501@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 22:57:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKIUc-0005QY-N4
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 22:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbZFZU5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 16:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752611AbZFZU5g
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 16:57:36 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48507 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751678AbZFZU5g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 16:57:36 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FE501F44D;
	Fri, 26 Jun 2009 20:57:38 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4A451F8A.9060501@xiplink.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122319>

Marc Branchaud <marcnarc@xiplink.com> wrote:
> Thanks a bunch, Eric!

No problem, thanks for adding this feature since people have wanted it
for a while now and I couldn't get a chance to deliver it.

> Can I assume that since you've taken the commit into your repo that
> the feature will find itself into Junio's git at some point?

Yes.

> I'll send out a documentation patch shortly.
>
> Is the svn_cmd wrapper simply a drop-in replacement for svn?  I can
> make that change, too.

Yes, it should be a simple substitution. Can you also start using
"(cd $FOO && stuff && more_stuff)" to chdir in subshells to avoid
having to keep track of "cd .."?  Thanks again!

-- 
Eric Wong
