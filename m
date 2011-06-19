From: Dave Abrahams <dave@boostpro.com>
Subject: Re: git svn fetch error
Date: Sun, 19 Jun 2011 15:57:34 +0000 (UTC)
Message-ID: <loom.20110619T175544-191@post.gmane.org>
References: <3504B354-D3F2-4419-B2EC-E14F83EC0371@apple.com> <4DDA17D7.8020504@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 19 17:57:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYKNp-0001fU-TF
	for gcvg-git-2@lo.gmane.org; Sun, 19 Jun 2011 17:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173Ab1FSP5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 11:57:53 -0400
Received: from lo.gmane.org ([80.91.229.12]:39248 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754147Ab1FSP5w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 11:57:52 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QYKNi-0001bt-RG
	for git@vger.kernel.org; Sun, 19 Jun 2011 17:57:50 +0200
Received: from 207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com ([207.172.223.249])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 17:57:50 +0200
Received: from dave by 207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 17:57:50 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 207.172.223.249 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_7; en-us) AppleWebKit/533.21.1 (KHTML, like Gecko) Version/5.0.5 Safari/533.21.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176025>

Michael Haggerty <mhagger <at> alum.mit.edu> writes:

> On 05/23/2011 01:39 AM, Dave Zarzycki wrote:
> > Has anybody seen the following error with git svn fetch?
> > I've seen this both with 1.7.4.4 and top-of-tree.
> > 
> > Argument "195270*" isn't numeric in numeric le (<=) at 
> > /usr/libexec/git-core/git-svn line 3840.

<snip>
 
> I haven't looked into the code, but from the argument shown in the error
> message my guess is that git-svn is being confused by Subversion's
> non-inheritable merge information.  [1].
> 
> [1] http://www.collab.net/community/subversion/articles/merge-info.html

I"m seeing this problem too.  What do I need to do to get this treated as a
bug report?

Thanks,
--
Dave Abrahams
BoostPro Computing
http://boostpro.com
