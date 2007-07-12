From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Volume of commits
Date: Thu, 12 Jul 2007 15:49:58 +0200
Message-ID: <20070712134958.GA28310@diana.vm.bytemark.co.uk>
References: <m3ps2xu5hc.fsf@pc7.dolda2000.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Fredrik Tolf <fredrik@dolda2000.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 15:50:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8z3u-00015q-Jb
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 15:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761426AbXGLNuO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 12 Jul 2007 09:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760477AbXGLNuO
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 09:50:14 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3403 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760554AbXGLNuN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 09:50:13 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1I8z3O-0007Zh-00; Thu, 12 Jul 2007 14:49:58 +0100
Content-Disposition: inline
In-Reply-To: <m3ps2xu5hc.fsf@pc7.dolda2000.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52290>

On 2007-07-12 15:16:47 +0200, Fredrik Tolf wrote:

> When I develop for myself, I usually commit incrementally quite a
> bit, if for no other reason because Git won't let me switch between
> branches if I don't commit first.

You can switch branches even if you have local modifications if you
use the -m flag to git-checkout.

> I usually try to keep my commits well-defined, but I don't manage to
> get anywhere close to what I see when I look at the history of Linux
> or Git.
>
> So what I'm wondering is how you people manage to do this? Do you
> actually always commit changes this way (and, in that case, how do
> you switch between branches)? Or do you somehow aggregate the
> smaller commits into larger patches and recommit them? Or is there
> some third possibility that I'm missing?

When it's time to post patches for review on the mailing list, people
clean up the history so that it'll be easier for the reviewers to read
(and to make the permanent history easier to read in case the patches
are accepted). Of course, with practice one can write clean patches to
begin with, at least for simpler changes, but the conceptual workflow
is along the lines of:

  1. Do the changes, and make sure everything works.

  2. Rewrite your changes as a series of easy-to-read and mostly
     independent patches, and make sure that everything compiles and
     just generally makes sense at all intermediate steps. The
     maintainer might very well accept some of your patches but not
     all!

  3. Repeat until you're satisfied with the result.

The rationale for spending time making history legible is the same as
for making the end result code legible: stuff is written once by one
person, and read many times by many people.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
