From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Add a new lstat and fstat implementation based on Win32 API
Date: Tue, 04 Sep 2007 17:05:02 +0200
Message-ID: <86myw2eajl.fsf@lola.quinscape.zz>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com> <46DBBC1E.4010407@eudaptics.com> <46DBFA2A.7050003@trolltech.com> <Pine.LNX.4.64.0709031428080.28586@racer.site> <46DC5ED4.8050202@trolltech.com> <46DD0C16.70101@eudaptics.com> <Pine.LNX.4.64.0709041145230.28586@racer.site> <46DD433A.5040604@eudaptics.com> <46DD473A.8010602@trolltech.com> <46DD63F5.5050002@trolltech.com> <Pine.LNX.4.64.0709041529191.28586@racer.site> <46DD6F2B.3060001@trolltech.com> <Pine.LNX.4.64.0709041547240.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 04 17:10:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISa2j-00073X-KT
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 17:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498AbXIDPKM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 11:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754250AbXIDPKL
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 11:10:11 -0400
Received: from main.gmane.org ([80.91.229.2]:59661 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754321AbXIDPKK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 11:10:10 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1ISa2U-0003iF-Rd
	for git@vger.kernel.org; Tue, 04 Sep 2007 17:10:02 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Sep 2007 17:10:02 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Sep 2007 17:10:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:cA/lg4EUPndCGTGysUmZdobPoLc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57594>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 4 Sep 2007, Marius Storm-Olsen wrote:
>
>> The problem is that without this patch fstat(0, buf) would fail
>> with bad filedescriptor instead of returning the st_mode = S_IFIFO.
>
> I guessed as much, but could not fetch the patch, since fetch was broken 
> ;-)
>
> For some utterly strange reason, "git fetch" accessed "git-fetch" in
> the cwd, not in /bin/...  Funny.

Regardless of what you write in your PATH variable, Windows will
_always_ search for binaries first in your current work directory.  It
is not really funny.

-- 
David Kastrup
