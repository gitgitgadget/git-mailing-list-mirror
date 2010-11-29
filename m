From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] web--browse: split valid_tool list
Date: Mon, 29 Nov 2010 12:24:11 -0800
Message-ID: <7vsjyj280k.fsf@alter.siamese.dyndns.org>
References: <1291042075-19983-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1291042075-19983-4-git-send-email-giuseppe.bilotta@gmail.com>
 <20101129164435.GI8037@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 29 21:24:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNAH1-0001ij-Uv
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 21:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477Ab0K2UYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 15:24:21 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48494 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab0K2UYU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 15:24:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 03E6A3794;
	Mon, 29 Nov 2010 15:24:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=GSvj+qLwg6PATjR3sdn/jIl/bUs=; b=TufgLhhJkckh2YZnyty+Jmv
	V7YXWLZionX8CSnLGq9W7Eny9JOvunpisml9D58nOicooPSFS245r53zDrA+Etug
	054Dw2UTvhSKh3paGmFMJ73YZBLCkAPy81bC5v7+rcKUy0iXymN98Nam9crYIq9/
	9lKE1AWjRqnvQJxY10gI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=iiaXb25ZJUx482bWk7q6jCJt10Tj03Tkw2ulODpOJdTI6fzb3
	Ra5RoXhK7X/AcvIzPdOPWmD78+Rp6n/drsyGb+ZS8glllLidTbt5+qFmnbv9yibO
	ywL9xJxAIzjIugeALJuiZs29LIVMJ9DHxkYDyEF3mPj5Zn1yeR17zHitL4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B17F53793;
	Mon, 29 Nov 2010 15:24:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 70069378F; Mon, 29 Nov 2010
 15:24:30 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AE284AC4-FBF6-11DF-AE80-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162426>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Giuseppe Bilotta wrote:
>
>> --- a/git-web--browse.sh
>> +++ b/git-web--browse.sh
>> @@ -31,7 +31,8 @@ valid_custom_tool()
>>  
>>  valid_tool() {
>>  	case "$1" in
>> -	firefox | iceweasel | chrome | google-chrome | chromium | konqueror | w3m | links | lynx | dillo | open | start)
>> +	firefox|iceweasel|chrome|google-chrome|chromium\
>> +	|konqueror|w3m|links|lynx|dillo|open|start)
>
> micronit: I think this looks better as
>
> 	firefox|iceweasel|chrome|google-chrome|chromium| \
> 	konqueror|w3m|links|lynx|dillo|open|start)
>
> , with the | on the end of the first line.

Yes, and with one SP around all "|".

Thanks.
