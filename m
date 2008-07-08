From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Remove --undo flags from stg commands and docs
Date: Tue, 8 Jul 2008 06:21:31 +0200
Message-ID: <20080708042131.GB2247@diana.vm.bytemark.co.uk>
References: <20080704063536.9570.43526.stgit@yoghurt> <b0943d9e0807071354j50dca83aya90317f97f559b19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 06:22:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG4io-00016J-Rx
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 06:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbYGHEVi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jul 2008 00:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbYGHEVi
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 00:21:38 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2308 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbYGHEVh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 00:21:37 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KG4hn-0000dr-00; Tue, 08 Jul 2008 05:21:31 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0807071354j50dca83aya90317f97f559b19@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87705>

On 2008-07-07 21:54:01 +0100, Catalin Marinas wrote:

> 2008/7/4 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > In this one, I've just removed the --undo flag from sync without
> > adding anything back. Still undetermined if that's OK.
>
> I think it should be ok (see the other thread). Anyway, have you
> heard of anyone else using sync apart from me?

No, I haven't.

I've tried to understand what it does, and as far as I can tell it
doesn't do quite what I want. (What I want is the ability to 3-way
merge StGit patch stacks, so that I can modify the same patch stack in
several places and merge back and forth. From what I recall, the sync
command is more like a 2-way merge -- that is, it doesn't take the
last common ancestor into account. But it's been a while since I
studied it.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
