From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] fetch doc: update note on '+' in front of the refspec
Date: Fri, 30 May 2014 10:54:27 -0700
Message-ID: <xmqqegzb9mp8.fsf@gitster.dls.corp.google.com>
References: <1401403350-7122-1-git-send-email-gitster@pobox.com>
	<1401403350-7122-3-git-send-email-gitster@pobox.com>
	<5388972E.2010008@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri May 30 19:54:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqR0o-0005yu-3J
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 19:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754204AbaE3Ryd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 13:54:33 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57444 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751818AbaE3Ryd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 13:54:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 977C31992E;
	Fri, 30 May 2014 13:54:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/U8OvDcglcsUfVEn2jD7mU1xscA=; b=kBA9PP
	ufMBzYD3o5ZE4DQhomOoSTiv1dtvqm2QaQrpX1VDsk0ndKFGLtcpPLEr66mtIgGR
	wuZF+TVJhUImbl27UNj2/hZQ9PHUOOyvnffETrzCPNJ1796RkRmjo/4xeHjNjgUv
	APrGeMcCdxEN1pNQmEMgpTJ6MPY4SSuS2Kd9E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cZ87nZxB0f7x3HoefkSUrtJyXJEWYQER
	8mESzdkb7Lvpe531sC7+BX2g03fiNbr6M9q+j+sJ32CS2gaY7qrP0Sfq8GCA6kZY
	Wx4ySDz2xFJGA2anxGHJwdfddKbqqQTrF8VZLpcS6xxw+gD06yRXqHY2BmI4K1Ov
	uxsKSLPgbjw=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8E8DF1992C;
	Fri, 30 May 2014 13:54:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2BDC519924;
	Fri, 30 May 2014 13:54:29 -0400 (EDT)
In-Reply-To: <5388972E.2010008@xiplink.com> (Marc Branchaud's message of "Fri,
	30 May 2014 10:35:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7263BC90-E823-11E3-B78F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250456>

Marc Branchaud <marcnarc@xiplink.com> writes:

>> +When the remote branch you want to fetch is known to
>> +be rewound and rebased regularly, it is expected that
>> +the tip of it will not be descendant of the commit that
>> +used to be at its tip the last time you fetched it and
>> +stored in your remote-tracking branch.  You would want
>
> I think the second part of that last sentence might be clearer as
>
> 	it is expected that its new tip will not be a descendant of
> 	its previous tip (as stored in your remote-tracking branch
> 	the last time you fetched).

Yeah, that reads better.  Thanks.

>
> Then start the next sentence with
>
> 	In this case, you would want ....

I somehow find that "in this case" redundant, given that "for such
branches" already limits the scope of the suggestion.  I dunno.

>> +to use the `+` sign to indicate non-fast-forward updates
>> +will be needed for such branches.  There is no way to
>> +determine or declare that a branch will be made available
>> +in a repository with this behavior; the pulling user simply
>>  must know this is the expected usage pattern for a branch.
>>  +
>>  [NOTE]
>> 
