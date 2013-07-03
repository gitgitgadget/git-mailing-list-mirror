From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] [submodule] Add --depth to submodule update/add
Date: Wed, 03 Jul 2013 01:13:12 -0700
Message-ID: <7v4ncchxif.fsf@alter.siamese.dyndns.org>
References: <51D342BB.8080907@web.de>
	<1372801376-32673-1-git-send-email-iveqy@iveqy.com>
	<51D3D20A.5000700@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, hvoigt@hvoigt.net,
	git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jul 03 10:13:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuIBu-0004UF-9v
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 10:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760Ab3GCINW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 04:13:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41461 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754311Ab3GCINT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 04:13:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 450622B5D0;
	Wed,  3 Jul 2013 08:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H25IGYhCHm3fRKDzF0/7W0TkzHw=; b=ow+/N4
	dkTBbf9FGuSb0TbYROZjfFW0eEqFGHiXMWapHceQKacLKhFv7pjuPuUSxnUkXGzX
	swmnqVdakuFBl2hjQ3CDAc+/sl6uMVqACgbKyeX15uUnbXUwvljpSgcq53ONhiC1
	r1hbjnh2YQcFYNPPdxjZ9CKHTmTSFciAJSWmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TddjT8XaSf8X13GFII9vYANneCk0pbRa
	n6egAbR9K4TGzwF7O8+2JdmrUILyhu208j6nO3hxUoMTLEFHTfz2OhqqwNHpoI42
	b23zHARn81zm9hOGaq5HjCVWCksMLwz8wCF4cKUwK3fou0esv5Ym5i+HywJne0P4
	fIYYeaoTU4A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39CAD2B5CF;
	Wed,  3 Jul 2013 08:13:18 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 941372B5C3;
	Wed,  3 Jul 2013 08:13:16 +0000 (UTC)
In-Reply-To: <51D3D20A.5000700@web.de> (Jens Lehmann's message of "Wed, 03 Jul
	2013 09:26:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 69FCFA50-E3B8-11E2-A704-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229463>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 02.07.2013 23:42, schrieb Fredrik Gustafsson:
>> Add the --depth option to the add and update commands of "git submodule",
>> which is then passed on to the clone command. This is useful when the
>> submodule(s) are huge and you're not really interested in anything but
>> the latest commit.
>> 
>> Tests are added and some indention adjustments were made to conform to the
>> rest of the testfile on "submodule update can handle symbolic links in pwd".
>> 
>> Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
>> ---
>> 
>> And I finally thought I'd everything right. I appriciate your reviews.
>> 
>> I left the "" on $5 for consistency as suggested.
>
> Thanks, looking good to me. Passes all tests and the new tests fail
> when the change in the submodule script is reverted.
>
> Acked-by: Jens Lehmann <Jens.Lehmann@web.de>

> The only minor problem is that this patch still does not apply cleanly
> to master, next or pu (I wonder what you based this on ;-).

Thanks; will replace what I queued on 'pu'.
