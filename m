From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] git-svn: fix dcommit clobbering upstream when committing multiple changes
Date: Sat, 1 Sep 2007 12:24:53 +0200
Message-ID: <20070901102453.GA10030@diana.vm.bytemark.co.uk>
References: <Pine.LNX.4.64.0708312200480.28586@racer.site> <20070831221814.GB31033@untitled> <Pine.LNX.4.64.0709010017250.28586@racer.site> <20070831234854.GA6451@mimvista.com> <20070901002501.GA11591@mimvista.com> <20070901011612.GA3407@untitled> <20070901054321.GA8021@diana.vm.bytemark.co.uk> <20070901093303.GA9867@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Sep 01 12:25:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRQAP-0001bw-2Y
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 12:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486AbXIAKZV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 1 Sep 2007 06:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752494AbXIAKZV
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 06:25:21 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1536 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324AbXIAKZU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2007 06:25:20 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IRQ9t-0002bt-00; Sat, 01 Sep 2007 11:24:53 +0100
Content-Disposition: inline
In-Reply-To: <20070901093303.GA9867@soma>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57267>

On 2007-09-01 02:33:03 -0700, Eric Wong wrote:

> Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > Shouldn't it be a simple matter of checking if the total diff over
> > the whole series would conflict with the SVN HEAD?
>
> I don't think you can actually check for SVN conflicts until
> attempting to do commit.

Ah, that's true. I was only considering the git side ...

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
