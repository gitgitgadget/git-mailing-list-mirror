From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2013, #02; Mon, 9)
Date: Tue, 10 Sep 2013 11:31:55 -0700
Message-ID: <xmqqk3ioy1d0.fsf@gitster.dls.corp.google.com>
References: <xmqqa9jl38ve.fsf@gitster.dls.corp.google.com>
	<522F486A.1000705@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 10 20:32:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJSjP-0001rH-0B
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 20:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223Ab3IJScC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 14:32:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45856 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159Ab3IJScB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 14:32:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83F3440CC2;
	Tue, 10 Sep 2013 18:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f97r/zH0uqW8d87qZO7KfRKCL4E=; b=XywEbm
	NT4H/JKPgfa8CkXu7d8EGNuH4fITlkuga9z8JFQuFTNYX+bXRAmovPk9g2HhlEix
	Qg7gK1dPW9cVbI9JQgDBJ3H8puZgZMpDltLSHdlsOhRHS4KFFcgABSCH8g83H4NS
	1JYW05bx2fviPMnwhWXVwzqBzR2tpTWX7jMXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NxnY7QYUeL5FhTNBNdo/Ifj5aWzAPWHr
	N93LPyy57/GxQ+xEYEPfSIjIFivvy6Uxw1TguEEwQm7xh5Jh/hhuEyNUIfYzqkVP
	7E9B4qT6hCCx3IW93GPjUEVEz8619DLH04gzimMcWJLmhGZxknr6nJONpBaKZAC0
	3c0mS/dafhk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29EB940CC0;
	Tue, 10 Sep 2013 18:32:00 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 49BD340CBA;
	Tue, 10 Sep 2013 18:31:58 +0000 (UTC)
In-Reply-To: <522F486A.1000705@web.de> (Jens Lehmann's message of "Tue, 10 Sep
	2013 18:27:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 46C468E6-1A47-11E3-BDFC-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234469>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 10.09.2013 00:53, schrieb Junio C Hamano:
>> * bc/submodule-status-ignored (2013-09-04) 2 commits
>>  - submodule: don't print status output with ignore=all
>>  - submodule: fix confusing variable name
>> 
>>  Originally merged to 'next' on 2013-08-22
>> 
>>  Will merge to 'next'.
>
> I propose to cook this some time in next to give submodule
> users who have configured ignore=all the opportunity to test
> and comment on that. And as Matthieu noticed the documentation
> is not terribly clear here, I'll prepare one or two patches to
> fix that which should go in together with these changes.

OK.

Thanks.
