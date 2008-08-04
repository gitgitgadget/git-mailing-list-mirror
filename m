From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [ANNOUNCE] TopGit - A different patch queue manager
Date: Mon, 4 Aug 2008 15:22:51 +0200
Message-ID: <20080804132251.GA12255@diana.vm.bytemark.co.uk>
References: <20080803031424.GV32184@machine.or.cz> <9e4733910808030745j275eaffdib8a412fa95911bb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 15:01:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPzh4-00027f-T3
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 15:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161AbYHDNAp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Aug 2008 09:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753218AbYHDNAp
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 09:00:45 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4345 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739AbYHDNAo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 09:00:44 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KQ01T-0003Kz-00; Mon, 04 Aug 2008 14:22:51 +0100
Content-Disposition: inline
In-Reply-To: <9e4733910808030745j275eaffdib8a412fa95911bb3@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91347>

On 2008-08-03 10:45:06 -0400, Jon Smirl wrote:

> It is very helpful to block git commands that will mess up the state
> of topgit. For example 'git rebase' is a good way to mess up stgit.
> Instead you need to do 'stg rebase'. It is quite easy to type the
> wrong command when switching between trees and some are under stgit
> and others aren't.

Indeed. This is mitigated somewhat by the new "stg undo" command, but
it's still perhaps StGit's largest UI wart.

> I believe there is a stgit rewrite due any day now that completely
> changes how it deals with the index.

The master branch contains an infrastructure rewrite that makes it
easy to make the various commands handle the index nicely. A lot of
commands have been fixed to take advantage of it, but a bunch still
remain.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
