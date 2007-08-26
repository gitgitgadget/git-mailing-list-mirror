From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: `git-rev-parse master` not referred to by any ref?
Date: Sun, 26 Aug 2007 18:36:10 -0400
Message-ID: <20070826223610.GB9116@fieldses.org>
References: <20070826134521.GA20243@fieldses.org> <20070826135251.GB20243@fieldses.org> <20070826140645.GC20243@fieldses.org> <7vir72ng1n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 00:36:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPQiU-0004Xb-Ak
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 00:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716AbXHZWgQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 18:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752692AbXHZWgQ
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 18:36:16 -0400
Received: from mail.fieldses.org ([66.93.2.214]:33142 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752654AbXHZWgP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 18:36:15 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IPQiI-00048C-Ho; Sun, 26 Aug 2007 18:36:10 -0400
Content-Disposition: inline
In-Reply-To: <7vir72ng1n.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56742>

On Sun, Aug 26, 2007 at 02:26:28PM -0700, Junio C Hamano wrote:
> It _might_ make it safer to refuse creating anything outside
> refs/ if the name does not contain or ends with "HEAD" (or
> perhaps names that have chars outside "[_A-Z]"), but that would
> restrict future tools that might want to have HEAD-like files,
> so I am a bit hesitant.

Sure.

I would have recovered faster if I'd known had a simple way to get a
list of all the refs that git-rev-parse finds.  Is there an easy way?  I
assume "find .git -name .." will miss packed refs.  Both git-show-ref
and git-for-each-ref seem to ignore top-level references.

Maybe the "refname 'master' is ambiguous" warning could be modified to
list the choices?  I don't know if that would be overkill.

--b.
