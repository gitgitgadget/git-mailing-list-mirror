From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git pull behavior changed?
Date: Thu, 22 Apr 2010 01:16:10 -0700
Message-ID: <7vy6gf52d1.fsf@alter.siamese.dyndns.org>
References: <u2z3abd05a91004211413rcd2440fdq7946ef4764b24362@mail.gmail.com>
 <v2hfabb9a1e1004211422ybbf47ef0gd5dfd1791eb03c16@mail.gmail.com>
 <y2p3abd05a91004211455r30d13932t92dfbedff581b9a1@mail.gmail.com>
 <vpqsk6omppf.fsf@bauges.imag.fr>
 <h2o3abd05a91004211504pfc2de8b7sa37c9c0a4dd14f57@mail.gmail.com>
 <86tyr4v12n.fsf@red.stonehenge.com>
 <u2n3abd05a91004211657v3dcdaf40j3608f3d8f59c4c1b@mail.gmail.com>
 <20100422081055.GG3563@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Aghiles <aghilesk@gmail.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	git list <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Apr 22 10:16:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4raO-0007ae-M5
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 10:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898Ab0DVIQ3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Apr 2010 04:16:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41212 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014Ab0DVIQ1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Apr 2010 04:16:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B50021D6C;
	Thu, 22 Apr 2010 04:16:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=MCa8m+UBlu/O
	3FDIH7Xvykscf9c=; b=ElynqB0uo+bsgbAeSrYG1lIwjI5W0efCvzkJklujBcrQ
	uPo/62QO9nZxJwtrxK2rZRntz1IyPc17/kiG9XdawSqeVZ2xARiSkpE6tcF0b+vA
	dnf2p1bIZg9WIjec226rDrV/i9px/02zQHSDQwewefIE4fOMUriRh+0XWFe3B84=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=davJJ2
	ZTch8dVPbwQWBwtaIhgIY2T++r/8pe0VKozIKv9kFbSMvIzZGVaLuQQhDOo8dP9H
	SrxTWnV8SrgA1jAaYv6rssPVz/llQSjMCO3yfWE8qxlQ0K+PsXAnHrqKIJtLwuUS
	PtUKSep8/WcTXvZ52byl+sxnZ9A38gcqEXLXc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C53D1D67;
	Thu, 22 Apr 2010 04:16:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D45FC1D5C; Thu, 22 Apr
 2010 04:16:11 -0400 (EDT)
In-Reply-To: <20100422081055.GG3563@machine.or.cz> (Petr Baudis's message of
 "Thu\, 22 Apr 2010 10\:10\:56 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 544D0E30-4DE7-11DF-9013-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145509>

Petr Baudis <pasky@suse.cz> writes:

> On Wed, Apr 21, 2010 at 07:57:17PM -0400, Aghiles wrote:
>> On Wed, Apr 21, 2010, Randal L. Schwartz  wrote:
>> > =C2=A0 =C2=A0git checkout -b test origin/test
> ...
> So, do I understand it right that there is still no canonical syntax =
to
> check out local branch tracking a remote one of the same name, withou=
t
> spelling out the branch name twice?

Only if you don't count Dscho's DWIM.

    $ git checkout tr/word-diff
    Branch tr/word-diff set up to track remote branch tr/word-diff from=
 origin.
    Switched to a new branch 'tr/word-diff'
