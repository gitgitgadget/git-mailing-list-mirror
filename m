From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: Use 'First Paragraph' instead of 'First
 Line'.
Date: Thu, 13 Sep 2012 14:15:16 -0700
Message-ID: <7vwqzx62vv.fsf@alter.siamese.dyndns.org>
References: <5051D4A0.4060608@codeweavers.com>
 <7vehm593v8.fsf@alter.siamese.dyndns.org> <505248C3.7000803@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeremy White <jwhite@codeweavers.com>
X-From: git-owner@vger.kernel.org Thu Sep 13 23:15:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCGkx-00044o-Ld
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 23:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271Ab2IMVPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 17:15:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34566 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751113Ab2IMVPT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 17:15:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5B19843C;
	Thu, 13 Sep 2012 17:15:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ysZmQ8sj9T6fEGWa1uSAUajIAD4=; b=uBTq7m
	NHZwgZ6s4G0DqufrfWylplyRplEyNV6/o3Xuk3K64FC9lzfOnXEcRsR2RULsYuVd
	PMH288af3e5mpV8YGh2adejhfUbrCq1KYAc8AIh+OUJgJBPAxlB0VCR5BPzR/ND/
	huQvryN4uVB2v+KDAI5fXDbAY7hjIzN684fG4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=al858VUuvsQicv1M6mIn74065fOlRJHQ
	fkvctxbOf3ElvCqU72fCPAbDvUf29VOYOdavUQgos2Zgs9GTU6XE2XHLl0i/EqBY
	wj86t1KIySprF3RTcXXuyMvyzPWn0mqH0wcxQTRf9c8nsv2Cq3Ln+V+2HoO5HWPR
	LEDon/JNRyA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92FB4843B;
	Thu, 13 Sep 2012 17:15:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F03D98439; Thu, 13 Sep 2012
 17:15:17 -0400 (EDT)
In-Reply-To: <505248C3.7000803@codeweavers.com> (Jeremy White's message of
 "Thu, 13 Sep 2012 15:57:39 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1E451874-FDE8-11E1-B983-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205425>

Jeremy White <jwhite@codeweavers.com> writes:

> Thanks for the feedback; new patch inbound.  Minor nits:
>
>>> diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
>>> index f7815e9..92f97e6 100644
>>> --- a/Documentation/gitcore-tutorial.txt
>>> +++ b/Documentation/gitcore-tutorial.txt
>>> @@ -956,7 +956,7 @@ $ git show-branch --topo-order --more=1 master mybranch
>>>  ------------------------------------------------
>>>  
>>>  The first two lines indicate that it is showing the two branches
>>> -and the first line of the commit log message from their
>>> +and the first paragraph of the commit log message from their
>>>  top-of-the-tree commits, you are currently on `master` branch
>>>  (notice the asterisk `\*` character), and the first column for
>>>  the later output lines is used to show commits contained in the
>> 
>> Ditto.
>
> I did not substantially alter this. The emphasis of this section
> is on the broader show-branch output, and belaboring the subject would
> be distracting and unnecessary imho.

Yeah, but if that is the focus of this part of the documentation,
wouldn't a patch to update "the first line" with something more
generic like "title of the commit" be more appropriate?
