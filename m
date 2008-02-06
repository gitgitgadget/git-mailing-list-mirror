From: Eric Wong <normalperson@yhbt.net>
Subject: Re: what does @NNN in git-svn branch names mean?
Date: Wed, 6 Feb 2008 11:18:30 -0800
Message-ID: <20080206191830.GA9654@hand.yhbt.net>
References: <20080206162905.GA29432@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 20:19:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMpnV-0007Bd-SH
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 20:19:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312AbYBFTSd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Feb 2008 14:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752301AbYBFTSc
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 14:18:32 -0500
Received: from hand.yhbt.net ([66.150.188.102]:38682 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752027AbYBFTSc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 14:18:32 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 01F092DC08B;
	Wed,  6 Feb 2008 11:18:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20080206162905.GA29432@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72828>

Karl Hasselstr=F6m <kha@treskal.com> wrote:
> What does it mean when git-svn creates branches with an @ sign and a
> Subversion revision number in them? The documentation doesn't say
> (and, this being perl, grepping for "@" in git-svn.perl is of little
> use!). I'll be happy to write something up if you'll clue me in.

Hi Karl,

The follow parent feature uses it, with the foo@NNN version being
the parent branch.

=46or example, if I'm tracking http://example.com/project/trunk, but it
was created from http://example.com/old-project at revision 76 (before
they used the trunk/branches/tags convention), then the contents of
http://example.com/old-project would show up as the ref trunk@75, and
the trunk ref would start as r76 with the ref trunk@75 as its parent.

--=20
Eric Wong
