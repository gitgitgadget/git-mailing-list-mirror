From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Wait for git diff to finish in git difftool
Date: Thu, 23 Apr 2009 01:26:44 -0700
Message-ID: <7vtz4fwzaz.fsf@gitster.siamese.dyndns.org>
References: <81b0412b0904220027t7afd1ed7xc57c479ef8cdb6b9@mail.gmail.com>
 <20090422082652.GA32698@gmail.com>
 <81b0412b0904220404o30ce1413kcc4dcea1fa822841@mail.gmail.com>
 <7vr5zk346d.fsf@gitster.siamese.dyndns.org>
 <81b0412b0904221340o6b2f1474oed2ad12e4f68cff3@mail.gmail.com>
 <7v4owgyp8x.fsf@gitster.siamese.dyndns.org>
 <81b0412b0904230033n35f1117fmea4432a2f2140d25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	charles@hashpling.org, markus.heidelberg@web.de
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 10:32:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwuIK-0001dv-Eh
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 10:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754185AbZDWI06 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Apr 2009 04:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753654AbZDWI05
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 04:26:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50569 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbZDWI04 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Apr 2009 04:26:56 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 43A04AC608;
	Thu, 23 Apr 2009 04:26:55 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5F17DAC607; Thu,
 23 Apr 2009 04:26:48 -0400 (EDT)
In-Reply-To: <81b0412b0904230033n35f1117fmea4432a2f2140d25@mail.gmail.com>
 (Alex Riesen's message of "Thu, 23 Apr 2009 09:33:48 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8115439A-2FE0-11DE-9C07-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117309>

Alex Riesen <raa.lkml@gmail.com> writes:

> 2009/4/23 Junio C Hamano <gitster@pobox.com>:
>> Alex Riesen <raa.lkml@gmail.com> writes:
>>> Frankly, I just always forget about it. The patches to my windows
>>> repository are mostly just hacks to either make it pass test suite =
or
>>> workaround another, the platforms specific, stupidity. Not sure any=
one
>>> is actually interested in them (because, I repeat, they mostly hurt
>>> everyone else, while making the platforms port "a little working").
>>
>> What do you really mean? =C2=A0These patches add maintenance burden =
but its
>> benefit nobody would care about, and should not be applied?
>
> Maintenance _and_ run-time. It is your decision, but yes, I kind of h=
ate
> the idea of them being applied.
>
> In plain words: please don't apply MY patches with words "Windows"
> or "Cygwin" in message body, unless I beg you to (and even then,
> consider me heavily drugged).

Hmm, what's the point then for me to spend time looking at them posted =
on
the list?
