From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] add option to import series directly from a tar archive
Date: Mon, 8 Sep 2008 23:22:57 +0200
Message-ID: <20080908212257.GA9924@diana.vm.bytemark.co.uk>
References: <48C34EC7.9040102@gmail.com> <20080908180317.GA6123@diana.vm.bytemark.co.uk> <48C56AD9.6040007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Clark Williams <clark.williams@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 23:02:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcns3-00069V-I3
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 23:02:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753976AbYIHVA4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Sep 2008 17:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753972AbYIHVAz
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 17:00:55 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1545 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753890AbYIHVAz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 17:00:55 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KcoCH-0003L7-00; Mon, 08 Sep 2008 22:22:57 +0100
Content-Disposition: inline
In-Reply-To: <48C56AD9.6040007@gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95301>

On 2008-09-08 13:11:37 -0500, Clark Williams wrote:

> Patch series tarballs are quite common from people who use quilt
> (e.g. many of the kernel -rt series developers).

Ah.

> My biggest problem (now that I can directly import them) is to see
> if I can ease StGit's patch import rules a bit, since quilt accepts
> pretty much anything as long as there's a diff in there somewhere. I
> bomb out regularly importing the -rt series using StGit, because
> some people don't put complete email addresses in their patches.

Yes, that would be a welcome addition.

> As to the test, I'll get right on that...:)

Swell!

> Karl Hasselstr=F6m wrote:
>
> > By the way, is the separator always '/' in tarfile? Or should you
> > use os.sep? (There is also os.pardir which you could use instead
> > of '..', but that might be overdoing it a little ...)
>
> I doubt there are many Windows-generated tarballs out there (except
> for the Cygwin case; I believe they use '/'), but I shouldn't be so
> Unix-centric. I'll work on cleaning it up.

Well, it's no big deal, really. Just thought I'd mention it.

> I did consider adding Zipfile support as well, but didn't get a very
> good match-up between tar functionality and zip functionality. Maybe
> later...

I had a quick look at the zipfile module, and it looks like it too
could easily be wrapped in a small class like I suggested in point
(1).

> I did consider pulling directly from the tarball. I'll look into it.

Just don't let my suggestions take all the fun out of contributing ...
only do it my way if you really think it's better.

> > On 2008-09-06 22:47:19 -0500, Clark Williams wrote:
> >
> > > +    # cleanup the tmpdir
> > > +    os.system('rm -rf %s' % tmpdir)
> >
> > Aaah! My eyes! My _eyes_!!!!!
> >
> > Seriously, though, you'd want to use something like shutil.rmtree
> > here.
>
> Man, I could not for the life of me remember which module had that
> in it. To be fair I wasn't up at work with my Python Essential
> Reference, which would have pointed me directly at it, but I would
> have thought I could have gotten there through the Python docs.
> Sigh...
>
> You can dock my StGit pay for the visit to the eye doctor :)

:-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
