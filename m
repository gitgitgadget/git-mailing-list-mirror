From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Odd merge behaviour involving reverts
Date: Fri, 19 Dec 2008 15:51:38 -0800
Message-ID: <7vwsdv67w5.fsf@gitster.siamese.dyndns.org>
References: <7vljub7oko.fsf@gitster.siamese.dyndns.org>
 <7vocz8a6zk.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0812181534310.14014@localhost.localdomain>
 <1229642734.5770.25.camel@rotwang.fnordora.org>
 <20081219124452.6117@nanako3.lavabit.com>
 <20081220064532.6117@nanako3.lavabit.com>
 <20081220081238.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Alan <alan@clueserver.org>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sat Dec 20 00:53:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDp9h-0004AG-7T
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 00:53:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162AbYLSXvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 18:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752918AbYLSXvs
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 18:51:48 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61779 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424AbYLSXvr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 18:51:47 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id ADA2D89F63;
	Fri, 19 Dec 2008 18:51:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 99C8889F59; Fri,
 19 Dec 2008 18:51:40 -0500 (EST)
In-Reply-To: <20081220081238.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Sat, 20 Dec 2008 08:12:38 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FE548D18-CE27-11DD-9FFE-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103605>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>:
>
>> Nanako Shiraishi <nanako3@lavabit.com> writes:
>>
>>> I think your explanation will help people if we make it part of the
>>> documentation.  Especially because two different cases need two
>>> different recovery methods, and people need to learn which is which.
>>
>> Sure.  It needs copyediting to make it readable standalone by not
>> mentioning "your misunderstanding", inlining "earlier Linus's suggestion",
>> etc., though.
>>
>> Patches welcome ;-)
>
> Okay, I'll send one later.

Thanks.
