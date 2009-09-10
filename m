From: Karl Wiberg <kha@treskal.com>
Subject: Re: [StGit PATCH] Add import -p option
Date: Thu, 10 Sep 2009 10:24:36 +0200
Message-ID: <20090910082436.GA1388@diana.vm.bytemark.co.uk>
References: <b0943d9e0909081443g47978cb7mee241d74dc52adf7@mail.gmail.com> <20090908223714.GA6364@diana.vm.bytemark.co.uk> <b0943d9e0909091509i16b556f0x9dd3aa6788054298@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Gustav =?iso-8859-1?Q?H=E5llberg?= <gustav@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 10:25:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mlexj-0006cK-AN
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 10:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754432AbZIJIYx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Sep 2009 04:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754154AbZIJIYx
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 04:24:53 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:43501 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048AbZIJIYx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 04:24:53 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1MlexI-0000eB-00; Thu, 10 Sep 2009 09:24:36 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0909091509i16b556f0x9dd3aa6788054298@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128100>

On 2009-09-09 23:09:51 +0100, Catalin Marinas wrote:

> 2009/9/8 Karl Wiberg <kha@treskal.com>:
>
> > On 2009-09-08 22:43:39 +0100, Catalin Marinas wrote:
> >
> > > + =A0 =A0if strip:
> > > + =A0 =A0 =A0 =A0cmd +=3D ['-p', strip]
> >
> > This test should probably be "if strip !=3D None". It doesn't
> > _really_ matter, technically, since -p0 is the default, but still
> > ...
>
> I modified it after posting the patch. The git default is -p1, so we
> would miss the -p0 case.

Ah ha! Sometimes it actually does pay to be pedantic ...

--=20
Karl Wiberg, kha@treskal.com
    www.treskal.com/kalle
