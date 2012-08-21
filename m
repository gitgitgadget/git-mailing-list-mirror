From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: misleading diff-hunk header
Date: Tue, 21 Aug 2012 17:22:13 +0200
Message-ID: <87a9xoi82i.fsf@thomas.inf.ethz.ch>
References: <503385D0.5070605@tim.thechases.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Tim Chase <git@tim.thechases.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 17:22:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3qHx-0006PN-RE
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 17:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755147Ab2HUPWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 11:22:30 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:30262 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756042Ab2HUPWR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 11:22:17 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 21 Aug
 2012 17:22:09 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (46.126.8.85) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 21 Aug
 2012 17:22:13 +0200
In-Reply-To: <503385D0.5070605@tim.thechases.com> (Tim Chase's message of
	"Tue, 21 Aug 2012 07:57:52 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203967>

Tim Chase <git@tim.thechases.com> writes:

> diff.{type}.xfuncname seems to start searching backwards in
> from the beginning of the hunk, not the first differing line.
[...]
>   @@ -4,4 +4,5 @@ int call_me(int maybe)
>
>    int main()
>    {
>   +  return 0;
>    }
>
> misleadingly suggesting that the change occurred in the call_me()
> function, rather than in main()

I think that's intentional, and matches what 'diff -p' does.  It gives
you the context before the hunk.  After all, if a new function starts in
the leading context lines, you can see that in the usual diff data.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
