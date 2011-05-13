From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: AAARGH bisection is hard (Re: [2.6.39 regression] X locks up
 hard right after logging in)
Date: Fri, 13 May 2011 20:34:08 +0200
Message-ID: <4DCD79A0.7000500@kdbg.org>
References: <BANLkTi=kb_m-CfrpnD8qQTVYLGaDdgy_tg@mail.gmail.com> <BANLkTikMeyRTOB9q4PEAYWnZRZfk3wg=kQ@mail.gmail.com> <BANLkTi=dL+KyQ3Bm58_Uj4LP9WSpbzAfJA@mail.gmail.com> <BANLkTi=NdVUUZ=_bACzyeMGS3JWs0EMbWA@mail.gmail.com> <BANLkTimE2GkkhcFZtNrYZASWp0LDhUx=GQ@mail.gmail.com> <BANLkTinyzBnksHk_rt8K2pmg90q5WyZX3w@mail.gmail.com> <BANLkTinVT=9+-HhwXcyLBwrnhX9F9Qz3ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andrew Lutomirski <luto@mit.edu>,
	Christian Couder <christian.couder@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	git@vger.kernel.org, Shuang He <shuang.he@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-kernel-owner@vger.kernel.org Fri May 13 20:34:25 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1QKxBs-0002ZE-9m
	for glk-linux-kernel-3@lo.gmane.org; Fri, 13 May 2011 20:34:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476Ab1EMSeN (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 13 May 2011 14:34:13 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:38244 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750746Ab1EMSeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2011 14:34:11 -0400
X-Greylist: delayed 85155 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 May 2011 14:34:11 EDT
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 1FA8710014;
	Fri, 13 May 2011 20:34:09 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id D2DDD19F3A5;
	Fri, 13 May 2011 20:34:08 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.17) Gecko/20110414 SUSE/3.1.10 Thunderbird/3.1.10
In-Reply-To: <BANLkTinVT=9+-HhwXcyLBwrnhX9F9Qz3ww@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173558>

Am 13.05.2011 19:54, schrieb Linus Torvalds:
> For example, in your case, since you had certain requirements of
> support that simply didn't exist earlier, something like
> 
>    git bisect requires v2.6.38
> 
> would have been really useful - telling git bisect that any commit
> that cannot reach that required commit is not even worth testing.

You can already have this with

   git bisect good v2.6.38

It sounds a bit unintuitive, but with a slight mind-twist it can even be
regarded as correct in a mathematical sense: when the precondition is
false, the result is true. ;-)

-- Hannes
