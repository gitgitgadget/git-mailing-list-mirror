From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Thu, 19 Jul 2007 15:21:24 +0200
Message-ID: <86abts8r6z.fsf@lola.quinscape.zz>
References: <alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org> <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org> <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org> <85abttwa7m.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org> <7vbqe93qtv.fsf@assigned-by-dhcp.cox.net> <20070719053858.GE32566@spearce.org> <20070719060922.GF32566@spearce.org> <vpqvecgvmjh.fsf@bauges.imag.fr> <20070719105105.GA4929@moonlight.home> <86zm1sbpeh.fsf@lola.quinscape.zz> <86bqe8a7ql.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 15:21:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBVwy-0008J2-Jk
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 15:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755992AbXGSNVp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 09:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754449AbXGSNVp
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 09:21:45 -0400
Received: from main.gmane.org ([80.91.229.2]:38254 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753730AbXGSNVo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 09:21:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IBVwm-0002av-6x
	for git@vger.kernel.org; Thu, 19 Jul 2007 15:21:36 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 15:21:36 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 15:21:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:V5KUnWAFIQ83oI6HQfMp5Z267dY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52990>

David Kastrup <dak@gnu.org> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> Although it would be natural to have
>> core.adddirs: false
>> be equivalent to
>> core.excludefile: .
>>
>> And so it might be possible to actually not need a separate
>> core.adddirs option at all, technically.
>
> To followup on myself here:
>
> A project such as the linux kernel which presumably does not want to
> have directories tracked will put the single pattern
> .
> into its top-level .gitignore file.  That is all.  At least if it does
> not confuse current versions of git to do ugly things.

Another followup: it doesn't.  I placed a single line
.
into a .gitignore file.  This did not cause git to ignore the contents
of ., and even
git-add .
worked as previously, namely adding the contents of the current
directory and subdirectories to the index.

In short: the gitignore idea for policing directory management is
perfectly upwards-compatible with current versions of git.

-- 
David Kastrup
