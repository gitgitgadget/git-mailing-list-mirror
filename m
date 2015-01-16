From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PULL] git-svn updates from Ramkumar
Date: Fri, 16 Jan 2015 00:39:31 +0000
Message-ID: <20150116003931.GA28184@dcvr.yhbt.net>
References: <20150115090703.GA12333@dcvr.yhbt.net>
 <xmqqr3uv7u7v.fsf@gitster.dls.corp.google.com>
 <20150115224652.GA25482@dcvr.yhbt.net>
 <xmqqtwzr4ofo.fsf@gitster.dls.corp.google.com>
 <CALkWK0kHQ-qhD3p0_VEhVrbD39yV=F5t2nQZ4D6RKP_gpg9tKA@mail.gmail.com>
 <20150116000802.GA8616@dcvr.yhbt.net>
 <CALkWK0kFngxd2uwHjAtov+9rUbo13OOoeAhmvbxxsz39hmMnaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 16 01:39:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBuwr-0005zE-E5
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 01:39:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271AbbAPAjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 19:39:33 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:45745 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752579AbbAPAjc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 19:39:32 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 030141F453;
	Fri, 16 Jan 2015 00:39:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CALkWK0kFngxd2uwHjAtov+9rUbo13OOoeAhmvbxxsz39hmMnaw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262533>

Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Eric Wong wrote:
> > I haven't seen this before.  Which SVN Perl binding version are you
> > using?  Perhaps your "svnadmin" tool is from a different SVN version
> > or installation of SVN than your Perl bindings?
> 
> I have two installations of Subversion: the system one is at
> /Library/Developer/CommandLineTools @ version 1.7.17, and the brew
> installed one is at /usr/local @ version 1.8.10. When I build git from
> scratch, it links to the dated SVN bindings for some reason. I suspect
> I have to tweak $PERL5LIB?

Adding it to GITPERLLIB should work...

> Can we patch git-svn to link to the Right one on OS X?

You should be able to set up everything in the Makefile, that has
special cases for Fink and Darwin ports, at least.  Somebody who knows
OS X packaging systems might have better advice.
