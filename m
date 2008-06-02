From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Fix path duplication in git svn commit-diff
Date: Mon, 2 Jun 2008 13:53:03 +0200
Message-ID: <20080602115303.GA27924@diana.vm.bytemark.co.uk>
References: <20080517150330.31899.12398.stgit@yoghurt> <20080601094840.GB16064@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jun 02 13:54:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K38cL-0001yt-Ln
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 13:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759801AbYFBLxb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Jun 2008 07:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760005AbYFBLxb
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 07:53:31 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4993 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756355AbYFBLxb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 07:53:31 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K38b1-0007HJ-00; Mon, 02 Jun 2008 12:53:03 +0100
Content-Disposition: inline
In-Reply-To: <20080601094840.GB16064@hand.yhbt.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83516>

On 2008-06-01 02:48:40 -0700, Eric Wong wrote:

> Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > I really don't have a clue as to why this was broken, but the
> > patch fixes the problem for me, and doesn't break the tests. I got
> > the idea from dcommit, which is setting svn_path to ''
> > unconditionally.
>
> Hardly anybody uses commit-diff directly :)
>
> It was a low-level plumbing command that I used to implement the
> original version of dcommit in.

Yes. I was looking into how to call git-svn from StGit, and dcommit is
a bit too smart to be easily scriptable.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
