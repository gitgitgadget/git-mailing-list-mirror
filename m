From: Sam Vilain <sam@vilain.net>
Subject: Re: [spf:guess] Re: Bug? git-svn clone dies with "fatal: ambiguous
 argument '...': unknown revision or path not in the working tree."
Date: Fri, 15 Jan 2010 12:57:30 +1300
Message-ID: <4B4FAF6A.2070407@vilain.net>
References: <36366a981001121558v5324f2fbucf096e4c82402912@mail.gmail.com> <20100113052958.GA23182@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Eric Hanchrow <eric.hanchrow@gmail.com>, git@vger.kernel.org,
	Andrew Myrick <amyrick@apple.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jan 15 00:57:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVZZJ-0001Iy-S0
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 00:57:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757792Ab0ANX5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 18:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757109Ab0ANX5e
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 18:57:34 -0500
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:58108 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456Ab0ANX5d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 18:57:33 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 52D6732E98;
	Fri, 15 Jan 2010 12:57:31 +1300 (NZDT)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bSYi7xNFzxgJ; Fri, 15 Jan 2010 12:57:30 +1300 (NZDT)
Received: from [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0] (unknown [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0])
	(Authenticated sender: samv)
	by mail.catalyst.net.nz (Postfix) with ESMTPSA id D20BA32E94;
	Fri, 15 Jan 2010 12:57:30 +1300 (NZDT)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <20100113052958.GA23182@dcvr.yhbt.net>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137043>

Eric Wong wrote:
>> It chugged along happily for a while, but then died like this:
>>
>> fatal: ambiguous argument
>> '2d2df13977551168a54ffa9b706484242a58736a^..d038748d49a0de5802fe3c13f46d0e080d064290':
>>     
> [...]
> As we see below, d038748d49a0de5802fe3c13f46d0e080d064290 is a merge
> commit.  So I'll Cc Sam and Andrew on this since they know their way
> around the mergeinfo stuff far better than I do and will hopefully have
> some insight into things.
>
> Since it's probably related to the new mergeinfo handling, reverting to
> a version without it (1.6.5.7) might be the best way to go for now.
>   

I'm at a loss. I can't get my rev-list to say "ambiguous argument" when
I pass it a similar range (eg d4e1b47a9225^..a24a32dd on git.git). Why
does it matter that the d038748 commit is a merge commit?

Eric H, is this repository available publicly for me to test? I guess
it's possible that argument is not being passed to rev-list but to some
other command ... would be nice to be able to reproduce it.

Sam
