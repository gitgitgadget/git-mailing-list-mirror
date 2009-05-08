From: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
Subject: Re: I want "fast forward my workdir to upstream if it's safe"
Date: Fri, 8 May 2009 14:34:12 +0200
Message-ID: <F871F2A1-DFCF-4642-BB53-7BE483A93271@orakel.ntnu.no>
References: <86prekfv7z.fsf@blue.stonehenge.com> <20090508023028.GA1218@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 08 14:55:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2PcG-0008Ik-3c
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 14:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752827AbZEHMzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 08:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbZEHMzn
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 08:55:43 -0400
Received: from eyvind.bernhardsens.net ([84.49.228.97]:56181 "EHLO
	eyvind.bernhardsens.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbZEHMzm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 08:55:42 -0400
X-Greylist: delayed 1284 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 May 2009 08:55:42 EDT
Received: from ivilhamac.dhcp.ad.fast.no (unknown [217.144.235.5])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by eyvind.bernhardsens.net (Postfix) with ESMTP id B56DB2396D0;
	Fri,  8 May 2009 14:34:14 +0200 (CEST)
In-Reply-To: <20090508023028.GA1218@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118603>

On 8. mai. 2009, at 04.30, Jeff King wrote:

> On Thu, May 07, 2009 at 02:40:00PM -0700, Randal L. Schwartz wrote:
>
>> So, what I need is a command, likely an option to "git merge" that  
>> says "do
>> everything that a git merge would do except abort if it would have  
>> been a
>> merge commit".  In other words, abort if the workdir is dirty or is  
>> not a
>> fast-forward update to the upstream.  Bonus if it exits non-zero if
>> something went wrong.
>
> Can you define more clearly what you want, because you are asking for
> conflicting things. "abort if it would have been a merge commit" is
> purely about fast forward. But it sounds like you also care about  
> "would
> merge have succeeded". So I think you are asking for:
>
>  1. There are no local commits on the branch.
>
> and one of:
>
>  2a. There are no local edits.
>
>  2b. There are no local edits in the same files as those that are
>      affected by any new commits from upstream.
>
>  2c. Any local edits you have done would not cause a conflict if  
> merged
>      with what's in upstream.

I read it as a request for pull/merge --ff-only (based on "abort if  
the workdir is dirty or is not a fast-forward update").  This feature  
has been implemented twice, but never included:

http://article.gmane.org/gmane.comp.version-control.git/76787
http://article.gmane.org/gmane.comp.version-control.git/107768
http://article.gmane.org/gmane.comp.version-control.git/80284
-- 
Eyvind Bernhardsen
