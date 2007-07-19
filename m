From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Thu, 19 Jul 2007 14:24:20 +0200
Message-ID: <86wswwa8ej.fsf@lola.quinscape.zz>
References: <alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org> <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org> <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org> <85abttwa7m.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org> <7vbqe93qtv.fsf@assigned-by-dhcp.cox.net> <20070719053858.GE32566@spearce.org> <20070719060922.GF32566@spearce.org> <vpqvecgvmjh.fsf@bauges.imag.fr> <20070719105105.GA4929@moonlight.home> <Pine.LNX.4.64.0707191310430.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 14:24:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBV3r-0001fG-Qb
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 14:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761253AbXGSMYo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 08:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761316AbXGSMYn
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 08:24:43 -0400
Received: from main.gmane.org ([80.91.229.2]:51343 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760881AbXGSMYm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 08:24:42 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IBV3b-0003jt-Q0
	for git@vger.kernel.org; Thu, 19 Jul 2007 14:24:35 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 14:24:35 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 14:24:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:vewL3XnFrRmynP7wEZPetSGXeLs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52980>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Thu, 19 Jul 2007, Tomash Brechko wrote:
>
>> A year or so ago I too would strongly advocate the need of tracking 
>> empty directories, permissions et al., it seemed so "natural" and "plain 
>> obvious" to me back then.  But since that time I learned to appreciate 
>> the "contents tracking" approach, and now view directories (paths in 
>> general) only as the means for Git to know where to put the contents on 
>> checkout.  This, BTW, is consistent with how Git figures container 
>> copies/renames.
>
> Thank you.  It is my impression, too, that after a while it becomes 
> obvious what is good and what is not.
>
> FWIW I just whipped up a proof-of-concept patch (so at least _I_ cannot be 
> accused of chickening out of writing code):
>
> This adds the command line option "--add-empty-dirs" to "git add", which 
> does the only sane thing: putting a placeholder into that directory, and 
> adding that.  Since ".gitignore" is already a reserved file name in git, 
> it is used as the name of this place holder.

But that means that checkout will create a file .gitignore in
previously empty directories, doesn't it?

I think that the placeholder name should rather be ".".

-- 
David Kastrup
