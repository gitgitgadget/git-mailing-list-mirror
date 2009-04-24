From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/2] Documentation: replace sha1 by SHA-1
Date: Fri, 24 Apr 2009 17:30:46 +0200
Message-ID: <49F1DB26.1070605@drmicha.warpmail.net>
References: <1240584575-5702-1-git-send-email-git@drmicha.warpmail.net> <1240584575-5702-2-git-send-email-git@drmicha.warpmail.net> <49F1D857.7060100@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Apr 24 17:33:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxNOi-0005DL-R2
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 17:33:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752787AbZDXPaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 11:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbZDXPaz
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 11:30:55 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:45323 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752138AbZDXPay (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Apr 2009 11:30:54 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 248B7322B31;
	Fri, 24 Apr 2009 11:30:54 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 24 Apr 2009 11:30:54 -0400
X-Sasl-enc: e/4W/MssqEwUrRVYG1DKsPs3NM0OIYZAxy/NmGDdjihf 1240587053
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 651263CF29;
	Fri, 24 Apr 2009 11:30:53 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090420 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <49F1D857.7060100@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117457>

Johannes Sixt venit, vidit, dixit 24.04.2009 17:18:
> Michael J Gruber schrieb:
>> diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
>> index 287c4fc..73e1dc4 100644
>> --- a/Documentation/git-fsck.txt
>> +++ b/Documentation/git-fsck.txt
> 
> These hunks are in a section that talks about fsck's diagnostics.

Yes. I didn't notice they were actual warning message quotes though.
Thanks for catching it.

> 
>> +missing SHA-1 directory '<dir>'::
>> +	The directory holding the SHA-1 objects is missing.
> 
> This message does not present in the code anywhere; it could be removed
> from this list.

Yes, that should be a patch before 1/2 then.

> 
>> +SHA-1 mismatch <object>::
> 
> And this one occurs in the code, and so it should be changed as well.

It comes from object.c rather than builtin-fsck.c, right?

I guess it shows that I should go through the code as well. But it's not
a good time for that now... (rc) I'll revert that specific change then.

Michael
