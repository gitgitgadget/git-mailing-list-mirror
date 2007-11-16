From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit RFC] A more structured way of calling git
Date: Fri, 16 Nov 2007 09:36:21 +0100
Message-ID: <20071116083621.GA18039@diana.vm.bytemark.co.uk>
References: <20071026192418.GA19774@diana.vm.bytemark.co.uk> <b0943d9e0711151028y22b37e04y87a6bc74dc4c5031@mail.gmail.com> <20071116074255.GA16975@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	Git Mailing List <git@vger.kernel.org>,
	Yann Dirson <ydirson@altern.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 09:36:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iswgv-00038d-MY
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 09:36:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450AbXKPIg1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Nov 2007 03:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752432AbXKPIg1
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 03:36:27 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2200 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbXKPIg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 03:36:26 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IswgX-0004hg-00; Fri, 16 Nov 2007 08:36:21 +0000
Content-Disposition: inline
In-Reply-To: <20071116074255.GA16975@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65203>

On 2007-11-16 08:42:55 +0100, Karl Hasselstr=F6m wrote:

> The complete state that would have to be saved would be
>
>   * (patchname, commit sha1) pairs for all patches
>
>   * (branchname, branch head sha1) pair
>
>   * the ordered lists of applied, unapplied, and eventually also
>     hidden patches

Oh, and

  * .git/config (one blob)

  * the worktree (one tree object?)

  * the index (one tree object per stage?)

Otherwise, we won't be able to un-clobber them. But a first
implementation could certainly skip this part.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
