From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-cvsserver runs hooks/post-receive
Date: Fri, 30 Nov 2007 14:24:27 +0100
Message-ID: <47500F0B.10300@viscovery.net>
References: <1195809174-28142-1-git-send-email-mfwitten@mit.edu> <7v3aup291c.fsf@gitster.siamese.dyndns.org> <7F81126E-5A76-40CA-94BF-82B46C57AFF6@mit.edu> <Pine.LNX.4.64.0711301202230.27959@racer.site> <BDA3CE08-FFA4-4D84-A2FC-5810AAA6EEAB@MIT.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Fri Nov 30 14:25:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iy5rS-0006r3-9j
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 14:24:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754256AbXK3NYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 08:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbXK3NYe
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 08:24:34 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:51469 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbXK3NYd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 08:24:33 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Iy5qL-0003t3-Gu; Fri, 30 Nov 2007 14:23:45 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2D72D54D; Fri, 30 Nov 2007 14:24:27 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <BDA3CE08-FFA4-4D84-A2FC-5810AAA6EEAB@MIT.EDU>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66641>

Michael Witten schrieb:
> On 30 Nov 2007, at 7:03:15 AM, Johannes Schindelin wrote:
>> On Thu, 29 Nov 2007, Michael Witten wrote:
>>> How about turning git-cvsserver into a true middleman, so that it
>>> constructs a 'temporary git working tree' and then does a real git-push
>>> into the final git repository.
>>
>> That would yield a horrible performance.
>>
>> Would be opposed, if a regular cvsserver user,
> 
> How come?
> 
> git-cvsserver it seems already does just that!
> The difference is that it puts objects in place
> by hand, requiring the code to mirror hook calls
> anyway.
> 
> I'm simply proposing that the code be reworked,
> so that cvs commits actually become git pushes,
> so that all future changes to the pushing mechanism
> are automatically handled.

But in order push something, you must first have the commit in a repository. 
How would git-cvsserver do that? For example, by putting objects in place by 
hand. You gain nothing, except that it would push instead of call the hooks 
directly.

-- Hannes
