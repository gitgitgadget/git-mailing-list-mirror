From: David Kastrup <dak@gnu.org>
Subject: Re: Git benchmark - comparison with Bazaar, Darcs, Git and Mercurial
Date: Wed, 01 Aug 2007 10:48:56 +0200
Message-ID: <86myxbod1j.fsf@lola.quinscape.zz>
References: <200708010216.59750.jnareb@gmail.com>
	<alpine.LFD.0.999.0707311850220.4161@woody.linux-foundation.org>
	<7vodhrby6f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 01 10:49:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IG9tR-0005tC-GQ
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 10:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754643AbXHAItT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 04:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754447AbXHAItT
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 04:49:19 -0400
Received: from main.gmane.org ([80.91.229.2]:39731 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754177AbXHAItS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 04:49:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IG9tF-00063L-Ta
	for git@vger.kernel.org; Wed, 01 Aug 2007 10:49:09 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Aug 2007 10:49:09 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Aug 2007 10:49:09 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:wklHvBkHJVCWwbu6PXyB2omYgJo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54418>


Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> (Which admittedly is a bit odd. The reason I didn't ever seriously even 
>> consider monotone was that the initial import was so *incredibly* sucky, 
>> and took hours for the kernel. So use "-l" for benchmarks, and damn my 
>> "I hate hardlinking repos" idiocy).
>
> I would call aversion to -l a superstition, while aversion to -s
> has a sound technical reasons.  The latter means you need to know
> what you are doing --- namely, you are making the clone still
> dependent on the original.

Well, I'd not call the -l aversy a complete superstition: it means
that cloning a repository won't provide any redundancy worth noting
against file system corruption.

-- 
David Kastrup
