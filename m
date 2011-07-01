From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Wishlist] could git tell which password it is asking when
 asking a password.
Date: Fri, 01 Jul 2011 13:30:49 -0700
Message-ID: <7vfwmpoi9y.fsf@alter.siamese.dyndns.org>
References: <877h82nlua.dlv@debian.org>
 <7v62nmos0k.fsf@alter.siamese.dyndns.org>
 <7v1uy9q5v1.fsf@alter.siamese.dyndns.org>
 <BANLkTi=aAinh=0jxb5MoqVOdUB7zxoy2XdSqk+pdsewLXU62ZA@mail.gmail.com>
 <7vwrg1opov.fsf@alter.siamese.dyndns.org> <87tyb5n6pk.dlv@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?R=C3=A9mi?= Vanicat <vanicat@debian.org>
X-From: git-owner@vger.kernel.org Fri Jul 01 22:30:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QckMd-0002B0-8O
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jul 2011 22:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756004Ab1GAUay convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jul 2011 16:30:54 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48659 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755859Ab1GAUax convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jul 2011 16:30:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 57DC663B8;
	Fri,  1 Jul 2011 16:33:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=EVtQeN7lGiEz
	d7AzlZJErtZYfvI=; b=Tevo5CybH2F6/0gYUXB9JLge6qPzuzwV2ja6ks3aizWy
	j/3Tp8CP0oraLJMuxcrA8sTuACpYD1gF0XSgDd2m9tOZLSgb86vjIZnWJXgnENRA
	CS2K47khYQpCFQg62foOTBeYSxaAoeG/9z0WU8R+Mu/I8WHB95jlv9mRm98Z7W0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Gb/gmy
	YCkxCjm55z3p0QsbyJPrcqARY4zUVR9GenQzHOYwAEzbph6i3uxmcWDVR21pLSDB
	rIgOZ6iabddELw66RTSX3y8bUhLyfhhKeX9QFDeOotBByTm45Qmnnc5KTzOaByxx
	vW0V0CfnM1H6yIMCyZwc2dqfDXYIrnPgVAn44=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2512F63B7;
	Fri,  1 Jul 2011 16:33:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3F3F063B5; Fri,  1 Jul 2011
 16:33:05 -0400 (EDT)
In-Reply-To: <87tyb5n6pk.dlv@debian.org> (=?utf-8?Q?=22R=C3=A9mi?= Vanicat"'s
 message of "Fri, 01 Jul 2011 21:25:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 52E44AA4-A421-11E0-8D98-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176534>

R=C3=A9mi Vanicat <vanicat@debian.org> writes:

> I also believe that having the host name would be useful, both for hu=
man
> (another example would be git remote update when there are several
> remote) and script. =20

Patches welcome, but I have to warn you that the code may _not_ know th=
e
URL at that point in the callchain.
