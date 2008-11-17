From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: fixes to gitweb feature check code
Date: Mon, 17 Nov 2008 02:09:46 -0800
Message-ID: <7vskpqzms5.fsf@gitster.siamese.dyndns.org>
References: <1226759165-6894-1-git-send-email-giuseppe.bilotta@gmail.com>
 <200811170202.27893.jnareb@gmail.com>
 <cb7bb73a0811162210iadb7511rc3474272c8e60c59@mail.gmail.com>
 <200811171028.19807.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>,
	git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 11:11:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L215J-0007de-3s
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 11:11:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290AbYKQKKm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Nov 2008 05:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752336AbYKQKKm
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 05:10:42 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60567 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbYKQKKl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Nov 2008 05:10:41 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2566F16E30;
	Mon, 17 Nov 2008 05:10:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 618AF16DE3; Mon,
 17 Nov 2008 05:09:48 -0500 (EST)
In-Reply-To: <200811171028.19807.jnareb@gmail.com> (Jakub Narebski's message
 of "Mon, 17 Nov 2008 10:28:18 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FBF480AC-B48F-11DD-9247-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101205>

Jakub Narebski <jnareb@gmail.com> writes:

> Dnia poniedzia=C5=82ek 17. listopada 2008 07:10, Giuseppe Bilotta nap=
isa=C5=82:
>> On Mon, Nov 17, 2008 at 2:02 AM, Jakub Narebski <jnareb@gmail.com> w=
rote:
>
> [...]
>> > First, you forgot the signoff, but you have addressed that already=
=2E
>> >
>> >
>> > Second, I thought at first that it would be good for the patch to =
also
>> > simplify %feature hash, using "'default' =3D> 1" instead of curren=
t bit
>> > convoluted "'default' =3D> [1]", at the cost of bit more code for
>> > defensive programming.  But now I think that if it is to be done,
>> > it should be put as separate patch.
>>=20
>> Is this an ACK? 8-D
>
> I'm sorry. Yes, it is.

Are you sure, even with those unnecessary changes from list context
assignments to scalar ones?
