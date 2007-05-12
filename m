From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Merging commits together into a super-commit
Date: Sat, 12 May 2007 16:02:28 +0200
Message-ID: <20070512140228.GB28039@diana.vm.bytemark.co.uk>
References: <1178794261.5806.98.camel@murta.transitives.com> <4643049C.3D5F30D8@eudaptics.com> <alpine.LFD.0.98.0705100857450.3986@woody.linux-foundation.org> <87wszg39cp.wl%cworth@cworth.org> <20070510171457.GK13719@fieldses.org> <87vef0350y.wl%cworth@cworth.org> <20070510192106.GB4489@pasky.or.cz> <87tzuk31fu.wl%cworth@cworth.org> <20070512113430.GL19253@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carl Worth <cworth@cworth.org>, Petr Baudis <pasky@suse.cz>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sat May 12 16:02:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmsBI-0003Xl-2H
	for gcvg-git@gmane.org; Sat, 12 May 2007 16:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540AbXELOCk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 12 May 2007 10:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755502AbXELOCk
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 10:02:40 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1675 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540AbXELOCj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 10:02:39 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HmsB2-0007Mm-00; Sat, 12 May 2007 15:02:28 +0100
Mail-Followup-To: Yann Dirson <ydirson@altern.org>,
	Carl Worth <cworth@cworth.org>, Petr Baudis <pasky@suse.cz>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070512113430.GL19253@nan92-1-81-57-214-146.fbx.proxad.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47048>

On 2007-05-12 13:34:30 +0200, Yann Dirson wrote:

> I really think we should have a "stg uninit" command. Note that
> currently "stg branch --delete" on master will just do that instead
> of really deleting the branch, but that is a known bug (#8732 on
> gna).

What we should do is delete all stgit metadata when the last patch
goes away.

And we shouldn't have "stg init", either. Initing should be done
automatically when needed.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
