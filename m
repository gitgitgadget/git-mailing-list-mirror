From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH - stgit] Patch to allow import of compressed files
Date: Tue, 10 Jun 2008 12:28:00 +0200
Message-ID: <20080610102800.GB30119@diana.vm.bytemark.co.uk>
References: <484D78BF.6030504@gmail.com> <20080610063328.GB26965@diana.vm.bytemark.co.uk> <alpine.DEB.1.10.0806092335420.17180@swallowtail> <bd6139dc0806100107y415a292eqe22af7a7b2215e65@mail.gmail.com> <20080610095349.GA30119@diana.vm.bytemark.co.uk> <bd6139dc0806100257k4700d364occ08457279e8a735@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Asheesh Laroia <asheesh@asheesh.org>,
	Clark Williams <clark.williams@gmail.com>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Tue Jun 10 12:29:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6168-0005Yy-DT
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 12:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbYFJK2K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2008 06:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbYFJK2K
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 06:28:10 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3029 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbYFJK2J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 06:28:09 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K6156-0007yM-00; Tue, 10 Jun 2008 11:28:00 +0100
Content-Disposition: inline
In-Reply-To: <bd6139dc0806100257k4700d364occ08457279e8a735@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84492>

On 2008-06-10 11:57:05 +0200, Sverre Rabbelier wrote:

> On Tue, Jun 10, 2008 at 11:53 AM, Karl Hasselstr=F6m <kha@treskal.com=
> wrote:
>
> > A tar file would presumably contain more than one patch -- it'd be
> > more like a directory of patches than a single patch file.
>
> Why?
> $ tar czvf mypatch.patch.tar.gz mypatch.patch

If there's just one patch in the tar file, why did you use a tar file
in the first place instead of just gzipping?

I'm pretty sure that anyone who really has use for the tar-file
capability would be using tar files with multiple patches in them.

> > I'm not saying it wouldn't be nice to support it, but it's not
> > what the original poster needed, and building it would be a bunch
> > of extra work.
>
> A bunch of extra work?
> http://docs.python.org/lib/module-tarfile.html I say it'd be about
> as much work as the original patch ;).

I was refering to the fact that due to tar-files in the general case
containing more than one patch, you'd have to modify the parts of
imprt.py that deal with importing multiple patches at once, in
addition to the parts the current patch touches.

But you're probably right that the amount of additional work would not
be much more than what went into the current patch.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
