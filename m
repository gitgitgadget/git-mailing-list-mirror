From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Moving (renaming) submodules, recipe/script
Date: Sun, 06 Jan 2013 23:44:48 -0800
Message-ID: <7vwqvpjv2n.fsf@alter.siamese.dyndns.org>
References: <20130107003603.GA25698@odin.tremily.us>
 <20130107013952.GE3823@elie.Belkin> <50EA7269.1080006@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>,
	Peter Collingbourne <peter@pcc.me.uk>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jan 07 08:45:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ts7OX-0007yD-2q
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 08:45:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506Ab3AGHo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 02:44:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61804 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750835Ab3AGHo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 02:44:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4419BAC2B;
	Mon,  7 Jan 2013 02:44:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M9LVgqmHdcvpsvbYYvR6CL1yTn4=; b=Cxj85b
	m3tb/dSPN24i0QkEQeHPsQi0GEA9Vd/BwTF0fcuSWPzdifi3J7iUzqMgrB3+nWyr
	RY7CSYEDqQYmdln2UhvyD/M9fj6wxh3ikZE60E0loHgFfpZo8cLir6CJ4dRPsblZ
	60J/IPHtKhphptSMOoExbiJhGAkw0mriir7dc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QlieqBxX4sFbrGY4zezQcLkQeFExPTua
	upuW47goFtvw0ZwCYBjU4bhp6G4PzC5cmrxbUdvE1HPKMU5pSfYCyLUg21s0ZwZL
	2BBp7o0OIXqMxWmq8JkhJ5afGSXwPiDQeG7aOqTW7Jdir6KfL2eXuhXOPHNW2c9z
	sTwnqQCa5Uo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35AB5AC2A;
	Mon,  7 Jan 2013 02:44:56 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9EA6FAC29; Mon,  7 Jan 2013
 02:44:55 -0500 (EST)
In-Reply-To: <50EA7269.1080006@web.de> (Jens Lehmann's message of "Mon, 07
 Jan 2013 07:59:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2104D00C-589E-11E2-8BDC-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212882>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 07.01.2013 02:39, schrieb Jonathan Nieder:
>> (just cc-ing Jens and Peter, who might be interested)
>
> I´m currently working on teaching mv to move submodules and intend
> to send those patches to the list after finishing submodule deinit.

Thanks for a heads-up.

As a couple of recent "What's cooking" message has stated, I'll
shortly kick jl/submodule-deinit topic out of 'next' back to 'pu',
so please make an update a replacement, not an incremental.  If I
recall the discussion correctly, I think we agreed that deinit
should clear the slate, which means the submodule working tree
should be removed and made into an empty directory without ".git" in
it, and the last round we saw on the list didn't do that.

Thanks.
