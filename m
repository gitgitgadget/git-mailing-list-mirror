From: Ben Aveling <bena.001@optusnet.com.au>
Subject: Re: Bisect needing to be at repo top-level?
Date: Fri, 20 Sep 2013 08:46:17 +1000
Message-ID: <523B7EB9.9050809@optusnet.com.au>
References: <CAJTo0LZ=bNNUc8O=bDDOp2vudsc_wL+-nqsXW5r1rq3H7M0e7Q@mail.gmail.com> <xmqqbo3rz7ca.fsf@gitster.dls.corp.google.com> <20130917175813.GA14173@blizzard> <xmqqioxzxnjh.fsf@gitster.dls.corp.google.com> <523AF8EA.6080307@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Lukas Fleischer <git@cryptocrack.de>,
	"Burton\, Ross" <ross.burton@intel.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 20 00:46:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMmzV-0000Fp-EJ
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 00:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754104Ab3ISWqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 18:46:18 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:47172 "EHLO
	mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753669Ab3ISWqR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Sep 2013 18:46:17 -0400
Received: from [10.1.1.4] (d220-237-32-253.mas801.nsw.optusnet.com.au [220.237.32.253])
	(Authenticated sender: bena.001@optusnet.com.au)
	by mail109.syd.optusnet.com.au (Postfix) with ESMTPSA id 334DAD61BA6;
	Fri, 20 Sep 2013 08:46:11 +1000 (EST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <523AF8EA.6080307@optusnet.com.au>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.1 cv=YYGEuWhf c=1 sm=1 tr=0
	a=LAPz/KMPJLswHg0M0s/JXA==:117 a=LAPz/KMPJLswHg0M0s/JXA==:17
	a=PO7r1zJSAAAA:8 a=ifmixZHCRa0A:10 a=GiVg4FNPuBYA:10 a=8nJEP1OIZ-IA:10
	a=ty7lXMcF_wQA:10 a=MVrW9ZMCEKpbLF6Av78A:9 a=wPNLvfGTeEIA:10
	a=ejEf7ntBMaQA:10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235037>

On 19/9/13 23:15, Ben Aveling wrote:
> On 18/9/13 05:20, Junio C Hamano wrote:
>> Lukas Fleischer <git@cryptocrack.de> writes:
>>> why do we allow running git-checkout(1)
>>> from a subdirectory?
>> We may want to check the condition and forbid such a checkout.
> It would probably make sense.
> It might also make sense to relax the check in git bisect somewhat. 
> Currently, even "git bisect help" insists that "You need to run this 
> command from the toplevel of the working tree."

Probably also worth pointing out that whether or not the current shell 
is at toplevel, there can be other processes active in subdirectories.

     Regards, Ben
