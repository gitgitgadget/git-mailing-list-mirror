From: Eric Wong <e@80x24.org>
Subject: Re: `git help svn` missing description of `propset`
Date: Tue, 7 Jun 2016 20:08:28 +0000
Message-ID: <20160607200828.GA29701@dcvr.yhbt.net>
References: <2A4EC08B-3095-4063-BDF3-5B1CD1CEA2C3@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alfred Perlstein <alfred@freebsd.org>,
	David Fraser <davidf@sjsoft.com>
To: Joseph Pecoraro <pecoraro@apple.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 22:08:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bANIg-0003kx-RM
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 22:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422890AbcFGUIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 16:08:31 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55202 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162031AbcFGUI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 16:08:29 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id E65B41FF70;
	Tue,  7 Jun 2016 20:08:28 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <2A4EC08B-3095-4063-BDF3-5B1CD1CEA2C3@apple.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296714>

+Cc Alfred, David

Joseph Pecoraro <pecoraro@apple.com> wrote:
> `git help svn` does not mention `propset` but it does mention `proplist` and `propget`. This seems like an oversight.
> 
> 
>     $ git help svn
>     ...
>         proplist
>             Lists the properties stored in the Subversion repository about a given file or directory.
>             Use -r/--revision to refer to a specific Subversion revision.
>         
>         propget
>             Gets the Subversion property given as the first argument, for a file. A specific revision
>             can be specified with -r/--revision.
>     ...
> 
> 
> Interestingly, the generic `git svn` help does mention `propset`.
> 
> 
>     $ git svn
>     ...
>       propget          Print the value of a property on a file or directory
>                          --revision, -r <num>
>       proplist         List all properties of a file or directory
>                          --revision, -r <num>
>       propset          Set the value of a property on a file or directory - will be set on commit
>     ...
>   
> It seems Documentation/git-svn.txt is missing text for `propset`.

Thanks Joseph, indeed it is missing from the manpage.

Alfred / David: either of you have a few cycles to spare to write
a manpage entry for this feature you worked on?

If not, let us know, too, so others can work on it.  Thanks.
