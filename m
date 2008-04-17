From: David Kastrup <dak@gnu.org>
Subject: Re: Problem with tar while installing git
Date: Thu, 17 Apr 2008 13:52:22 +0200
Message-ID: <864pa0u2a1.fsf@lola.quinscape.zz>
References: <4c610e240804170435p7a628e4bo84c92f4eb4bb7a34@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: hepaminondas@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 17 13:53:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmSg8-0000sz-RI
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 13:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752452AbYDQLwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 07:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752552AbYDQLwk
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 07:52:40 -0400
Received: from main.gmane.org ([80.91.229.2]:46440 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751625AbYDQLwj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 07:52:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JmSfL-0002Io-HH
	for git@vger.kernel.org; Thu, 17 Apr 2008 11:52:35 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Apr 2008 11:52:35 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Apr 2008 11:52:35 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:FROvmwgXojn3ZH9C63cAKLuMkFQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79789>

"Miguel Vaz" <hepaminondas@gmail.com> writes:

> I've already googled around to see if this is a known issue, but found
> nothing.

Try again.

git "this does not look like a tar archive"

as keywords into Google spit out wagonloads of relevant reports.

>    When installing git, after
>
>    ./configure --prefix=$HOME/local
>    make
>    make install

[...]

> (cd blt && tar cf - .) | \
> (cd '/home/mvaz/local/share/git-core/templates/' && umask 022 && tar xf -)
> tar: This does not look like a tar archive

To cut the search short: don't export CDPATH in your interactive shell
startup scripts.  It is a really bad idea.

-- 
David Kastrup
