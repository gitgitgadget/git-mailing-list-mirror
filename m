From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: Re: how to git with google code
Date: Fri, 26 Nov 2010 16:21:01 +0100
Message-ID: <20101126162101.6586215d@jk.gs>
References: <AANLkTi=5muNrriBoU0ZGnMqQUOjrJAvwLfyYO07-Ad3m@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bond <jamesbond.2k.g@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:26:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0Bh-0004RO-DT
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222Ab0KZP0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 10:26:07 -0500
Received: from zoidberg.org ([88.198.6.61]:49215 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753583Ab0KZP0G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:26:06 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Nov 2010 10:26:06 EST
Received: from jk.gs (xdsl-89-0-38-85.netcologne.de [::ffff:89.0.38.85])
  (AUTH: LOGIN jast, SSL: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Fri, 26 Nov 2010 16:21:03 +0100
  id 004001C0.4CEFD05F.00000CFF
In-Reply-To: <AANLkTi=5muNrriBoU0ZGnMqQUOjrJAvwLfyYO07-Ad3m@mail.gmail.com>
X-Mailer: Claws Mail 3.7.7 (GTK+ 2.22.0; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162215>

--- Bond <jamesbond.2k.g@gmail.com> wrote:

> I am not clear with how do I host my code to git.

Google Code's project hosting does not officially support git. About the
only thing you can do is to actually host a Subversion repository there
and then access that via git-svn. However, that deprives you of many of
the big advantages of git, such as useful merging and lightning-fast
cloning (compared to Subversion via git-svn, anyway).

I would recommend that you look for a different hosting site. Other
sites offering free git hosting for open source projects include
Sourceforge, github, gitorious and repo.or.cz. Some of these provide
you with instructions on how to push your code to them. In any case,
I think you could benefit from reading a git tutorial or two.

Also, might I recommend that you create one repository per separate
project you want to get hosted. It's bad organization to keep several
projects in the same repository, and it's likely to bite you in the
behind eventually.

HTH,
Jan
