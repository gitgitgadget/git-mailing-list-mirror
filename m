From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFH] filter-branch: ancestor detection weirdness
Date: Tue, 12 Aug 2008 10:18:51 +0200
Message-ID: <20080812081851.GK32184@machine.or.cz>
References: <200808080148.27384.trast@student.ethz.ch> <200808081614.44422.trast@student.ethz.ch> <alpine.DEB.1.00.0808081632580.24820@pacific.mpi-cbg.de.mpi-cbg.de> <200808082037.49918.trast@student.ethz.ch> <alpine.DEB.1.00.0808090212060.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7viqub9dzi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Jan Wielemaker <J.Wielemaker@uva.nl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 10:19:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSp6k-0003R6-KP
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 10:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbYHLISz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 04:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbYHLISy
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 04:18:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:57052 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751636AbYHLISx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 04:18:53 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id DD293393B303; Tue, 12 Aug 2008 10:18:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7viqub9dzi.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92076>

On Fri, Aug 08, 2008 at 06:25:05PM -0700, Junio C Hamano wrote:
> Perhaps --full-history is needed to the rev-list call (and the recent
> invention --simplify-merges that will hopefully appear sometime after
> 1.6.0)?  See recent discussion of --full-history and the default merge
> simplification between Linus and Roman Zippel.  I suspect that back when
> the original cg-rewritehistory was written, not many people understood the
> issues explained in that thread.

Just as a historical note, --subdirectory-filter was actually not part
of cg-admin-rewritehist.

				Petr "Pasky" Baudis
