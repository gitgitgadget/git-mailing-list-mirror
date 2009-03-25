From: Junio C Hamano <gitster@pobox.com>
Subject: Re: reverting initial commit
Date: Wed, 25 Mar 2009 11:40:57 -0700
Message-ID: <7vbprp30p2.fsf@gitster.siamese.dyndns.org>
References: <49CA7428.70400@obry.net>
 <7v1vsl4fxo.fsf@gitster.siamese.dyndns.org> <49CA799A.6020807@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Wed Mar 25 19:43:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmY4F-0002lR-Ji
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 19:43:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757324AbZCYSlI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2009 14:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756181AbZCYSlF
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 14:41:05 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51580 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755581AbZCYSlE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 14:41:04 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 751D3948A;
	Wed, 25 Mar 2009 14:41:01 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CE5F89489; Wed,
 25 Mar 2009 14:40:58 -0400 (EDT)
In-Reply-To: <49CA799A.6020807@obry.net> (Pascal Obry's message of "Wed, 25
 Mar 2009 19:36:10 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7D290F4E-196C-11DE-AA0B-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114644>

Pascal Obry <pascal@obry.net> writes:

> Junio C Hamano a =C3=A9crit :
>> That's not even an revert. =20
>
> Right.
>
>> Can't you simply amend it away?
>>=20
>> 	$ git rm not-this-file
>>         $ git commit --amend
>
> Right, I've done that. But the fact that un-committing the initial
> commit was not possible seemed strange to me. At least the error mess=
age
> should be clearer, don't you think?

"You said HEAD^ but there is no such thing?  What are you talking about=
?"

That sounds clear enough to me, but if you have a patch to improve it,
please send it in.
