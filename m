From: David Kastrup <dak@gnu.org>
Subject: Re: empty directories
Date: Wed, 22 Aug 2007 21:12:33 +0200
Message-ID: <86fy2bcrj2.fsf@lola.quinscape.zz>
References: <1187716461.5986.71.camel@beauty> <fage86$hui$1@sea.gmane.org> <alpine.LFD.0.999.0708221144160.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 21:13:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INvdV-0002cD-0V
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 21:13:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759541AbXHVTMx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 15:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759660AbXHVTMw
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 15:12:52 -0400
Received: from main.gmane.org ([80.91.229.2]:41658 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757151AbXHVTMw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 15:12:52 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1INvdE-0001p8-Jl
	for git@vger.kernel.org; Wed, 22 Aug 2007 21:12:44 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 21:12:44 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 21:12:44 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:AXBj+ROL11AAvvOgsz3Vgy5sMzo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56409>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 22 Aug 2007, Salikh Zakirov wrote:
>> 
>> Linus Torvalds posted an untested patch in a recent discussion and
>> requested that anyone interested in this functionality continued
>> development and testing.
>
> That untested patch was seriously broken - it didn't do the sorting
> of empty directories right.

Well, it depends on where one wants to see directories sorted in the
index: the index sort order does not necessarily need to be the same
as the repository sort order: merge conflict detection could benefit
from sorting the directory "early" in the index.  Of course, this
would mean that one needed to stash away directories temporarily while
processing the index until the corresponding tree in the repository
comes up.

> So it would need a lot of other work.

With either choice of sort order, yes.  One place or the other.

-- 
David Kastrup
