From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] submodule: fix handling of supermodules with
 relative origin URLs
Date: Sat, 19 May 2012 22:16:44 -0700
Message-ID: <7v4nrbbfer.fsf@alter.siamese.dyndns.org>
References: <1337402403-7546-1-git-send-email-jon.seymour@gmail.com>
 <1337402403-7546-2-git-send-email-jon.seymour@gmail.com>
 <4FB7ECCF.9020403@web.de>
 <CAH3AnrrqiXqdHHGZPyOPJ3Zend5JrQX0rKV+pz_mjs3SDjv9DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 20 07:16:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVyVg-0005Wr-3W
	for gcvg-git-2@plane.gmane.org; Sun, 20 May 2012 07:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853Ab2ETFQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 May 2012 01:16:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49198 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795Ab2ETFQq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2012 01:16:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 701B56191;
	Sun, 20 May 2012 01:16:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TFBRLBWgvkocNXmzLCgG4/cADRI=; b=sgs5l3
	d6a6edTqMawDxOwPQ64FSnCyk6K/L3FO9G8W3/QjBEA58ksf8iNzzhRXQ1KPGg9I
	qyHr5iJyJEZSQOsfvuiewUOEUUZyX7XPHR2dJZcCy3ImN8QpKo2uZzWFTUwH+gzx
	8qU5Vj1sN0rKBHS4kOIareGLcOQXvtwsBkq2w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BeMyuCzfDXISSc4Al/LGomDC51fUuWLS
	Q52Bk3kW+CYxI7gI48TanouY+rS0fCrKafwXDv8/Ua9rqjEwmDhhwpjSnlrGK3XI
	YRKkglx1dBHQgwVTUq0/nwM7llMDTYh9MbbOodRK8FZbOmUjbtxQsGem1gu3ZsaL
	7W3eCLrK5T8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 666836190;
	Sun, 20 May 2012 01:16:46 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D8F4A618F; Sun, 20 May 2012
 01:16:45 -0400 (EDT)
In-Reply-To: <CAH3AnrrqiXqdHHGZPyOPJ3Zend5JrQX0rKV+pz_mjs3SDjv9DA@mail.gmail.com> (Jon
 Seymour's message of "Sun, 20 May 2012 08:51:08 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FE795D1A-A23A-11E1-9396-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198050>

Jon Seymour <jon.seymour@gmail.com> writes:

> On Sun, May 20, 2012 at 4:56 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> Am 19.05.2012 06:40, schrieb Jon Seymour:
>>
>> Just a small nit: I'd prefer to replace the 4 occurrences of the term
>> "supermodule" with "superproject".
>
> Sure. I can't argue with precedent, of course, but I guess I was
> favouring the consistency in the suffixes used with sub and super.

We fairly consistently say (even outside the documentation---for example,
listen to the TechTalk Linus gave in May 2007) "superproject" and never
"supermodule".  You can tell people who were not paying attention when
they say "supermodule" ;-).
