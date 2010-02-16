From: Andreas Krey <a.krey@gmx.de>
Subject: Re: Git Submodule Usage Pattern
Date: Tue, 16 Feb 2010 21:00:35 +0100
Message-ID: <20100216200035.GA19834@inner.home.ulmdo.de>
References: <c115fd3c1002160639m113a3604wa6686bc613a7c202@mail.gmail.com> <32541b131002160948h317e71f5m2d2cb839470a38f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Visher <tim.visher@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 21:00:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhTbD-0001Yg-AX
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 21:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933252Ab0BPUAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 15:00:41 -0500
Received: from continuum.iocl.org ([213.146.114.200]:61421 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933228Ab0BPUAk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 15:00:40 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id o1GK0Zb20929;
	Tue, 16 Feb 2010 21:00:35 +0100
Content-Disposition: inline
In-Reply-To: <32541b131002160948h317e71f5m2d2cb839470a38f1@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140151>

On Tue, 16 Feb 2010 12:48:16 +0000, Avery Pennarun wrote:
...
> Three suggestions I can offer:
...
> 2) Try using relative repo paths (like ../foo.git) in .gitmodules.

Is that a 'try', or are those supposed to work?

4) Use

  [url "git@github.com:apk/"]
      insteadOf = "git://github.com/apk/"

in ~/.gitconfig allows changing the the actual url used. I use that
to be able to clone seemingly with the public github url but still
be able to push. You can use that to let an submodule point to
some other place where there is a clone of the submodule repo,
or another access method.

Andreas
