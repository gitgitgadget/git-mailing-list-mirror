From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: AAARGH bisection is hard (Re: [2.6.39 regression] X locks up
 hard right after logging in)
Date: Thu, 12 May 2011 20:54:53 +0200
Message-ID: <4DCC2CFD.4010807@kdbg.org>
References: <BANLkTi=kb_m-CfrpnD8qQTVYLGaDdgy_tg@mail.gmail.com> <BANLkTi=YDZa+BRaG90vJsjrT9VxgySrDRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andrew Lutomirski <luto@mit.edu>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu May 12 20:55:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKb2M-0006FY-U3
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 20:55:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434Ab1ELSy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 14:54:57 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:31915 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750775Ab1ELSy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 14:54:57 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id A8162CDF84;
	Thu, 12 May 2011 20:54:43 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id AF7AA19F3A1;
	Thu, 12 May 2011 20:54:53 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.17) Gecko/20110414 SUSE/3.1.10 Thunderbird/3.1.10
In-Reply-To: <BANLkTi=YDZa+BRaG90vJsjrT9VxgySrDRQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173493>

Am 12.05.2011 19:37, schrieb Linus Torvalds:
> If you think it's networking, for example, and you've bisected into
> there but aren't sure, do "gitk --bisect", find the point where I
> merge, and pick that (and my parent), and "git bisect reset" those
> points.

Except that you should git reset --hard; git bisect reset gets you out
of bisect-mode, no?

-- Hannes
