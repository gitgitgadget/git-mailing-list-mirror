From: Eric Wong <e@80x24.org>
Subject: Re: git svn clone cannot go beyond a specific rev on codeplex
Date: Fri, 13 May 2016 23:02:25 +0000
Message-ID: <20160513230225.GB17368@dcvr.yhbt.net>
References: <320381260.3220496.1463164131860.JavaMail.yahoo.ref@mail.yahoo.com>
 <320381260.3220496.1463164131860.JavaMail.yahoo@mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Hin-Tak Leung <htl10@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat May 14 01:02:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1M6J-0002GP-8H
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 01:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559AbcEMXC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 19:02:27 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:51275 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751208AbcEMXC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 19:02:26 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id F25DB20D5C;
	Fri, 13 May 2016 23:02:25 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <320381260.3220496.1463164131860.JavaMail.yahoo@mail.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294591>

Hin-Tak Leung <htl10@users.sourceforge.net> wrote:
> I suppose I could keep fetching to see if I can get past that rev one day :-(.

Maybe try and see if you can create a mirror using svnsync
and go from there?  Or see if you can get a closer machine to
test this on.

It could also be a bug in your particular version of svn, the
"svn diff" command I ran was using an ancient Debian wheezy,
SVN 1.6.17 (32-bit)
