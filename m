From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 2/6] Don't try to merge files that merge-recursive already merged
Date: Wed, 22 Aug 2007 11:44:13 +0200
Message-ID: <20070822094413.GC30748@diana.vm.bytemark.co.uk>
References: <11875975232619-git-send-email-davidk@lysator.liu.se> <1187597523433-git-send-email-davidk@lysator.liu.se> <11875975232734-git-send-email-davidk@lysator.liu.se> <20070822092152.GB30748@diana.vm.bytemark.co.uk> <87sl6bewqo.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, catalin marinas <catalin.marinas@gmail.com>
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Wed Aug 22 11:44:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INmlA-0004No-7Y
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 11:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbXHVJoR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 22 Aug 2007 05:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755619AbXHVJoQ
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 05:44:16 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3185 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbXHVJoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 05:44:16 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1INml3-0008CS-00; Wed, 22 Aug 2007 10:44:13 +0100
Content-Disposition: inline
In-Reply-To: <87sl6bewqo.fsf@morpheus.local>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56361>

On 2007-08-22 11:37:03 +0200, David K=E5gedal wrote:

> Karl Hasselstr=F6m <kha@treskal.com> writes:
>
> > On 2007-08-20 10:11:59 +0200, David K=E5gedal wrote:
> >
> > > This avoid duplicating work, but also changes the resulting
> > > index state so that the conflicts are left in the index in the
> > > three stages.
> >
> > After this patch, t1400-patch-history fails:
>
> I think that the push(c) commits will never happen with my patches,
> so the test case needs an update.

Actually, the failure vanishes once the next patch in the series is
applied. I thought this was a good thing, but if they're never
supposed to happen, maybe the test is still broken, just not in a way
that's detected?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
