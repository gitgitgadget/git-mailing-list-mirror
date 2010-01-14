From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] git push --track
Date: Thu, 14 Jan 2010 09:25:49 +0900
Message-ID: <871vht7cs2.fsf@catnip.gol.com>
References: <op.u6g8jnixg402ra@nb-04>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Rudolf Polzer" <divVerent@alientrap.org>
X-From: git-owner@vger.kernel.org Thu Jan 14 01:26:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVDXM-0000X2-MP
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 01:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756727Ab0ANAZ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 19:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756724Ab0ANAZ6
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 19:25:58 -0500
Received: from smtp12.dentaku.gol.com ([203.216.5.74]:38356 "EHLO
	smtp12.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756723Ab0ANAZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 19:25:57 -0500
Received: from 218.231.177.74.eo.eaccess.ne.jp ([218.231.177.74] helo=catnip.gol.com)
	by smtp12.dentaku.gol.com with esmtpa (Dentaku)
	id 1NVDX4-0006Hf-2H; Thu, 14 Jan 2010 09:25:50 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 81741DF73; Thu, 14 Jan 2010 09:25:49 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <op.u6g8jnixg402ra@nb-04> (Rudolf Polzer's message of "Wed, 13
	Jan 2010 16:12:49 +0100")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136902>

"Rudolf Polzer" <divVerent@alientrap.org> writes:
> I'd like a feature to automatically "transform" a non-tracking local
> branch into a tracking branch on push. A patch to do that is attached.

Yay!!

I've wanted this for a long time, but discussions about it always seem
to end up petering out...

> git branch mybranch
> git checkout mybranch
> ...
> git push --track origin mybranch:mybranch

Does it default to the current branch so you can just say "git push --track origin"?

I hope this can be added to the distro...

Thanks,

-Miles

-- 
Opposition, n. In politics the party that prevents the Goverment from running
amok by hamstringing it.
