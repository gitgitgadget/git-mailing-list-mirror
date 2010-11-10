From: Camille Moncelier <moncelier@devlife.org>
Subject: Re: Understanding git cherry-pick
Date: Wed, 10 Nov 2010 20:43:23 +0100
Message-ID: <20101110204323.0b675331@cortex>
References: <10192863.654644.1289397257054.JavaMail.root@mail.hq.genarts.com>
	<28509694.654669.1289397869374.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 10 20:44:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGGaa-0004LL-DN
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 20:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756764Ab0KJTnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 14:43:47 -0500
Received: from lo.gmane.org ([80.91.229.12]:41620 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756758Ab0KJTnq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 14:43:46 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PGGa8-00046t-Eh
	for git@vger.kernel.org; Wed, 10 Nov 2010 20:43:44 +0100
Received: from mal35-3-82-240-201-90.fbx.proxad.net ([82.240.201.90])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Nov 2010 20:43:44 +0100
Received: from moncelier by mal35-3-82-240-201-90.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Nov 2010 20:43:44 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: mal35-3-82-240-201-90.fbx.proxad.net
In-Reply-To: <28509694.654669.1289397869374.JavaMail.root@mail.hq.genarts.com>
X-Newsreader: Claws Mail 3.7.6cvs62 (GTK+ 2.22.0; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161175>

On Wed, 10 Nov 2010 09:04:29 -0500 (EST)
Stephen Bash <bash@genarts.com> wrote:

> git status reported the actual change we wanted from the commit
> applied cleanly; the conflicts were all added/deleted files between
> the two branches.  The commit only modifies a single file, and the
> file exists with the same name on both branches.
> 
> So what's actually going on here?  If the one changed file in the
> commit merged cleanly, why did the automatic cherry-pick fail?  Why
> does cherry-pick even care about file differences between the two
> branches that aren't modified by the commit in question?  Or is it
> user error?

Which  version are you using ? I had problem using anything < 1.7.3
when the cherry-pick happened between two branches where some files
changed theirs types eg: a link become a file (But not the other way
around)

See:
http://thread.gmane.org/gmane.comp.version-control.git/160717/focus=160717
> 
> Thanks,
> Stephen


--
Camille Moncelier
http://devlife.org
