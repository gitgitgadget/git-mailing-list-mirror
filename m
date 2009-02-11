From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Add mergetool support to the classic StGit infrastructure
Date: Wed, 11 Feb 2009 10:27:41 +0100
Message-ID: <20090211092741.GE26136@diana.vm.bytemark.co.uk>
References: <20090210141413.28782.19243.stgit@pc1117.cambridge.arm.com> <20090211092513.GD26136@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 10:29:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXBP5-0002xT-1Q
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 10:29:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754479AbZBKJ1o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Feb 2009 04:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754447AbZBKJ1n
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 04:27:43 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:33365 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754137AbZBKJ1n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 04:27:43 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1LXBNd-00075n-00; Wed, 11 Feb 2009 09:27:41 +0000
Content-Disposition: inline
In-Reply-To: <20090211092513.GD26136@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109391>

On 2009-02-11 10:25:13 +0100, Karl Hasselstr=F6m wrote:

> On 2009-02-10 14:14:17 +0000, Catalin Marinas wrote:
>
> > @@ -754,7 +758,6 @@ def resolved(filenames, reset =3D None):
> >               '--stdin', '-z').input_nulterm(filenames).no_output()
> >      GRun('update-index', '--add', '--').xargs(filenames)
> >      for filename in filenames:
> > -        gitmergeonefile.clean_up(filename)
> >          # update the access and modificatied times
> >          os.utime(filename, None)
>
> Hmm, what does this line do, and why isn't it needed anymore? I
> don't know this part of StGit, I'm just curious ...

Oh, right, it removes the .current/.patched/.ancestor files.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
