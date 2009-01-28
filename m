From: Stephen Bannasch <stephen.bannasch@deanbrook.org>
Subject: Re: Bad objects error since upgrading GitHub servers to 1.6.1
Date: Tue, 27 Jan 2009 22:52:42 -0500
Message-ID: <p06240812c5a58676a1e2@[63.138.152.192]>
References: <alpine.DEB.1.00.0901280034310.3586@pacific.mpi-cbg.de> <20090127233939.GD1321@spearce.org>
 <7v1vuo1f6d.fsf@gitster.siamese.dyndns.org> <bab6a2ab0901271634x7201130bx4a565bd8bea6967b@mail.gmail.com>
 <7vvds0z1c1.fsf@gitster.siamese.dyndns.org> <7vk58gz04l.fsf@gitster.siamese.dyndns.org>
 <7vfxj4yzjj.fsf@gitster.siamese.dyndns.org> <bab6a2ab0901271757i4602774ahef1d881b7ed58097@mail.gmail.com>
 <20090128020220.GE1321@spearce.org> <7v3af4yvmu.fsf@gitster.siamese.dyndns.org> <20090128033020.GF1321@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 04:54:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS1VJ-0004rQ-Ni
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 04:54:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253AbZA1Dww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 22:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752229AbZA1Dww
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 22:52:52 -0500
Received: from deanbrook.org ([72.52.70.192]:60358 "HELO deanbrook.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752194AbZA1Dww (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 22:52:52 -0500
Received: from ::ffff:71.161.144.33 ([71.161.144.33]) by deanbrook.org for <git@vger.kernel.org>; Tue, 27 Jan 2009 19:52:49 -0800
In-Reply-To: <20090128033020.GF1321@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107465>

At 7:30 PM -0800 1/27/09, Shawn O. Pearce wrote:
>PJ - the short story here is, to forever work around these buggy
>1.6.1 clients, you'd have to either run an old server forever,
>or forever run a patched server that disables the newer ".have"
>extension in the advertised data written by git-upload-pack.
>There just isn't a way to hide this from the client.
>
>Really though, I'd recommend getting your users to upgrade to a
>non-buggy client.  Pasky has the same problem on repo.or.cz; if
>he doesn't have it already he will soon when he upgrades...

Do you know if this problem is fixed in tag v1.6.1.1?

   Tagger: Junio C Hamano <gitster@pobox.com>
   Date:   Sun Jan 25 12:41:48 2009 -0800
   commit 5c415311f743ccb11a50f350ff1c385778f049d6
