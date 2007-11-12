From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 0/5] A few small fixes
Date: Mon, 12 Nov 2007 14:01:21 +0100
Message-ID: <20071112130121.GA30459@diana.vm.bytemark.co.uk>
References: <20071111193545.18868.62490.stgit@yoghurt> <b0943d9e0711120302y385676a9o2d5ad50ee3ae2333@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 14:01:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrYvB-0005pG-MQ
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 14:01:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758303AbXKLNBa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Nov 2007 08:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752944AbXKLNBa
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 08:01:30 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1372 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758246AbXKLNBa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 08:01:30 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IrYun-0007ze-00; Mon, 12 Nov 2007 13:01:21 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0711120302y385676a9o2d5ad50ee3ae2333@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64615>

On 2007-11-12 11:02:54 +0000, Catalin Marinas wrote:

> My plan after 0.14 is to remove the implementation of add/rm etc.
> commands.

There are patches for this in kha/experimental. :-) They are on top of
David's conflict representation series, and I think there might be a
reason for that. But it was quite a while ago ...

On top of David's series, "stg resolved" should also be superfluous --
I just haven't gotten around to removing it yet.

> I'd like to keep them as just synonyms to the equivalent git
> commands which stgit would invoke (this is mainly for convenience as
> I usually type "stg" rather than "git").

OK, I can live with that. But I'd like them to be well hidden, so the
apparent command set doesn't become too large.

> BTW, I'll review this week the bugs already logged and clean as many
> as possible (help appreciated :-))

I think there might be a fair number of bugs that are still open in
the bug tracker even though they are fixed.

> and try to release 0.14 in 1-2 weeks.

All right!

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
