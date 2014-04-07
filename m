From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2014, #01; Fri, 4)
Date: Mon, 07 Apr 2014 09:40:16 -0700
Message-ID: <xmqq8urhnle7.fsf@gitster.dls.corp.google.com>
References: <xmqq4n28q0ad.fsf@gitster.dls.corp.google.com>
	<533FCA92.8060006@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Stefan Zager <szager@chromium.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Apr 07 18:40:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXCav-0007Hi-5T
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 18:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755520AbaDGQkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 12:40:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57797 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754665AbaDGQkT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 12:40:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB23978F1C;
	Mon,  7 Apr 2014 12:40:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=STz1wqBhpRxiKzrlVQ+rtWdnAws=; b=tNZ79d
	vYZ8oc1cY9GbKausuzjcxxSULEn18zrG11DD4IFcgygtD5vywdNRJMzxo705stCr
	T+ktXGCr4qBf6TNFw5HHySI1G/7aKpxKz1pFW/vGRn0Na4csqiMevG5izBHJL+pg
	h1lDc31QeCQLfvPIbDcY2e6Y2iWpHSg/08/vw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jk+adxr04U9UvmEOQ2dcdoRXEK6umP3t
	NbVU6p+2eD4ZoRVNyxtFgG/wnWnAd23FRyQgrKWfOP4/JDk31oH9u8/Q1RowaXZO
	VfTf9sicmDUqnGBsWPOJ8GF9qnk/kFYNVv238k7XlkwHfNBPZY03ucJUU8cCkt0m
	a2rbrxSlukQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8AB578F1B;
	Mon,  7 Apr 2014 12:40:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C20AD78F15;
	Mon,  7 Apr 2014 12:40:17 -0400 (EDT)
In-Reply-To: <533FCA92.8060006@kdbg.org> (Johannes Sixt's message of "Sat, 05
	Apr 2014 11:19:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4D4367AA-BE73-11E3-ABEC-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245865>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 04.04.2014 22:58, schrieb Junio C Hamano:
>> * sz/mingw-index-pack-threaded (2014-03-19) 1 commit
>>  - Enable index-pack threading in msysgit.
>> 
>>  What is the status of this topic?  A failure report exists
>>  ($gmane/245170), and I am aware of Duy's $gmane/245034 but that was
>>  where the discussion stalled.  Is everybody waiting for everybody
>>  else to get the discussion unstuck?
>
> I still have to cross-check Duy's patch. I'll hopefully get to it in the
> next days and report back.

Thanks.
