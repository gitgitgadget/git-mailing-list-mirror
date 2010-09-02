From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: Re: getting git to ignore modifications to specific files
Date: Thu, 2 Sep 2010 11:25:31 +0200
Message-ID: <20100902112531.160b09bd@jk.gs>
References: <4C7EA1FF.8030307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 11:25:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Or63F-000338-C6
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 11:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753055Ab0IBJZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 05:25:36 -0400
Received: from zoidberg.org ([88.198.6.61]:38336 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751350Ab0IBJZg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 05:25:36 -0400
Received: from jk.gs (p508A3FE7.dip.t-dialin.net [::ffff:80.138.63.231])
  (AUTH: LOGIN jast, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Thu, 02 Sep 2010 11:25:33 +0200
  id 00400410.4C7F6D8E.00006066
In-Reply-To: <4C7EA1FF.8030307@gmail.com>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155119>

Chris Packham <judge.packham@gmail.com> wrote:

> I did a bit of googling and found
>   git update-index --assume-unchanged
> 
> Which works locally to stop git status from complaining.

Be careful with that, as it's technically meant to be used for another
purpose (e.g. slow filesystems). Notably, git reset --hard will still
kill your local modifications. In your case it seems to be about
automatically generated files so it's no big problem, but it might
still cause a bit of confusion, so I thought I'd warn you anyway.

-Jan
