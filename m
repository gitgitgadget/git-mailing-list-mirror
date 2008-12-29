From: Junio C Hamano <gitster@pobox.com>
Subject: Re: some git-commands --help don't act like git commands --help
Date: Mon, 29 Dec 2008 01:54:31 -0800
Message-ID: <7vfxk7cnmw.fsf@gitster.siamese.dyndns.org>
References: <87iqp333bk.fsf@jidanni.org>
 <20081229175305.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jidanni@jidanni.org, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Dec 29 10:56:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHEqx-0006i6-Fu
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 10:56:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753549AbYL2Jyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 04:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752982AbYL2Jyl
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 04:54:41 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37689 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910AbYL2Jyl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 04:54:41 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7332E8B426;
	Mon, 29 Dec 2008 04:54:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 924E88B424; Mon,
 29 Dec 2008 04:54:33 -0500 (EST)
In-Reply-To: <20081229175305.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Mon, 29 Dec 2008 17:53:05 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B4190616-D58E-11DD-9620-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104093>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting jidanni@jidanni.org:
>
>> Hmmm, some git-commands --help act just like git commands --help,
>> $ git commit --help 2>&1|wc -l
>> 336
>> $ git-commit --help 2>&1|wc -l
>> 336
>>
>> But others don't
>> $ git am --help 2>&1|wc -l
>> 152
>> $ git-am --help 2>&1|wc -l
>> 19
>
> Thank you for your observation; what do you want to do about it?
>
> Are you complaining that some commands do not have customized description that is not as long as the full manual page but not as terse as the short help "-h" output? Or are you complaining some other commands do not give you full manual pages for "--help"?

I think he is comparing "git am" and "git-am" the latter of which is now
deprecated and largely removed from the end user.

IOW, the seeming inconsistency is not an issue anymore in practice in the
post 1.6.0 era.
