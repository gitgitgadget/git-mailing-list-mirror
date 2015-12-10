From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2015, #03; Thu, 10)
Date: Thu, 10 Dec 2015 15:33:41 -0800
Message-ID: <xmqqd1udhoa2.fsf@gitster.mtv.corp.google.com>
References: <xmqqmvthhqgf.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaA6Lo1W-SudX6v5styyGrX-igGC7i=u5AYOvFYK0DOGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 00:33:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7Aia-0004Zq-Rt
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 00:33:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbbLJXdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2015 18:33:44 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56072 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751172AbbLJXdn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2015 18:33:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CCAB933760;
	Thu, 10 Dec 2015 18:33:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3JjpS84DMSCL6lL5nPNN73LY+mg=; b=IQbM4B
	LwlxX7hfFPykMbZBvck6MA4uehe2HvKa6OPgcQaD0cX/yr7tSIkSmdBRjEgbUCQz
	SHx0sbDx1snMTDdzZoMNg0crOT+jUpeQ4ESMbyv41NfP3KMVs4EUGWi4Gt+g2GZN
	kHYSmrTsiu674FdnXQ0VyzXPHVqtxe/o4WOio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eppIohoimmgwmeZX6A50XyTle8oX+7fC
	9OEEeigDYFUwpJqxaz+V5fREOft5zKxVk/H4QEff/bFpH1lzGuC+pSC96k6y5/De
	0WaZzE926JIpa6lCLXYs3rXWVo3I01LmegZocP2ZFG9E14sF6XAP+HX3ObjeollZ
	rgy/QCsExzA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C3E673375F;
	Thu, 10 Dec 2015 18:33:42 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4B46A3375E;
	Thu, 10 Dec 2015 18:33:42 -0500 (EST)
In-Reply-To: <CAGZ79kaA6Lo1W-SudX6v5styyGrX-igGC7i=u5AYOvFYK0DOGA@mail.gmail.com>
	(Stefan Beller's message of "Thu, 10 Dec 2015 15:25:46 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 72B790F0-9F96-11E5-ACD8-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282241>

Stefan Beller <sbeller@google.com> writes:

>> * sb/submodule-parallel-fetch (2015-11-24) 17 commits
>>   (merged to 'next' on 2015-12-04 at 2c5ea47)
>>  + run-command: detect finished children by closed pipe rather than waitpid
>>...
>>  Waiting for review.
>
> What kind of review do you wait for?

This I think was inherited from previous issues.

The cleanest response that would move these topics forward is for
area experts to step up and say "This has been discussed and Acks
are given here (cf. $URL)" ;-)

Thanks.
