From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2] Support copy and rename detection in fast-export.
Date: Tue, 29 Jul 2008 09:45:20 -0700
Message-ID: <20080729164520.GA1730@spearce.org>
References: <200807211216.01694.angavrilov@gmail.com> <200807262249.18005.angavrilov@gmail.com> <20080726202103.GA15769@spearce.org> <200807270052.55370.angavrilov@gmail.com> <7v7ib4hdpu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alexander Gavrilov <angavrilov@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 18:46:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNsL9-0002bW-MJ
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 18:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbYG2QpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 12:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbYG2QpV
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 12:45:21 -0400
Received: from george.spearce.org ([209.20.77.23]:38234 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbYG2QpU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 12:45:20 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2E2D8383A4; Tue, 29 Jul 2008 16:45:20 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7v7ib4hdpu.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90655>

Junio C Hamano <gitster@pobox.com> wrote:
> Alexander Gavrilov <angavrilov@gmail.com> writes:
> 
> > Although it does not matter for Git itself, tools that
> > export to systems that explicitly track copies and
> > renames can benefit from such information.
> >
> > This patch makes fast-export output correct action
> > logs when -M or -C are enabled.
> >
> > Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
> > ---
> >
> > 	On Sunday 27 July 2008 00:21:03 Shawn O. Pearce wrote:
> > 	> Do you mean to say git-fast-export in the end of the first line of
> > 	> that last paragraph?
> >
> > 	Yes, of course. Thank you.
> 
> Alexander, Shawn, what is the status of this patch?  Has it been reviewed
> sufficiently and is ready for application?

It looked OK to me on the surface, except the one minor remark in
the documentation I noted above.  Other than that I am not very good
with the internal diff machinary so my ACK/NACK on such matters is
worth very little, if anything.
 
-- 
Shawn.
