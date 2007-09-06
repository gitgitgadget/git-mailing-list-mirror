From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] git.__remotes_from_dir() should only return lists
Date: Thu, 6 Sep 2007 16:26:49 +0200
Message-ID: <20070906142649.GA2406@diana.vm.bytemark.co.uk>
References: <20070905165722.17744.56584.stgit@dv.roinet.com> <20070906112645.GA31888@diana.vm.bytemark.co.uk> <1189082306.3695.5.camel@gx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 16:27:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITIK0-00030Z-V7
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 16:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018AbXIFO1A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 6 Sep 2007 10:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbXIFO1A
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 10:27:00 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3570 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844AbXIFO07 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 10:26:59 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1ITIJl-0000eO-00; Thu, 06 Sep 2007 15:26:49 +0100
Content-Disposition: inline
In-Reply-To: <1189082306.3695.5.camel@gx>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57883>

On 2007-09-06 08:38:26 -0400, Pavel Roskin wrote:

> On Thu, 2007-09-06 at 13:26 +0200, Karl Hasselstr=F6m wrote:
>
> > Thanks. But I guess an even nicer fix would be to make this
> > function return a set in the first place.
>
> Fine with me. But it was returning a list or None, so the simplest
> fix was to return a list in all cases.

Oh, your fix is excellent to fix the immediate problem. I was just
trying to say that making this function (an a heap of others) return
sets would be a useful refactoring.

> > Hmm. I don't believe I saw t1001 break without this patch (I run
> > the test suite before I push, but I might have made a mistake of
> > course). Does the user's environment leak into the test sandbox?
>
> I don't think it's the user environment, at least on my side. I'm
> using Fedora 7, which has python-2.5-12.fc7. That's the error from
> the t1001 before my patch:

OK. I'll try to reproduce it when I get home, but it certainly looks
like I only _thought_ I'd run the test suite.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
