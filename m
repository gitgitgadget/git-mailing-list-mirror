From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git's tests have depended on Perl since at least 2006
Date: Fri, 13 Aug 2010 15:45:07 -0700
Message-ID: <7v4oeyjfnw.fsf@alter.siamese.dyndns.org>
References: <AANLkTim9aNtFdwM5m-FB_LWX96es2DR_9mU3rGcV4dME@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 14 00:45:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok30B-0003of-Kl
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 00:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755703Ab0HMWpP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 18:45:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57270 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755621Ab0HMWpO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Aug 2010 18:45:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 847A5CD1D2;
	Fri, 13 Aug 2010 18:45:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=x9zZAeICv1oZ
	BCRFiVvD3oh8Ymk=; b=plxb8XQhEntgJZz9TytUQLuemin7fTuRW+WUfvtCf22S
	0xFsteBoyFzGoLBrMb3jo90VQQBL8iQBp4pewtVSWgStydVDWXD7dweXOPSP31ps
	nZ5RDUzpboozf4szaqg4joVuIM530UrHxhg+nh+OWCQ2SKP0QYiSczN6FAmiSLo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=O1fqFJ
	tdxGuy7kR32f+NMQ5Lw/EJZTAaWptPH3aNb7kaSU+5NIak03G0HqRU9wxrVOi936
	TSgcufsoME3Xk+1NvxECXY34tpL46fi2C9wJQ/MsGvuTgTrd4KKdAcEsHlKlKDP9
	0ovejqbLTPgFWLEZkfdewgomnC0Gw2rdmmP5o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 63397CD1D1;
	Fri, 13 Aug 2010 18:45:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C06FCCD1D0; Fri, 13 Aug
 2010 18:45:08 -0400 (EDT)
In-Reply-To: <AANLkTim9aNtFdwM5m-FB_LWX96es2DR_9mU3rGcV4dME@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri\, 13 Aug
 2010 21\:25\:10 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6E354D96-A72C-11DF-8B3B-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153522>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> This is just an interesting datapoint, but Git's test suite currently
> crashes and burns if you don't have a perl in your $PATH, no matter i=
f
> you've compiled with NO_PERL=3DYesPlease or not. This has been the ca=
se
> since at least 2006, or v1.3.0-rc1~13^2~34.

I'd suggest you not to go overboard on this.  NO_PERL=3DYesPlease is
primarily about the deployment environment.  The person who is building
and packaging git may have perl on her development box.
