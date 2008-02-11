From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 2/2] Emacs mode: delete patches
Date: Mon, 11 Feb 2008 10:51:18 +0100
Message-ID: <20080211095118.GB28140@diana.vm.bytemark.co.uk>
References: <20080210204628.17886.27365.stgit@yoghurt> <20080210204851.17886.69638.stgit@yoghurt> <87wspbsubl.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Mon Feb 11 10:52:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOVLE-0005j7-CG
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 10:52:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756849AbYBKJvb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Feb 2008 04:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753506AbYBKJvb
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 04:51:31 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2163 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756810AbYBKJva (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 04:51:30 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JOVJm-0007LK-00; Mon, 11 Feb 2008 09:51:18 +0000
Content-Disposition: inline
In-Reply-To: <87wspbsubl.fsf@lysator.liu.se>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73496>

On 2008-02-11 10:42:22 +0100, David K=E5gedal wrote:

> Karl Hasselstr=F6m <kha@treskal.com> writes:
>
> > David, could you have a look at this as well? In addition to me
> > being elisp challenged, there are the following issues:
> >
> >   * Is "d" a reasonable binding? Any better suggestion?
>
> We could reserve "d" for moving a patch "down", maybe. The more
> destructive commands could be on less accessible keys. Maybe "D" or
> "C-d".

I'll take "D" then, since control bindings are more likely to collide
with existing bindings (as is already the case with C-r for stg
repair).

> >   * Currently, this command requires you to mark one or more
> >     patches before deleting. This is convenient when deleting more
> >     than one patch, but one could argue that it should be possible
> >     to delete the patch at point without having to select it.
>
> You need something like this:

OK, thanks. I'll whip up a proper patch tonight -- unless you prefer
to do it yourself?

> >   * We should probably ask for confirmation before deleting.
>
> Absolutely. Something like this (untested):

Thanks again.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
