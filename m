From: Vitaly Berov <vitaly.berov@gmail.com>
Subject: Re: git clone: very long "resolving deltas" phase
Date: Sat, 10 Apr 2010 11:58:44 +0400
Message-ID: <hppb4i$a8m$1@dough.gmane.org>
References: <loom.20100406T161552-321@post.gmane.org> <alpine.LFD.2.00.1004061709360.7232@xanadu.home> <4BBC1ED3.6020008@gmail.com> <alpine.LFD.2.00.1004070842580.7232@xanadu.home> <4BBECE44.4040608@gmail.com> <alpine.LFD.2.00.1004091518500.7232@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 10 09:59:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0VbR-0007dF-07
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 09:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924Ab0DJH7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 03:59:24 -0400
Received: from lo.gmane.org ([80.91.229.12]:44828 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750743Ab0DJH7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 03:59:24 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O0Vb9-0007Zo-3t
	for git@vger.kernel.org; Sat, 10 Apr 2010 09:59:23 +0200
Received: from 195.218.191.171 ([195.218.191.171])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 09:59:23 +0200
Received: from vitaly.berov by 195.218.191.171 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 09:59:23 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 195.218.191.171
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9pre) Gecko/20100217 Shredder/3.0.3pre
In-Reply-To: <alpine.LFD.2.00.1004091518500.7232@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144532>

On 04/09/2010 11:25 PM, Nicolas Pitre wrote:
>>
>> Objects amount: 3997548.
>> Size of the repository: ~57Gb.
>
> OK.  You probably have a size record.  :-)
That's game development. We have ~100 artists who produce text and 
binary files as "sources". FYI, the "end client version" is ~2.5GB.

> How big is the .pack file in .git/objects/pack/ ?
~56Gb

>
>> By the way, we have a large amount of binary files in our rep.
>
> How many?  How big?

Total amount of files ~400000, amount of binaries ~200000.
Distribution of sizes:  5% of 4M - 32K, 5% of 32K - 12K, 12K - 6K, 6K - 
4K, 4K - 2.5K, 2.5K - 2.3K, 2.3K - 2K, the rest

Vitaly

P.S. By the way, msysgit can't handle this repository, blocker bug is:
http://code.google.com/p/msysgit/issues/detail?id=365&q=mmap&colspec=ID%20Type%20Status%20Priority%20Component%20Owner%20Summary.
So I thinking about stopping the evaluation, though I like git 
(especially after a long subversion experience :))
