From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: parsecvs and unnamed branches
Date: Fri, 16 Jun 2006 18:39:29 -0400
Message-ID: <9e4733910606161539t2485e3b3xa9f2852a4d2fc18f@mail.gmail.com>
References: <9e4733910606161444i2f996096sbd1f9b3f3ff3a32d@mail.gmail.com>
	 <1150496362.6983.34.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 17 00:39:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrMyW-00041K-JG
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 00:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbWFPWja (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 18:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbWFPWja
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 18:39:30 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:25060 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751534AbWFPWj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jun 2006 18:39:29 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1252617nze
        for <git@vger.kernel.org>; Fri, 16 Jun 2006 15:39:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MQznAGJkXwwLo8QdfyU8tz3Va23Qgq9MABkV8foUJO1EmGDbV1AkTSXimflOBH1DA3LFxjGnuSF6K63SNmHqLEn6vj0L1fnTTK2Q2LF+nAN1dbJ/xLgba798VcosQQ19WdhYkjyEolVXgmp26P1cVYi3LyTJpqGPF4s83C1XhNI=
Received: by 10.37.13.63 with SMTP id q63mr1028160nzi;
        Fri, 16 Jun 2006 15:39:29 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Fri, 16 Jun 2006 15:39:29 -0700 (PDT)
To: "Keith Packard" <keithp@keithp.com>
In-Reply-To: <1150496362.6983.34.camel@neko.keithp.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21982>

On 6/16/06, Keith Packard <keithp@keithp.com> wrote:
> On Fri, 2006-06-16 at 17:44 -0400, Jon Smirl wrote:
> > I'm getting thousands of messages about unnamed branches and even
> > 'unnamed branch from master-UNNAMED-BRANCH'.
> >
> > How do you get unnamed branches into CVS, are these check-in errors or
> > are people actually working on unnamed branches? Or is parsecvs not
> > finding all of the branch info?
>
> branch names rely on a special 'branch tag' in the "symbols" section of
> the CVS file, but actual branches are flagged directly in the revision
> list. I don't know how it happens, but ,v files often end up with
> branches in the revision tree which haven't an associated tag. Go
> figure.
>
> For example, in the top level mozilla/Makefile.in,v file, you'll see a
> branch from version 1.36 with an initial commit 1.36.2.1. Using the
> wacky CVS branch revision numbering scheme, there should be an
> associated tag for version 1.36.0.2 (yes, the last two digits are
> flipped). But, none is present in the file.

There is a branch label for SeaMonkey_M8_BRANCH:1.36.0.4 that does
seems to correspond to anything. Could that be the missing tag?

>
> The reverse situation also occurs, with tags for branches that have no
> revisions in the file. This case makes sense -- until you make a change
> in a file along a branch, there will be no other record in the file of
> where the branch came from.
>
> I'd love to figure out a better mechanism for merging these nameless
> branches into the resulting repository, but I don't know how to
> correlate unnamed branches in one file with unnamed branches in other
> files.
>
> The current scheme of making up a fixed name and hoping that there
> aren't multiple unmamed branches from the same root is probably fraught
> with peril.
>
> --
> keith.packard@intel.com
>
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.3 (GNU/Linux)
>
> iD8DBQBEky5qQp8BWwlsTdMRAvI1AJ4nXKyzeupTDarXI+yM0zvuHaCoTQCdEBYC
> Kl7lEHIJgi5Tk24quc9FZyM=
> =FA7H
> -----END PGP SIGNATURE-----
>
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
