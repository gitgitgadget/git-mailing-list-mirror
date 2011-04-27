From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] t/README: unify documentation of test function args
Date: Tue, 26 Apr 2011 21:44:38 -0700
Message-ID: <7vei4ob8w9.fsf@alter.siamese.dyndns.org>
References: <7vzknei0vn.fsf@alter.siamese.dyndns.org>
 <1303814006-4109-1-git-send-email-misfire@debugon.org>
 <1303839041.18603.17.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mathias Lafeldt <misfire@debugon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Wed Apr 27 06:44:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEwcS-0006w2-VT
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 06:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961Ab1D0Eow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 00:44:52 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52668 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989Ab1D0Eov (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 00:44:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 62E4B5A0B;
	Wed, 27 Apr 2011 00:46:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tzyY+hXWaayJCq/gsBHuEKNWgUk=; b=V9mv96
	2Vcqs94oD2W7hrOp9u+CDoi2i4YdVHPkJUlnR9Gkp2niDWrbtlHtgQO5JT5fN0U6
	DXABl0ILYv0ZwR2BljroANrChTHD+0j5bNf9wW+s5FQPhdaMvuRpwhHZYhvp2CfM
	/Unjqw7RKBM0cVyo88UwejY71fobvZ+qvIEQs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sYDR5D26IFnPSbz1183HEJ++ThyWVFsJ
	ivfkv8yD6vjI2iQZZt+lOnfn1e4Egi+6e8GBrGspJa/14ZPfLRBF2RWaaR/1s93E
	qqETcE96e0mR9jkk6TzaxBwYmWxwt9CsTkr9gz6R6H4Fpf9+Lll1aTQsBNbW549c
	FWRtTJ6afqs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3051F5A0A;
	Wed, 27 Apr 2011 00:46:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 052C25A08; Wed, 27 Apr 2011
 00:46:42 -0400 (EDT)
In-Reply-To: <1303839041.18603.17.camel@drew-northup.unet.maine.edu> (Drew
 Northup's message of "Tue, 26 Apr 2011 13:30:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5BA0146E-7089-11E0-821C-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172164>

Drew Northup <drew.northup@maine.edu> writes:

> On Tue, 2011-04-26 at 12:33 +0200, Mathias Lafeldt wrote:
>
>> @@ -389,7 +389,7 @@ library for your script to use.
>>  	    'git-write-tree should be able to write an empty tree.' \
>>  	    'tree=$(git-write-tree)'
>>  
>> -   If you supply three parameters the first will be taken to be a
>> +   If you supply three parameters, the first will be taken to be a
>>     prerequisite, see the test_set_prereq and test_have_prereq
>>     documentation below:
>
> As "If you supply three parameters" is not an introductory clause to a
> larger complete thought in the following few words, the additional comma
> is unnecessary.

Makes sense.

On the other hand, "see the ... below" is a separate sentence, and it
deserves to have something stronger than a comma in front of it.  I've
queued with a minor fixup.

Thanks.
