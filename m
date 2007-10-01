From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Adding rebase merge strategy
Date: Mon, 1 Oct 2007 19:09:36 -0400
Message-ID: <20071001230936.GA5556@fieldses.org>
References: <Pine.LNX.4.64.0709281751390.28395@racer.site> <11912513203420-git-send-email-tom@u2i.com> <7vr6ker1lf.fsf@gitster.siamese.dyndns.org> <550f9510710011441t1eb50352ofc8db77f79d794d5@mail.gmail.com> <87ejgescnb.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tom Clarke <tom@u2i.com>, Junio C Hamano <gitster@pobox.com>,
	Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Tue Oct 02 01:09:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcUOc-0004Pc-LY
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 01:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbXJAXJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 19:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbXJAXJn
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 19:09:43 -0400
Received: from mail.fieldses.org ([66.93.2.214]:40920 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339AbXJAXJn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 19:09:43 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IcUOO-0001Xr-QE; Mon, 01 Oct 2007 19:09:36 -0400
Content-Disposition: inline
In-Reply-To: <87ejgescnb.wl%cworth@cworth.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59645>

On Mon, Oct 01, 2007 at 03:17:28PM -0700, Carl Worth wrote:
> What I think I've always wanted is something like the following
> behavior for "git pull":
> 
>   * Fast forward if possible
> 
>   * Otherwise, rebase, but only if there are no conflicts at all
> 
>   * Otherwise, do the merge as normal, (leave conflict markers in
>     place allowing the user to fix them up and then commit).
> 
> Would it be straightforward to turn your rebase merge strategy into
> something like the above? And if so, would that address the primary
> concerns that Junio raised?

Surely the job of a merge strategy is to take two heads and produce a
single merge commit?

If it's worth automating the steps you describe above, I think it'd be
better to choose an entirely different name for the command.

--b.
