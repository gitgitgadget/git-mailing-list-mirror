From: Ben Aveling <bena.001@optusnet.com.au>
Subject: Re: Bisect needing to be at repo top-level?
Date: Thu, 19 Sep 2013 23:15:22 +1000
Message-ID: <523AF8EA.6080307@optusnet.com.au>
References: <CAJTo0LZ=bNNUc8O=bDDOp2vudsc_wL+-nqsXW5r1rq3H7M0e7Q@mail.gmail.com> <xmqqbo3rz7ca.fsf@gitster.dls.corp.google.com> <20130917175813.GA14173@blizzard> <xmqqioxzxnjh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Lukas Fleischer <git@cryptocrack.de>,
	"Burton\, Ross" <ross.burton@intel.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 19 15:34:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMeNE-0006Rh-Lf
	for gcvg-git-2@plane.gmane.org; Thu, 19 Sep 2013 15:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150Ab3ISNeP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 09:34:15 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:59839 "EHLO
	mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752067Ab3ISNeN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Sep 2013 09:34:13 -0400
X-Greylist: delayed 1117 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Sep 2013 09:34:12 EDT
Received: from [10.1.1.4] (d220-237-32-253.mas801.nsw.optusnet.com.au [220.237.32.253])
	(Authenticated sender: bena.001@optusnet.com.au)
	by mail108.syd.optusnet.com.au (Postfix) with ESMTPSA id A58A51A360B;
	Thu, 19 Sep 2013 23:15:20 +1000 (EST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <xmqqioxzxnjh.fsf@gitster.dls.corp.google.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.1 cv=YYGEuWhf c=1 sm=1 tr=0
	a=LAPz/KMPJLswHg0M0s/JXA==:117 a=LAPz/KMPJLswHg0M0s/JXA==:17
	a=PO7r1zJSAAAA:8 a=ifmixZHCRa0A:10 a=GiVg4FNPuBYA:10 a=8nJEP1OIZ-IA:10
	a=ty7lXMcF_wQA:10 a=wy8ChtWVXndtrx5INvYA:9 a=wPNLvfGTeEIA:10
	a=ejEf7ntBMaQA:10 a=jG6fhk_rM8AA:10 a=fCqIASJaoyUA:10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235015>

On 18/9/13 05:20, Junio C Hamano wrote:
> Lukas Fleischer <git@cryptocrack.de> writes:
>
>> why do we allow running git-checkout(1)
>> from a subdirectory?
> We may want to check the condition and forbid such a checkout.

It would probably make sense.

It might also make sense to relax the check in git bisect somewhat. 
Currently, even "git bisect help" insists that "You need to run this 
command from the toplevel of the working tree."

Regards, Ben
