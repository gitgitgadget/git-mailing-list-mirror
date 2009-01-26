From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: add --ignore-paths option for fetching
Date: Sun, 25 Jan 2009 17:18:47 -0800
Message-ID: <20090126011847.GA8703@dcvr.yhbt.net>
References: <1232864842-8841-1-git-send-email-public_vi@tut.by> <200901251521.15591.trast@student.ethz.ch> <20090125224238.GA31581@untitled> <497CEC56.3020900@tut.by>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: public_vi <public_vi@tut.by>
X-From: git-owner@vger.kernel.org Mon Jan 26 02:20:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRG96-0004wE-UP
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 02:20:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbZAZBSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 20:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbZAZBSs
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 20:18:48 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:52909 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750923AbZAZBSr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 20:18:47 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C3CB1F602;
	Mon, 26 Jan 2009 01:18:47 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <497CEC56.3020900@tut.by>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107152>

public_vi <public_vi@tut.by> wrote:
> Eric Wong wrote:
>> Thomas Rast <trast@student.ethz.ch> wrote:
>>   
>>
>> Also, indentation is always done with tabs in git-svn (and the vast
>> majority of git as well).
>>
>>   
> Whitespace is invisible for me now, I only checked according to  
> Documentation/SubmittingPatches about extra lines adds or removes caused  
> just by whitespace difference.
>>
>>
>> Vitaly: thank you for the patch.  Can you also provide a testcase to
>> ensure this functionality doesn't break during refactorings?  Thanks.
>>
>>   
> Already done it with testcase. There are two new packs of patches sent  
> to git@vger.kernel.org, the first is outdated too, the second is current.
> (I don't yet completely know how things should be done).

Thanks Vitaly, acked and pushed out with minor fixes to
git://git.bogomips.org/git-svn.git

git-svn: Add test for --ignore-paths parameter
    [ew: replaced 'echo -e' with printf so it works on POSIX shells]
    [ew: added Vitaly to copyright even though it's based on my test]

git-svn: documented --ignore-paths
    [ew: trailing whitespace removed]

git-svn: add --ignore-paths option for fetching
    [ew: replaced 4-space indent with tabs]
    [ew: prefixed $ignore_regex with an underscore to be consistent
         with other globals in git-svn]
    [ew: rearranged functions to minimize diff and removed prototype
         usage to be consistent with the rest of git-svn (and other
         Perl code in git (and they're ugly to me)]

-- 
Eric Wong
