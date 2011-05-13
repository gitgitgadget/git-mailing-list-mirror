From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: AAARGH bisection is hard (Re: [2.6.39 regression] X locks up
 hard right after logging in)
Date: Fri, 13 May 2011 20:47:26 +0200
Message-ID: <4DCD7CBE.9010409@kdbg.org>
References: <BANLkTi=kb_m-CfrpnD8qQTVYLGaDdgy_tg@mail.gmail.com> <BANLkTikMeyRTOB9q4PEAYWnZRZfk3wg=kQ@mail.gmail.com> <BANLkTi=dL+KyQ3Bm58_Uj4LP9WSpbzAfJA@mail.gmail.com> <BANLkTi=NdVUUZ=_bACzyeMGS3JWs0EMbWA@mail.gmail.com> <BANLkTimE2GkkhcFZtNrYZASWp0LDhUx=GQ@mail.gmail.com> <BANLkTinyzBnksHk_rt8K2pmg90q5WyZX3w@mail.gmail.com> <BANLkTinVT=9+-HhwXcyLBwrnhX9F9Qz3ww@mail.gmail.com> <4DCD79A0.7000500@kdbg.org> <BANLkTi=smoaARKyzWxFjid-E7qehmyAX8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andrew Lutomirski <luto@mit.edu>,
	Christian Couder <christian.couder@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	git@vger.kernel.org, Shuang He <shuang.he@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-kernel-owner@vger.kernel.org Fri May 13 20:47:47 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1QKxOt-0002P0-8T
	for glk-linux-kernel-3@lo.gmane.org; Fri, 13 May 2011 20:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757302Ab1EMSrk (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 13 May 2011 14:47:40 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:39521 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751219Ab1EMSri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2011 14:47:38 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 2E7D7A7EB4;
	Fri, 13 May 2011 20:43:34 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id C593619F393;
	Fri, 13 May 2011 20:47:26 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.17) Gecko/20110414 SUSE/3.1.10 Thunderbird/3.1.10
In-Reply-To: <BANLkTi=smoaARKyzWxFjid-E7qehmyAX8w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173560>

Am 13.05.2011 20:41, schrieb Linus Torvalds:
> On Fri, May 13, 2011 at 11:34 AM, Johannes Sixt <j6t@kdbg.org> wrote:
>>   git bisect good v2.6.38
> 
> When you say that v2.6.38 is good, that means that everything that can
> be reached from 2.6.38 is good.
> 
> NOT AT ALL the same thing as "git bisect requires v2.6.38" would be.
> 
> Think about it. It's the "reachable from v2.6.38" vs "cannot reach
> v2.6.38" difference. That's a HUGE difference.

Oops, you're right, I got it upside-down.

Thanks,
-- Hannes
