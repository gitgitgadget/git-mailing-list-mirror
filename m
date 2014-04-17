From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2014, #03; Fri, 11)
Date: Thu, 17 Apr 2014 10:52:45 -0700
Message-ID: <xmqqsipbetci.fsf@gitster.dls.corp.google.com>
References: <xmqq1tx3qzel.fsf@gitster.dls.corp.google.com>
	<20140417165247.GQ21805@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Apr 17 19:52:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaqUY-00073c-Cc
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 19:52:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbaDQRwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 13:52:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39917 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001AbaDQRws (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 13:52:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 590697A47B;
	Thu, 17 Apr 2014 13:52:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=me3Y21uYRk2iU5TWJVH4jq46t7U=; b=N2Nhp4
	rN9G11Bi0bL4cAa6TijHuzVo3jhRzDad9Y1B02R4KNawNdhNx95o8sbF6d36mXpc
	XKWAyKJoheattkwdwUNq4v3gptYcODMx05naPrLazCOETnBhn54xURNcb6/lN1/z
	sdUK3zoc9kbrWURg54PGnYVC1skFZwdTSIbnk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iRyRU+HIPO3BcVOxoaDgENTueK2FdOkM
	yZdQh/uCNiN4arajMxvZ5u4jsaGVSP/gdP9CO1tKxsbGDVsx/V+d/oV4XiN0eM1i
	1HguJb5WC2aN8YtwqHRPK4YZb8en74sm328NBEwTF2fIzcUZoVkdsMgYG5ENop6v
	rXBPC07edv8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42C517A47A;
	Thu, 17 Apr 2014 13:52:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BB1357A477;
	Thu, 17 Apr 2014 13:52:46 -0400 (EDT)
In-Reply-To: <20140417165247.GQ21805@odin.tremily.us> (W. Trevor King's
	message of "Thu, 17 Apr 2014 09:52:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1596DFC4-C659-11E3-B9CF-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246429>

"W. Trevor King" <wking@tremily.us> writes:

> On Fri, Apr 11, 2014 at 03:22:58PM -0700, Junio C Hamano wrote:
>> * jl/submodule-recursive-checkout (2013-12-26) 5 commits
>>  - Teach checkout to recursively checkout submodules
>>  - submodule: teach unpack_trees() to update submodules
>>  - submodule: teach unpack_trees() to repopulate submodules
>>  - submodule: teach unpack_trees() to remove submodule contents
>>  - submodule: prepare for recursive checkout of submodules
>> 
>>  Expecting a reroll.
>
> I think this was rerolled with Jens' v2 [1]:
>
>   * jl/submodule-recursive-checkout (2014-02-03) 9 commits
>   - submodule: prepare for recursive checkout of submodules
>   - Teach reset the --[no-]recurse-submodules option
>   - Teach checkout the --[no-]recurse-submodules option
>   - Teach merge the --[no-]recurse-submodules option
>   - Teach bisect--helper the --[no-]recurse-submodules option
>   - Teach bisect the --[no-]recurse-submodules option
>   - submodule: teach unpack_trees() to remove submodule contents
>   - submodule: teach unpack_trees() to repopulate submodules
>   - submodule: teach unpack_trees() to update submodules
>
> Cheers,
> Trevor
>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/241455

Thanks, I'll add a reference to the RFC v2, but it also had
significant discussion threads on it, so it would still be in
"Expecting a reroll" state anyway.
