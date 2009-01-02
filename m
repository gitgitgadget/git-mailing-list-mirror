From: david@lang.hm
Subject: Re: how to track the history of a line in a file
Date: Fri, 2 Jan 2009 14:58:23 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0901021455390.21567@asgard.lang.hm>
References: <alpine.DEB.1.10.0901021405460.21567@asgard.lang.hm>  <20090102212655.GA24082@coredump.intra.peff.net>  <alpine.DEB.1.10.0901021439080.21567@asgard.lang.hm> <3ab397d0901021349h4ebae0c1g460a0c8abd4ec072@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jeff Whiteside <jeff.m.whiteside@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 02 22:57:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIs1N-00077Z-4R
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 22:57:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757351AbZABV4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 16:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755528AbZABV4J
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 16:56:09 -0500
Received: from mail.lang.hm ([64.81.33.126]:44836 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168AbZABV4I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 16:56:08 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n02Lu17b022943;
	Fri, 2 Jan 2009 13:56:01 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <3ab397d0901021349h4ebae0c1g460a0c8abd4ec072@mail.gmail.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104421>

On Fri, 2 Jan 2009, Jeff Whiteside wrote:

>> -oldline
>> +newline
>>
>> it's a 1-1 correspondence
>>
>> if it's instead
>> -oldline1
>> -oldline2
>> +newline1
>> +newline2
>
> what a neat idea.  i'm going to start malloc'ing 10,000 lines x 120
> chars for each file i add, and edit them so that no new lines replace
> removed lines unless it's intended that they were the same line.

I don't understand your comment. that isn't nessasary to do the tracking 
that I'm needing (you don't have to look at every line, only some of the 
lines that are in the same hunk of the patch as the line(s) you are 
interested in)

in my situation the use case is config files. in them each line is usually 
edited independantly of other lines (with stuff being added, usually, but 
not always on the end)

David Lang
