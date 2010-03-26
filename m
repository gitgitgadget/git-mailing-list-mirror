From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: What's cooking in git.git (Mar 2010, #06; Wed, 24)
Date: Thu, 25 Mar 2010 22:19:14 -0400
Message-ID: <1269569690-sup-4884@pinkfloyd.chass.utoronto.ca>
References: <7v7hp1kzbn.fsf@alter.siamese.dyndns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 26 03:19:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nuz8u-00051E-Ck
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 03:19:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555Ab0CZCTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 22:19:16 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:41618 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832Ab0CZCTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 22:19:16 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:36664 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1Nuz8k-0000bj-5k
	for git@vger.kernel.org; Thu, 25 Mar 2010 22:19:14 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Nuz8k-0005nw-4v
	for git@vger.kernel.org; Thu, 25 Mar 2010 22:19:14 -0400
In-reply-to: <7v7hp1kzbn.fsf@alter.siamese.dyndns.org>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143205>

Excerpts from Junio C Hamano's message of Wed Mar 24 20:41:16 -0400 2010:

> * bw/git-completion-rpmspec (2010-03-20) 1 commit
>  - Add a git-completion rpm subpackage to the spec
> 
> Shipping bash-completion as part of RPM package; since Todd
> Zullinger who packages git for Fedora joined the thread, I am hoping
> that I can defer the direction of the final version to the
> discussion between Todd and Ben.

I think Todd made a good case for making this part of the core git
rpm.  Ian's patch would be more suited for inclusion in this case.
The remaining question is whether to stick it in
/etc/bash_completion.d or in /usr/share/bash_completion.d (the
triggers vs direct bit).

The closer the core spec file is to the one that distro's use, the
better.  This is a reciprocal benefit, I think.

I'm still interested in Todd's (and anyone else') thoughts about
adding the git-daemon, etc, sub-packages as part of the stock spec
file.  Are they too distro specific for inclusion?  (eg: which user
should run git-daemon[1]?  default repo/cgi location for gitweb?)

Thanks
-Ben

[1] The fedora spec sees git-daemon run as 'nobody' but imho, this isn't
    a good choice.  A separate 'git' user would be my preference.
-- 
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
