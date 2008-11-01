From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: Git/Mercurial interoperability (and what about bzr?)
Date: Sat, 01 Nov 2008 09:06:21 +0100
Message-ID: <87ljw3zx8i.fsf@mid.deneb.enyo.de>
References: <ge0rla$mce$1@ger.gmane.org> <ge70nl$l6t$1@ger.gmane.org>
	<alpine.DEB.1.00.0810281445190.22125@pacific.mpi-cbg.de.mpi-cbg.de>
	<Pine.LNX.4.64.0810281536360.27029@ds9.cixit.se>
	<E026EBDF-F402-49AB-A7A8-0A0EFB513907@ai.rug.nl>
	<20081028191234.GS24201@genesis.frugalware.org>
	<20081028213144.GC10862@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 01 09:30:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwBsR-0007X8-Et
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 09:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbYKAIZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 04:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbYKAIZf
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 04:25:35 -0400
Received: from mail.enyo.de ([212.9.189.167]:44843 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750826AbYKAIZe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 04:25:34 -0400
X-Greylist: delayed 1151 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 Nov 2008 04:25:34 EDT
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1KwBUz-0001fW-CT
	for git@vger.kernel.org; Sat, 01 Nov 2008 09:06:21 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.69)
	(envelope-from <fw@deneb.enyo.de>)
	id 1KwBUz-0002Fl-1e
	for git@vger.kernel.org; Sat, 01 Nov 2008 09:06:21 +0100
In-Reply-To: <20081028213144.GC10862@mit.edu> (Theodore Tso's message of "Tue,
	28 Oct 2008 17:31:44 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99722>

* Theodore Tso:

> In the past I've looked at the possibility of creating a
> bi-directional, incremental gateway between hg and git repositories.
> The main thing which makes this difficult is that hg stores tags
> in-band inside the change-controlled .hgtags file.  This means that if
> you cut a release, tag it, and then create a commit to further modify
> the repository, the new commit is descended from the tag commit,
> whereas in git, the tag is a "bookmark" --- perhaps signed via GPG,
> but not part of the revision history.

Couldn't you just keep the .hgtags file and have everyone interested
in the tags use special scripts?

(Admittedly, I'm horribly totally by Git's behavior in this area.  I
haven't figured out yet under what circumstances tags are pushed and
pulled, so I'm not totally opposed to the Mercurial model. 8-/)
