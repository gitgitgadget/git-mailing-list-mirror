From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: kha/safe and kha/experimental updated
Date: Wed, 19 Dec 2007 18:14:34 +0100
Message-ID: <20071219171434.GA10652@diana.vm.bytemark.co.uk>
References: <20071214105238.18066.23281.stgit@krank> <200712191144.59747.jnareb@gmail.com> <20071219114021.GB5565@diana.vm.bytemark.co.uk> <200712191723.29591.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 18:15:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J52Vh-0005Sy-NV
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 18:15:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960AbXLSROp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 12:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbXLSROp
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 12:14:45 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2416 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822AbXLSROo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 12:14:44 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1J52V8-0002rm-00; Wed, 19 Dec 2007 17:14:34 +0000
Content-Disposition: inline
In-Reply-To: <200712191723.29591.jnareb@gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68922>

On 2007-12-19 17:23:27 +0100, Jakub Narebski wrote:

> Karl Hasselstr=F6m wrote:
>
> >   git checkout-index --stage=3D1|2|3 <filename>
> >
> > does what you want. But "git cat-file" knows this handy syntax for
> > getting at particular index stages:
> >
> >   :stage:<filename>
>
> I always forget which stage is which. It would be nice if
> git-checkout-index implemented human-friendly names, just like
> git-diff-files has --base, --ours, --theirs, i.e. if it would be
> possible to write
>
>   git checkout-index --stage=3Dbase|ours|theirs <filename>
>
> and perhaps even
>
>   :base|ours|theirs:<filename>.
>
> (but there is a problem with files containing ':'...).

<ref>:<path> is already accepted, so I don't think this would be much
worse.

And yes, I agree that the base/ours/theirs aliases are nice, and
should be accepted by at least the porcelain commands.

> > Yes, that's what I want. You and others like what "stg resolved"
> > does, but I don't want it in StGit because it's a generic git
> > enhancement that has nothing to with patch stacks. People who
> > don't use StGit would presumably like it as well.
>
> You mean adding another option to git-add, similar to '-u' option,
> but updating only the files which were (are) in merge conflict;
> '-c'/'-r'/'-s' perhaps?

Yes. That _is_ the operation you want, isn't it?

> This would be replacement for "stg resolved --all", wouldn't it (and
> with filename replacement for "stg resolved <filename>", of course)?

Yes. Though with a filename argument, you wouldn't need the new flag.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
