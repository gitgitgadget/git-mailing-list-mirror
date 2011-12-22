From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] i18n of multi-line messages
Date: Wed, 21 Dec 2011 23:00:09 -0800
Message-ID: <7vipl9drba.fsf@alter.siamese.dyndns.org>
References: <7vr4zxeaz5.fsf@alter.siamese.dyndns.org>
 <4EF2D436.3080303@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Dec 22 08:00:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdcdY-0004jn-S5
	for gcvg-git-2@lo.gmane.org; Thu, 22 Dec 2011 08:00:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925Ab1LVHAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Dec 2011 02:00:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49347 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751343Ab1LVHAN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2011 02:00:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE38D3AB9;
	Thu, 22 Dec 2011 02:00:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lID4uwMsVwJR/DEtWD5fepUwTEU=; b=hNKLV2
	U0ZZwV1WAco/mWVLyZ49oqfmF86qN19Uh1n3WQYfzhTQXwHcFJKL8NaGBF3nSDMx
	UdGGfu66Zv09lt+CrTyOZ1WnluTSzzZf2+61Rkxato8uoWeD623/YjczJcHzGhhj
	SgVvw5SOacvX2SbyKfT8brtCCLwbUMSxa8yGI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f0tJkB1WbMVBFNWHG4jDBQOOJkPHzBPW
	sGyg4E2uGQ7BnkUc5OFYTj0J3jJAmaHn5TMqLgM7DNcM4zLCeguM8JKT8fUitMzV
	UGMcj1fXXGEnHIgEr93PuGlVpIKLwABxlgMbmMzj9qnQZV1xAXP6AF2pMQirLzAc
	l2TsfMBbGu8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A54903AB8;
	Thu, 22 Dec 2011 02:00:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44CF03AB5; Thu, 22 Dec 2011
 02:00:11 -0500 (EST)
In-Reply-To: <4EF2D436.3080303@viscovery.net> (Johannes Sixt's message of
 "Thu, 22 Dec 2011 07:54:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9736D182-2C6A-11E1-983C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187599>

Johannes Sixt <j.sixt@viscovery.net> writes:

>
>> +		advise(_("Fix them up in the work tree,\n"
>> +			 "and then use 'git add/rm <file>' as\n"
>> +			 "appropriate to mark resolution and make a commit,\n"
>> +			 "or use 'git commit -a'."));
>
> <rant>
> Can people please pay attention how they break multi-line messages? In
> ...
> </rant>

No need for ranting; please just make it so. The above is literal
translation without changing the current output.
