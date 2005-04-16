From: David Mansfield <david@cobite.com>
Subject: Re: full kernel history, in patchset format
Date: Sat, 16 Apr 2005 10:55:45 -0400
Message-ID: <42612771.5000705@cobite.com>
References: <20050416131528.GB19908@elte.hu> <20050416133513.GA21678@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 16:53:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMofI-0002kt-1q
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 16:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbVDPO4c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 10:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbVDPO4c
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 10:56:32 -0400
Received: from ms-smtp-02-smtplb.rdc-nyc.rr.com ([24.29.109.6]:39596 "EHLO
	ms-smtp-02.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S262673AbVDPO4a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 10:56:30 -0400
Received: from [192.168.0.103] (cpe-66-65-159-236.nyc.res.rr.com [66.65.159.236])
	by ms-smtp-02.rdc-nyc.rr.com (8.12.10/8.12.7) with ESMTP id j3GEuMId021843;
	Sat, 16 Apr 2005 10:56:22 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050416133513.GA21678@elte.hu>
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> 
>>the patches contain all the existing metadata, dates, log messages and 
>>revision history. (What i think is missing is the BK tree merge 
>>information, but i'm not sure we want/need to convert them to GIT.)
> 
> 
> author names are abbreviated, e.g. 'viro' instead of 
> viro@parcelfarce.linux.theplanet.co.uk, and no committer information is 
> included (albeit commiter ought to be Linus in most cases). These are 
> limitations of the BK->CVS gateway i think.
> 

Glad to hear cvsps made it through!  I'm curious what the manual fixups 
required were, except for the binary file issue (logo.gif).

As to the actual email addresses, for more recent patches, the 
Signed-off should help.  For earlier ones, isn't their some script which 
'knows' a bunch of canonical author->email mappings? (the shortlog 
script or something)?

Is the full committer email address actually in the changeset in BK?  If 
so, given that we have the unique id (immutable I believe) of the 
changset, could it be extracted directly from BK?

David

