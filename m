From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] git.__remotes_from_dir() should only return lists
Date: Fri, 7 Sep 2007 01:11:19 +0200
Message-ID: <20070906231119.GB11829@diana.vm.bytemark.co.uk>
References: <20070905165722.17744.56584.stgit@dv.roinet.com> <20070906112645.GA31888@diana.vm.bytemark.co.uk> <1189082306.3695.5.camel@gx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 01:11:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITQVd-0001ka-5K
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 01:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932586AbXIFXLd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 6 Sep 2007 19:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbXIFXLc
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 19:11:32 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1943 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932525AbXIFXLb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 19:11:31 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1ITQVL-00038f-00; Fri, 07 Sep 2007 00:11:19 +0100
Content-Disposition: inline
In-Reply-To: <1189082306.3695.5.camel@gx>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57942>

On 2007-09-06 08:38:26 -0400, Pavel Roskin wrote:

> On Thu, 2007-09-06 at 13:26 +0200, Karl Hasselstr=F6m wrote:
>
> > Hmm. I don't believe I saw t1001 break without this patch (I run
> > the test suite before I push, but I might have made a mistake of
> > course). Does the user's environment leak into the test sandbox?
>
> I don't think it's the user environment, at least on my side. I'm
> using Fedora 7, which has python-2.5-12.fc7. That's the error from
> the t1001 before my patch:

Mmm, irritating. I really don't get the error, and debug printouts
confirm that it's because the directories .git/remotes and
=2Egit/branches both exist.

Your patch is the right thing to do anyway, obviously.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
