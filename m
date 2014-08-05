From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v2.1.0-rc1
Date: Tue, 05 Aug 2014 09:30:24 -0700
Message-ID: <xmqqtx5qq4pr.fsf@gitster.dls.corp.google.com>
References: <xmqqy4v3q43r.fsf@gitster.dls.corp.google.com>
	<53E01A3D.8070504@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: linux-kernel-owner@vger.kernel.org Tue Aug 05 18:30:50 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1XEhdS-0001Lz-Bv
	for glk-linux-kernel-3@plane.gmane.org; Tue, 05 Aug 2014 18:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755865AbaHEQah (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 5 Aug 2014 12:30:37 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55253 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753276AbaHEQag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2014 12:30:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E54DD2D124;
	Tue,  5 Aug 2014 12:30:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cysL3v14Oj6YpRD0JsLxo6DxXrc=; b=e9q1Gp
	t2AR6K30Wo2SG7FekHorN/ekbvovlQZu3sMQB328ug9H+rWEZlwtNc85fSOUCVUp
	qvWa0mKDpJfXXTTO2NUcBcBaX2DSWeahKqOMEiopOlivXO+sdfqbux+8n8Q+lCb0
	DJ56MvjMFP4gGJ/NQUp4/q6wXtAn08JmzooO8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rfkyINnjn/jKUPUkwLQhIixmVJNzPcHk
	hyIGHqCnHi5G8uA1xIBuc53KqfMiEuLJHJOvUI9NkVjtMhhHE8pDdEngbEnZhTU/
	dQZdRt6KNds/RS0abA6yDl2a7MpLdmV0gN/AmnkxWflfqa5d2bsaMhkUg75+algy
	dtBTJKQ/HPA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CD5ED2D123;
	Tue,  5 Aug 2014 12:30:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2C2232D110;
	Tue,  5 Aug 2014 12:30:27 -0400 (EDT)
In-Reply-To: <53E01A3D.8070504@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Tue, 05 Aug 2014 00:41:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CECD6D2C-1CBD-11E4-9B1D-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254810>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> On 04/08/14 23:31, Junio C Hamano wrote:
>> 
>>  * The leaf function to check validity of a refname format has been
>>    micro-optimized, using SSE2 instructions when available.  A few
>>    breakages during its development have been caught and fixed already
>>    but there might remain some more still; please test and report if
>>    you find any.
>
> This has been removed.

Thanks for a reminder.  Will drop.
