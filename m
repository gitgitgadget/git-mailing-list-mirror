From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-rev-parse.txt: clarify meaning of rev~ and rev~0.
Date: Fri, 14 Mar 2008 13:13:23 -0700
Message-ID: <7vfxutoyho.fsf@gitster.siamese.dyndns.org>
References: <87wso5mcs7.fsf@osv.gnss.ru>
 <alpine.LFD.1.00.0803141141240.3557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergei Organov <osv@javad.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 14 21:14:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaGIM-0004iN-Rz
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 21:14:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755308AbYCNUNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 16:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754930AbYCNUNf
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 16:13:35 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36641 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754890AbYCNUNf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 16:13:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 95C7F32D1;
	Fri, 14 Mar 2008 16:13:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 5CA8D32D0; Fri, 14 Mar 2008 16:13:28 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.00.0803141141240.3557@woody.linux-foundation.org>
 (Linus Torvalds's message of "Fri, 14 Mar 2008 11:49:40 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77278>

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

Yeah, I like it.  Not that I looked at your patch yet (which needs to wait
til evening), but I agree with the intent.
