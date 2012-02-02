From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] Breakage in master?
Date: Thu, 02 Feb 2012 21:45:10 +0100
Message-ID: <4F2AF5D6.4060609@kdbg.org>
References: <CABPQNSbWu0r_gKGvCHk567pUtQiyDOCO8vFfrzPMFW1eUaj1nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 02 21:45:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt3Wy-0006Hj-VC
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 21:45:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755564Ab2BBUpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 15:45:14 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:23951 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754050Ab2BBUpN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 15:45:13 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 905CA130049;
	Thu,  2 Feb 2012 21:45:10 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 47E6F19F64F;
	Thu,  2 Feb 2012 21:45:10 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <CABPQNSbWu0r_gKGvCHk567pUtQiyDOCO8vFfrzPMFW1eUaj1nw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189704>

Am 02.02.2012 13:14, schrieb Erik Faye-Lund:
> Something strange is going on in Junio's current 'master' branch
> (f3fb075). "git show" has started to error out on Windows with a
> complaint about our vsnprintf:
> ---8<---
> 
> $ git show
> commit f3fb07509c2e0b21b12a598fcd0a19a92fc38a9d
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Tue Jan 31 22:31:35 2012 -0800
> 
>     Update draft release notes to 1.7.10
> 
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
> fatal: BUG: your vsnprintf is broken (returned -1)

FWIW, I run a version of master on Windows with almost no additional
patches that touch compat/ (the few changes I do have are unsuspicious).
But I do not observe this behavior. I build with NO_GETTEXT and -O0.

-- Hannes
