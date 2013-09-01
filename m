From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 07/11] Documentation/replace: tell that -f option
 bypasses the type check
Date: Sun, 01 Sep 2013 13:49:00 +0200 (CEST)
Message-ID: <20130901.134900.829124962244710553.chriscool@tuxfamily.org>
References: <20130831190528.26699.33964.chriscool@tuxfamily.org>
	<20130831191215.26699.720.chriscool@tuxfamily.org>
	<70F5C527E29F43A9BE85694F560E01A9@PhilipOakley>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, trast@inf.ethz.ch,
	j6t@kdbg.org
To: philipoakley@iee.org
X-From: git-owner@vger.kernel.org Sun Sep 01 13:49:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VG69v-0000rS-Ie
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 13:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757226Ab3IALtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Sep 2013 07:49:25 -0400
Received: from mail-1y.bbox.fr ([194.158.98.14]:50627 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757182Ab3IALtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Sep 2013 07:49:25 -0400
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 89D6E3A;
	Sun,  1 Sep 2013 13:49:02 +0200 (CEST)
In-Reply-To: <70F5C527E29F43A9BE85694F560E01A9@PhilipOakley>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233585>

From: "Philip Oakley" <philipoakley@iee.org>
>
> From: "Christian Couder" <chriscool@tuxfamily.org>
>>
>> The replaced object and the replacement object must be of the same
>> type.
>> -There is no other restriction on them.
>> +This restriction can be bypassed using `-f`.
>>
>> Unless `-f` is given, the 'replace' reference must not yet exist.
>>
>> +There is no other restriction on the replaced and replacement
>> objects.
> 
> Is this trying to allude to the fact that merge commits may be
> exchanged with non-merge commits? I strongly believe that this ability
> to exchange merge and non-merge commits should be stated _explicitly_
> to counteract the false beliefs that are listed out on the internet.

Maybe we can show that in an example. But I think the patch is quite
clear as it is and should be enough.

If we really want to correct some false beliefs, the best would be to
state the truth where those false beliefs are stated.

> It's probably better stated in a separate patch for that explicit
> purpose to avoid mixed messages within this commit.

If people agree, I will add a another patch with an example in an
EXAMPLE section.

Thanks,
Christian.
