From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: --replace-all with one argument exits properly 
 with a better message.
Date: Sat, 14 Mar 2009 18:53:24 -0700
Message-ID: <7vab7na6wb.fsf@gitster.siamese.dyndns.org>
References: <1236998552.9952.2.camel@luis-desktop>
 <7vtz5vakrp.fsf@gitster.siamese.dyndns.org>
 <94a0d4530903141434w2fb8aa28we087465482a12e41@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carlos Rica <jasampler@gmail.com>, git@vger.kernel.org,
	johannes.schindelin@gmx.de
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 02:56:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LifaU-00056A-3e
	for gcvg-git-2@gmane.org; Sun, 15 Mar 2009 02:56:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753005AbZCOBxe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Mar 2009 21:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbZCOBxd
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 21:53:33 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54329 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbZCOBxd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Mar 2009 21:53:33 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1A70B6DB7;
	Sat, 14 Mar 2009 21:53:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5908D6DB5; Sat,
 14 Mar 2009 21:53:26 -0400 (EDT)
In-Reply-To: <94a0d4530903141434w2fb8aa28we087465482a12e41@mail.gmail.com>
 (Felipe Contreras's message of "Sat, 14 Mar 2009 23:34:55 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 15CCEDF4-1104-11DE-BCD8-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113271>

=46elipe Contreras <felipe.contreras@gmail.com> writes:

> On Sat, Mar 14, 2009 at 10:53 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>> Carlos Rica <jasampler@gmail.com> writes:
>>
>>> 'config --replace-all ONE_ARG' was being treated as 'config NAME VA=
LUE',
>>> showing the error "key does not contain a section: --replace-all".
>>
>> Hmm, I am getting "error: wrong number of arguments" followed by the=
 long
>> and somewhat annoying "usage" from the parseopt table dump.
>
> If you find it annoying why don't you remove the usage?

Because the primary target audience of the help text is not me?

>> Can you work with Felipe to see if this is still needed, or needs to=
 be
>> fixed in a different way? =C2=A0It could be that your tests may alre=
ady pass
>> over there on 'next'. =C2=A0I didn't check.
>
> The new code is already checking correctly that --replace-all needs a=
t
> least two arguments. However, the "usage" is incorrect and of course
> the test will come in handy.

So perhaps you can pick a part of it and send in an update to your
parseoptification series?  I think the series is ready for 'master'
sometime next week if not sooner.
