From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 1/4] Add 2 new contrib scripts.
Date: Sun, 3 Jun 2007 14:32:54 +0200
Message-ID: <20070603123254.GB6507@diana.vm.bytemark.co.uk>
References: <20070531222920.6005.74481.stgit@gandelf.nowhere.earth> <20070531223423.6005.59088.stgit@gandelf.nowhere.earth> <87fy5cqbaz.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Sun Jun 03 14:33:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HupGc-00030f-Ot
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 14:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758168AbXFCMdA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 3 Jun 2007 08:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759375AbXFCMdA
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 08:33:00 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1112 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758168AbXFCMdA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 08:33:00 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HupGQ-0001t5-00; Sun, 03 Jun 2007 13:32:54 +0100
Content-Disposition: inline
In-Reply-To: <87fy5cqbaz.fsf@morpheus.local>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48983>

On 2007-06-01 11:22:12 +0200, David K=E5gedal wrote:

> This is something I've been missing.

I believe this is useful, too.

> But I'd call it "stg merge" or something, since what it does is that
> it merges the top patch into the patch below it. But since "merge"
> means something else to git, it might not be the best choice.

Maybe "coalesce"? I recall using that word when turning several
consecutive memory blocks into a single larger block in a malloc
implementation, and this sitiation is very similar.

It would be nice if it was possible to specify an arbitrary series of
patches, and get them coalesced into one. (StGIT would have to push
and pop to place them consecutively and topmost.) With a parameter to
control the name of the new large patch, and the comment being the
concatenation of the comments of the component patches (easily
editable in the editor window that pops up).

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
