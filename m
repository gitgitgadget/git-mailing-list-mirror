From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Convert "sink" to the new infrastructure
Date: Mon, 15 Sep 2008 09:57:40 +0200
Message-ID: <20080915075740.GB14452@diana.vm.bytemark.co.uk>
References: <20080912215613.10270.20599.stgit@localhost.localdomain> <20080914085118.GC30664@diana.vm.bytemark.co.uk> <b0943d9e0809141419q6facb21at627e658805f1d223@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 09:41:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kf8hs-0004z3-5Y
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 09:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104AbYIOHfd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Sep 2008 03:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752090AbYIOHfd
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 03:35:33 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1479 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbYIOHfd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 03:35:33 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Kf8xo-0003oz-00; Mon, 15 Sep 2008 08:57:40 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0809141419q6facb21at627e658805f1d223@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95887>

On 2008-09-14 22:19:41 +0100, Catalin Marinas wrote:

> I wasn't used to reading documentation in StGit files :-). Thanks
> for the info, I'll repost.

It was you who asked for in-code docs. :-) The new-infrastructure code
actually looks half decent in epydoc nowadays.

> I'll make the default behaviour to cancel the transaction and revert
> to the original state unless an option is given to allow conflicts.

What I've always wanted is "sink this patch as far as it will go
without conflicting". This comes awfully close.

BTW, this kind of flag might potentially be useful in many commands
(with default value on or off depending on the command). Maybe

  --conflicts=3Droll-back|stop-before|allow

to indicate if the command should roll back the whole operation, stop
just before the conflicting push, or allow conflicts.

> I can see calls to pop_patches(lambda pn: pn in patch_list). I think
> we could have a helper for this.

Indeed.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
