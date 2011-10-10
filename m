From: Miles Bader <miles@gnu.org>
Subject: Re: Recovering Committed Changes in a Detached Head?
Date: Mon, 10 Oct 2011 10:26:06 +0900
Message-ID: <87sjn1fxht.fsf@catnip.gol.com>
References: <1318107488.5865.46.camel@R0b0ty>
	<20111008213741.GA24409@goldbirke>
	<ab706826-75df-4410-941e-6b40ec92713c@email.android.com>
	<7vfwj1px6h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Martin Fick <mfick@codeaurora.org>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Daly Gutierrez <daly.gutierrez@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 10 03:42:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RD4sb-0000kB-14
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 03:42:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275Ab1JJBmB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Oct 2011 21:42:01 -0400
Received: from smtp12.dentaku.gol.com ([203.216.5.74]:57729 "EHLO
	smtp12.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787Ab1JJBmA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Oct 2011 21:42:00 -0400
X-Greylist: delayed 940 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Oct 2011 21:42:00 EDT
Received: from 61.245.23.167.eo.eaccess.ne.jp ([61.245.23.167] helo=catnip.gol.com)
	by smtp12.dentaku.gol.com with esmtpa (Dentaku)
	(envelope-from <miles@gnu.org>)
	id 1RD4d5-0006LG-U5; Mon, 10 Oct 2011 10:26:07 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id E914BDFAD; Mon, 10 Oct 2011 10:26:06 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <7vfwj1px6h.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 09 Oct 2011 16:22:46 -0700")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183219>

Junio C Hamano <gitster@pobox.com> writes:
>> First, maybe git could create refs for these automatically, perhaps
>> with a name like orphans/1?  Maybe these refs would only be visible
>> via git branch --orphans.
>
> Instead of spelling them orphans/$n, you already have @{$n}.

Hmm, shouldn't that be "HEAD@{$n}" (as the reflog output suggests)?

[Well, I dunno, I'm generally kind of confused by the @{...} notation,
but I just tried it out, and just @{$n} seems to refer to the current
branch, which presumably won't include the orphaned bit once one it's
been orphaned...]

Thanks,

-Miles

-- 
`The suburb is an obsolete and contradictory form of human settlement'
