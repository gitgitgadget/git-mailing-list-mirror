From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH stgit] revised patch for importing series from tarball
Date: Fri, 24 Oct 2008 03:17:08 +0200
Message-ID: <20081024011708.GA20369@diana.vm.bytemark.co.uk>
References: <20081019141613.05cbd93e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Clark Williams <clark.williams@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 24 03:18:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtBJv-0000cH-SL
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 03:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058AbYJXBRS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Oct 2008 21:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752435AbYJXBRR
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 21:17:17 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4899 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbYJXBRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 21:17:16 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KtBIa-0005W1-00; Fri, 24 Oct 2008 02:17:08 +0100
Content-Disposition: inline
In-Reply-To: <20081019141613.05cbd93e@gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98996>

On 2008-10-19 14:16:13 -0500, Clark Williams wrote:

> I added a simple test to the test harness for import as well.

Great!

> Oh and I added '*.elc' to the .gitignore file. May not be that many
> folks using emacs with stgit, but hey, I am! :)

Me too (but I have *.elc in my personal ignore file, so I never saw
it). However, this is an unrelated change, and we don't need to ignore
=2Eelc files at the top level, only in contrib. I've taken the liberty
of splitting this out to a separate commit and forging your signature
on it -- let me know if that's OK and I'll push it out.

> patch to allow importing a series from a tar archive

I turned this into a complete sentence, and removed "patch" since it's
entirely redundant.

> --- a/.gitignore
> +++ b/.gitignore
> @@ -6,3 +6,4 @@ patches-*
>  release.sh
>  setup.cfg.rpm
>  snapshot.sh
> +*.elc

As I said, I put this in a separate patch, and put that ignore pattern
in contrib.gitignore instead.

>             make_option('--commemail',
> -                       help =3D 'use COMMEMAIL as the committer e-ma=
il')
> +                       help =3D 'use COMMEMAIL as the committer e-ma=
il'),
>             ] + make_sign_options()

This is just a noise change _and_ didn't apply, so I dropped it.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
