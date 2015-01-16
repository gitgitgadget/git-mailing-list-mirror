From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PULL] git-svn updates from Ramkumar
Date: Fri, 16 Jan 2015 00:08:02 +0000
Message-ID: <20150116000802.GA8616@dcvr.yhbt.net>
References: <20150115090703.GA12333@dcvr.yhbt.net>
 <xmqqr3uv7u7v.fsf@gitster.dls.corp.google.com>
 <20150115224652.GA25482@dcvr.yhbt.net>
 <xmqqtwzr4ofo.fsf@gitster.dls.corp.google.com>
 <CALkWK0kHQ-qhD3p0_VEhVrbD39yV=F5t2nQZ4D6RKP_gpg9tKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 16 01:08:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBuSP-000713-6L
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 01:08:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600AbbAPAIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 19:08:04 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:45556 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752054AbbAPAIE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 19:08:04 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE8CE1F453;
	Fri, 16 Jan 2015 00:08:02 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CALkWK0kHQ-qhD3p0_VEhVrbD39yV=F5t2nQZ4D6RKP_gpg9tKA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262530>

Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Junio C Hamano wrote:
> > To which a natural reaction was "Can the existing breakage
> > demonstrated by a test?".
> 
> There's a lot to do, if we really want to dig deeper.
> 
> The second git-svn-basic test onwards doesn't pass for me, so I really
> can't do much in the way of contributing tests until that's fixed.
> 
> Couldn't open a repository: Unable to connect to a repository at URL
> 'file:///Users/artagnon/src/git/t/trash%20directory.t9100-git-svn-basic/svnrepo':
> Unable to open an ra_local session to URL: Unable to open repository
> 'file:///Users/artagnon/src/git/t/trash%20directory.t9100-git-svn-basic/svnrepo':
> Expected FS format between '1' and '4'; found format '6' at
> /Users/artagnon/src/git/perl/blib/lib/Git/SVN.pm line 148.

I haven't seen this before.  Which SVN Perl binding version are you
using?  Perhaps your "svnadmin" tool is from a different SVN version
or installation of SVN than your Perl bindings?
