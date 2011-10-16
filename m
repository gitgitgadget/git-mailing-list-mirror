From: arQon <arqon@gmx.com>
Subject: Re: [BUG] git checkout <branch> allowed with uncommitted changes
Date: Sun, 16 Oct 2011 18:25:03 +0000 (UTC)
Message-ID: <loom.20111016T201930-426@post.gmane.org>
References: <4E96D819.20905@op5.se> <loom.20111013T152144-60@post.gmane.org> <1318517194.4646.30.camel@centaur.lab.cmartin.tk> <loom.20111013T171530-970@post.gmane.org> <1318525486.4646.53.camel@centaur.lab.cmartin.tk> <loom.20111013T193054-868@post.gmane.org> <7vzkh44ug1.fsf@alter.siamese.dyndns.org> <loom.20111013T203610-130@post.gmane.org> <20111014013830.GA7258@sigill.intra.peff.net> <4E980093.6040704@ira.uka.de> <20111014095447.GC2856@victor.terreactive.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 16 20:25:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFVOm-0007BY-0Z
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 20:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754990Ab1JPSZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 14:25:17 -0400
Received: from lo.gmane.org ([80.91.229.12]:40285 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752081Ab1JPSZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 14:25:16 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RFVOc-000787-VD
	for git@vger.kernel.org; Sun, 16 Oct 2011 20:25:15 +0200
Received: from 24-180-45-63.dhcp.crcy.nv.charter.com ([24.180.45.63])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 16 Oct 2011 20:25:14 +0200
Received: from arqon by 24-180-45-63.dhcp.crcy.nv.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 16 Oct 2011 20:25:14 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 24.180.45.63 (Mozilla/5.0 (X11; Linux i686; rv:7.0.1) Gecko/20100101 Firefox/7.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183732>

Victor Engmark <victor.engmark <at> terreactive.ch> writes:
> Very good point. How about by default just running `git status` after a
> successful checkout, and only printing the result if there are any
> changes? That way:
> 1) If no changes are pending, nothing is displayed.
> 2) The user sees a *familiar* style output if anything changed.
> 3) If there's an alias for "status", it would be used.

I'm sold on this. Better documentation for checkout wouldn't hurt regardless,
and I'm still planning on that when I get a chance; but better *behavior* is a
clear win either way. Adding half a page of text to the docs explaining what
each status char means is a hugely-inferior "solution" to simply not having
an aberrant status-ish output in the first place.
