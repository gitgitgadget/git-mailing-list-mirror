From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-am: Ignore whitespace before patches
Date: Thu, 12 Aug 2010 14:34:51 -0700
Message-ID: <7vocd7qzus.fsf@alter.siamese.dyndns.org>
References: <1273944188-9472-1-git-send-email-avarab@gmail.com>
 <1281556645-23361-1-git-send-email-avarab@gmail.com>
 <AANLkTinDHvwHLZfj6DDPtV39Z2xhDZREiqwdt5cjiaLP@mail.gmail.com>
 <20100812202457.GC2029@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 23:35:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjfQd-0002Rw-DP
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 23:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760751Ab0HLVfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 17:35:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55137 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754711Ab0HLVfE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 17:35:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EA7CCDE51;
	Thu, 12 Aug 2010 17:35:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mhE4WpQJ46GgrfoywDGub3g0RhU=; b=lM0lWM
	CatTQOdTIWwJmUBIDBiEKjGfy4ZfTrfddshDY5PFxBMEFn3/I7M9iyCM5790RQRy
	w5kyrXv1Tu+oZUlzeXZB44vbqPYrWBmv46xqY2BC5b2qF0qmnkzJ+FpEX4x+FE/T
	lnkFoTEhAs1/7ODenGnGTKdYlOsRY+2gHULj8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EkmM0HBdkXMewxCkLi3nA5yKQZFYYMNy
	gnMbc1IF606CIb5m9Xe6Tn+R8BUQMzmV1TU0fRpHT0tpXFq5rg6vpWSUMO+ClHre
	PnQDSZZW84KU47uDu6MdS+f3EdP2UcQ8aR532tYYyy7vitvHZvZKo5kEwPUCsnuW
	KPIBIFSWp+I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E90F6CDE4F;
	Thu, 12 Aug 2010 17:34:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1BF85CDE4E; Thu, 12 Aug
 2010 17:34:52 -0400 (EDT)
In-Reply-To: <20100812202457.GC2029@burratino> (Jonathan Nieder's message of
 "Thu\, 12 Aug 2010 15\:24\:57 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 74617452-A659-11DF-A546-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153422>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jay Soffian wrote:
>
>> Perhaps, before making git-am less strict, we should modify
>> format-patch to include a sha1 of the diff output so that corruption
>> can be reliably detected by git-am.
>
> I seem to remember a discussion about hand-munging and rebasing of
> patches suggesting such verification might be a bad idea[1].  I dunno.
>
> [1] but all a search turned up is this:
> http://thread.gmane.org/gmane.comp.version-control.git/136008/focus=136234

You meant this perhaps.

http://thread.gmane.org/gmane.comp.version-control.git/138084/focus=138100
