From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Wait for git diff to finish in git difftool
Date: Wed, 22 Apr 2009 21:21:02 -0700
Message-ID: <7v4owgyp8x.fsf@gitster.siamese.dyndns.org>
References: <81b0412b0904220027t7afd1ed7xc57c479ef8cdb6b9@mail.gmail.com>
 <20090422082652.GA32698@gmail.com>
 <81b0412b0904220404o30ce1413kcc4dcea1fa822841@mail.gmail.com>
 <7vr5zk346d.fsf@gitster.siamese.dyndns.org>
 <81b0412b0904221340o6b2f1474oed2ad12e4f68cff3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	charles@hashpling.org, markus.heidelberg@web.de
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 06:22:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwqSX-0005xN-4g
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 06:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbZDWEVO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Apr 2009 00:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbZDWEVO
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 00:21:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45749 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbZDWEVN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Apr 2009 00:21:13 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 677BBAD809;
	Thu, 23 Apr 2009 00:21:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 781CEAD7F5; Thu,
 23 Apr 2009 00:21:04 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2DA86DD0-2FBE-11DE-BF83-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117293>

Alex Riesen <raa.lkml@gmail.com> writes:

> 2009/4/22 Junio C Hamano <gitster@pobox.com>:
>>> Yes, FWIW. I intentionally stopped signing off patches for
>>> Windows, ActiveState Perl and Cygwin: they usually harm the
>>> rest of the world, while just allowing Windows users limp along.
>>
>> I have to wonder if you are doing that with the full understanding o=
f what
>> Signed-off-by means. =C2=A0I do not think the provenance of your pat=
ch is
>> affected by your distaste towards the system it has effects in any w=
ay.
>
> I'm trying to avoid being associated with development for the platfor=
m :)
>
> Frankly, I just always forget about it. The patches to my windows
> repository are mostly just hacks to either make it pass test suite or
> workaround another, the platforms specific, stupidity. Not sure anyon=
e
> is actually interested in them (because, I repeat, they mostly hurt
> everyone else, while making the platforms port "a little working").

What do you really mean?  These patches add maintenance burden but its
benefit nobody would care about, and should not be applied?
