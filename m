From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] option-strings: use OPT_FILENAME
Date: Mon, 23 Feb 2015 12:31:22 -0800
Message-ID: <xmqqioess739.fsf@gitster.dls.corp.google.com>
References: <20150223144214.GA31624@peff.net>
	<3af5c93959b22dc327d7fb3974d36764906c2969.1424707497.git.git@drmicha.warpmail.net>
	<xmqqfv9wtpha.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
	<pclouds@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 23 21:31:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPzf7-0003DV-JH
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 21:31:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbbBWUbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 15:31:25 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50046 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751875AbbBWUbY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 15:31:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 553B93AAF0;
	Mon, 23 Feb 2015 15:31:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8mtkfcJNxSP/hARiSsMWqWPcCms=; b=Pp0fCU
	bD63/QuJcmD+40ROwoUq9p7xIi6DTBeiNufphz+lrrkmQa1cChjZld5qx5WuXE8P
	0gBp3isUk9XBnVm3w6XSshT16hEBnPhyeqLa/sbMDFlQhvnxrwGrbm8CLzAK4Vmq
	trflogCxLDjsr6yZ8v7KCsgj4VoMoZEuhwjX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=epWjuOz/iPF/JKM6x8y255hvMDnrFNCS
	p2KI+nyoeL20xDoa7ydQZSKiPrTb4Uh1cxvbW+0Selb0EdcmxQ1ccWyWwhKVxMnW
	Bik33EEHsQGdVWJ9YRNMzYtI52yF+b0o6GVmOk9iJ2esPzLgwAN1pwC8Rzor+bWN
	Rt4PdRxHBII=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C0453AAEF;
	Mon, 23 Feb 2015 15:31:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 924F33AAEE;
	Mon, 23 Feb 2015 15:31:23 -0500 (EST)
In-Reply-To: <xmqqfv9wtpha.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 23 Feb 2015 11:08:49 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EEF14372-BB9A-11E4-B193-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264298>

Junio C Hamano <gitster@pobox.com> writes:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>> Some commands use OPT_STRING to specify a <file> argument. Let them use
>> OPT_FILENAME so that they can profit from path prefixing.
>
> If the existing code that takes string actually already works
> correctly, they must be doing the necessary prefixing on their own,
> but I do not see in this patch a hunk that removes such a custom
> prefixing.  Puzzled...
>
> It may be that some of them do not work correctly from subdirectory
> and this change fixes bugs, but are all of them like that, or is
> this patch fixing some of them while breaking some others?

Ahh, I see Peff already went over the changes in the patch and
sifted them into good, questionable and bad bins.

Thanks; I'll shut up and await for a reroll ;-)
