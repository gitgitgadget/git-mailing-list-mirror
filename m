From: Sergei Organov <osv@javad.com>
Subject: Re: [PATCH] git-rev-parse.txt: clarify meaning of rev~ and rev~0.
Date: Fri, 14 Mar 2008 22:11:58 +0300
Message-ID: <87prtxm875.fsf@osv.gnss.ru>
References: <87wso5mcs7.fsf@osv.gnss.ru>
	<alpine.LFD.1.00.0803141141240.3557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 14 20:13:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaFLB-000388-TF
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 20:13:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501AbYCNTMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 15:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753407AbYCNTMj
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 15:12:39 -0400
Received: from javad.com ([216.122.176.236]:2727 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753132AbYCNTMj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 15:12:39 -0400
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id m2EJC4V14290;
	Fri, 14 Mar 2008 19:12:04 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1JaFJu-0000Gy-KQ; Fri, 14 Mar 2008 22:11:58 +0300
In-Reply-To: <alpine.LFD.1.00.0803141141240.3557@woody.linux-foundation.org> (Linus Torvalds's message of "Fri\, 14 Mar 2008 11\:49\:40 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77275>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, 14 Mar 2008, Sergei Organov wrote:
>>
>> +                      ...  'rev{tilde}' is equivalent to 'rev{tilde}0'
>> +  which in turn is equivalent to 'rev'.
>
> I'd actually prefer to just fix that. 
>
> I think it would make more sense to have the same guarantees that rev^ 
> has, namely to always return a commit. I would also suggest that not 
> giving a number would have the same effect of defaulting to 1, not 0.
>
> Right now it's a bit illogical, but at least it's an _undocumented_ 
> illogical behaviour. If we document it, we should fix it and document the 
> logical behaviour instead, no?
>

I entirely agree. I just took (maybe erroneously) Junio's answer to my
original question as "this behavior is by design", assuming some
rationale behind it, so submitted the above patch to documentation.

-- Sergei.
