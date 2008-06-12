From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH 0/2] Respecting core.autocrlf when showing objects
Date: Thu, 12 Jun 2008 15:50:34 -0500
Message-ID: <1213303835.5327.24.camel@ld0161-tx32>
References: <7vprqqdwh7.fsf@gitster.siamese.dyndns.org>
	 <cover.1213084587.git.marius@trolltech.com>
	 <alpine.DEB.1.00.0806101632570.1783@racer>
	 <7vk5gxc4gz.fsf@gitster.siamese.dyndns.org>
	 <484F6A27.1040602@trolltech.com> <alpine.DEB.1.00.0806112000400.1783@racer>
	 <4850E647.7050602@trolltech.com>
	 <7vtzfy8n4i.fsf@gitster.siamese.dyndns.org>
	 <20080612195553.GK13626@fieldses.org>
	 <7vprqmz8kj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 22:52:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6tm8-0003qZ-09
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 22:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755077AbYFLUvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 16:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755041AbYFLUvH
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 16:51:07 -0400
Received: from de01egw01.freescale.net ([192.88.165.102]:34961 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754704AbYFLUvG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 16:51:06 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id m5CKoauo016858;
	Thu, 12 Jun 2008 13:50:36 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m5CKoZYd010765;
	Thu, 12 Jun 2008 15:50:35 -0500 (CDT)
In-Reply-To: <7vprqmz8kj.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.0.2 (2.0.2-35.el4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84795>

On Thu, 2008-06-12 at 13:45 -0700, Junio C Hamano wrote:
> "J. Bruce Fields" <bfields@fieldses.org> writes:
> 
> > (Is there any advantage, then, to the :n:filename syntax to a user?
> > Is it useful in any cases when they couldn't use HEAD or MERGE_HEAD
> > instead?  If not I might be tempted to cut this bit entirely (or
> > postpone it till later.)
> 
> I am somewhat torn between the two.
> 
> This section is only about merge conflicts, so using "checkout HEAD path"
> would be a good substitute.  The text flows better that way, because the
> previous paragraph talks about HEAD and MERGE_HEAD.
> 
> When people run "am -3", however, they may wish that they learned how the
> notation to name blob objects in the index (e.g. :2:path) can be used to
> examine and resolve the conflict, as there is no HEAD/MERGE_HEAD in that
> usage context.


Hi Junio,

I was planning on specifically pointing out the :n: forms as well.
So I'm watching this one a bit carefully and would appreciate a
bit of long-term guidance on the issue here.

Thanks,
jdl
