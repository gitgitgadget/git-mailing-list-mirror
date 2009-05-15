From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] Showing stash state in bash prompt
Date: Fri, 15 May 2009 09:57:20 +0900
Message-ID: <buo1vqrqj2n.fsf@dhlpc061.dev.necel.com>
References: <20090513094448.GC2106@bug.science-computing.de>
	<20090513112535.GD2106@bug.science-computing.de>
	<7v4ovo4xyt.fsf@alter.siamese.dyndns.org>
	<200905142025.02592.trast@student.ethz.ch>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Trstenjak <Daniel.Trstenjak@science-computing.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	spearce@spearce.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri May 15 02:58:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4lkv-0007f1-D6
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 02:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756578AbZEOA6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 20:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755578AbZEOA6Z
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 20:58:25 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:57357 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756532AbZEOA6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 20:58:24 -0400
Received: from relay31.aps.necel.com ([10.29.19.54])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n4F0vKgH025836;
	Fri, 15 May 2009 09:57:21 +0900 (JST)
Received: from relay21.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay31.aps.necel.com with ESMTP; Fri, 15 May 2009 09:57:21 +0900
Received: from dhlpc061 ([10.114.113.70] [10.114.113.70]) by relay21.aps.necel.com with ESMTP; Fri, 15 May 2009 09:57:21 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id EFBA952E30D; Fri, 15 May 2009 09:57:20 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <200905142025.02592.trast@student.ethz.ch> (Thomas Rast's message
	of "Thu, 14 May 2009 20:24:21 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119242>

Thomas Rast <trast@student.ethz.ch> writes:
> But IMHO it would not be a good idea to teach people stash/pop anyway:
> 'stash drop' is irreversible, because the stash is itself implemented
> through the reflog and thus not guarded by one.

I don't understand why you say this -- sure "drop" is dangerous, but
that's exactly why you should use "pop" instead, because it makes sure
the changes are _somewhere_.  I found with the old (pre-"pop") stash,
I'd often end up in a situation where I'd lose track of whether I had
done a stash apply or not, and the risk of inadvertently doing a drop
_without_ a corresponding apply was very real.

stash/pop is safer, more convenient, and I think it better matches how
people actually work.

-Miles

-- 
What the fuck do white people have to be blue about!?  Banana Republic ran
out of Khakis?  The Espresso Machine is jammed?  Hootie and The Blowfish
are breaking up??!  Shit, white people oughtta understand, their job is to
GIVE people the blues, not to get them!  -- George Carlin
