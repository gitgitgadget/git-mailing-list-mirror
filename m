From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2012, #06; Sun, 15)
Date: Mon, 16 Apr 2012 01:20:19 -0700
Message-ID: <7vlilwxf3w.fsf@alter.siamese.dyndns.org>
References: <7vpqb8xjj9.fsf@alter.siamese.dyndns.org>
 <4F8BE14D.7090501@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Mon Apr 16 10:20:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJhAi-0000D5-O9
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 10:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909Ab2DPIUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 04:20:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45861 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750833Ab2DPIUX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 04:20:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D00F4E63;
	Mon, 16 Apr 2012 04:20:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lJjXBRlyZ+8/uM0fZGg/iGXK+qc=; b=pTu1TI
	H/XBnLI7SUU8XviI1YHqbwxdxFWkV2tnmSCqGuEzcYGLoOovV9IJ4rArsiKz61Vw
	I5UN6SDRmCtE9wAZ/5vmgkthP540Nudl+QGt1BihXATykB5aREV9Ttya9kEGRJtt
	mlRN/7UXX8DtQRo/p/QlhuZgwGOtr5IT1sNwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uHP/6C+O3Z9EaNj0T3cAy7yBs2fgajw3
	h/MZVs++JrnMTAv7FaZV+cQYGbfbkzUeaZCwThTP1e41DWa1V+3ZUpoi/XJM5ETa
	2Xd0BkUJFo6useKdlewTDl7igNoD1xmK7G1HOJ2YSLvJ1VnPPrZ/DZNle4oRpNIc
	uOGBveSsc7o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 428B94E62;
	Mon, 16 Apr 2012 04:20:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D86714E61; Mon, 16 Apr 2012
 04:20:20 -0400 (EDT)
In-Reply-To: <4F8BE14D.7090501@seap.minhap.es> (Nelson Benitez Leon's message
 of "Mon, 16 Apr 2012 11:07:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 01E120EA-879D-11E1-BF02-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195603>

Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:

> On 04/16/2012 08:44 AM, Junio C Hamano wrote:
>>
>> * nl/http-proxy-more (2012-04-14) 6 commits
>>  - http: fix proxy authentication
>>  - http: rename HTTP_REAUTH to HTTP_AUTH_RETRY
>>  - http: Avoid limit of retrying request only twice
>>  - http: handle proxy authentication failure (error 407)
>>  - http: handle proxy proactive authentication
>>  - http: try http_proxy env var when http.proxy config option is not set
>> 
>> The code to talk to http proxies learn to use the same credential
>> API used to talk to the final http destinations.  This still needs
>> to peek into $ENV{HTTPS_PROXY}.
>
> Hi Junio, so this needs some more work, but I don't recall the thread 
> about it, could you point it to me or explain me what is still lacking.

I am reasonably sure that all the messages on the thread Peff and I worked
out the fix-up at the tip of the series shown above were Cc'ed to you.
