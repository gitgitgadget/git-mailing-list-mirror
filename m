From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH] Add a git-completion rpm subpackage to the spec
Date: Sun, 21 Mar 2010 16:06:04 -0400
Message-ID: <1269199866-sup-8342@pinkfloyd.chass.utoronto.ca>
References: <1269045134-28072-1-git-send-email-icomfort@stanford.edu> <1269109086-8887-1-git-send-email-bwalton@artsci.utoronto.ca> <7v8w9mda6l.fsf@alter.siamese.dyndns.org> <1269119663-sup-5823@pinkfloyd.chass.utoronto.ca> <20100321155156.GH27676@inocybe.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 21 21:06:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtRPe-0004lP-JN
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 21:06:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753393Ab0CUUGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 16:06:12 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:55797 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613Ab0CUUGK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 16:06:10 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:54130 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1NtRPQ-0008EA-D2; Sun, 21 Mar 2010 16:06:04 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1NtRPQ-0005pv-C1; Sun, 21 Mar 2010 16:06:04 -0400
In-reply-to: <20100321155156.GH27676@inocybe.localdomain>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142855>

Excerpts from Todd Zullinger's message of Sun Mar 21 11:51:56 -0400 2010:

Hi Todd,

> The paths haven't changed currently, though I thought I read that
> eventually they'd like to move the default location for completion
> scripts to /usr/share/bash-completion/ (many are already installed
> there, but are symlinked to /etc/bash_completion.d by
> bash-completion packages (in the Fedora/EPEL packages via %triggers
> when the applications they complete are installed).

Should this be taken as:

* Eventually, /etc/bash_completion will source files directly from
  /usr/share/...
OR
* To play nice with the distros, triggers and symlinks are the way to
  go after installing to /usr/share/...?

> I also haven't made time to see what, if any, of the changes we've
> made in the Fedora packages might be worthwhile to integrate into
> the git.git rpm spec file. :/

I just took a look at the spec from 1.7.0.1-1 in rawhide.  Some of the
stuff it includes is Fedora/RHEL specific, but a few items that I
wouldn't mind seeing merged into the stock .spec file are the
splitting of the daemon package with the addition of an xinetd.d/git
file and the emacs support subpackage.

I also like the gitweb sub-package, but it doesn't meet the (site
specific) needs I have for deployment...In general, I think support in
the standard .spec for it is a good thing though.

> simple to source /etc/bash_completion.d/git.  In that light, is
> there a compelling reason not to install the completion by default?

Well, that's a good point.  I think my personal inclination for a
separate package comes from having it separated in OpenCSW.  Most of
the reasons for a separate package there likely don't apply here
though, so maybe it should be part of git-core?  As I said when I sent
the alternate (separate rpm) version, I'm happy with either solution
as long as the completion support is more easily available when I
build rpms in the future.

Thanks
-Ben
-- 
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
