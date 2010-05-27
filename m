From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: [PATCH] Man page section reference should be in uppercase
Date: Thu, 27 May 2010 12:50:17 -0700
Message-ID: <7v4ohtp1ja.fsf@alter.siamese.dyndns.org>
References: <1274756484-27867-1-git-send-email-ayiehere@gmail.com>
 <1274813122.1178.8.camel@localhost.localdomain>
 <AANLkTilKSLCGMgHwB4TdojtemnxYLrGsAJGHQcLJNVwL@mail.gmail.com>
 <AANLkTingglKSMHOcHXTg3hGF_czcFsnWLTd3GuSp-Mm6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?RMOpdmFpIFRhbcOhcw==?= <devait@vnet.hu>
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 27 21:50:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHj6B-0004aV-AU
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 21:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759471Ab0E0Tua convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 May 2010 15:50:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45108 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759330Ab0E0Tu3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 May 2010 15:50:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7347AB7A97;
	Thu, 27 May 2010 15:50:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=bq6rGMUsbzLz
	K6oVaePuGjdAuzU=; b=Inr0hqhq06kJE7y5+8qRUG3d92Krh4ujQHHf2MCqPQ7f
	Ko12lBz0XPMAj4492H+fLW70vtXMWDN/z0Gw9rsn7uaFzqbJ1xYA9QPGrAtniI80
	gvUerAJ9uigub0hA06quHyNzipp8fatbUkwJs4tFDLLShP58WqNxKtGe+C/Oflc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rriLS+
	ZXV8CZurr3053ksBpJzWT9caZaIY8Tg0tMJG/w+OBQGYB8FYAPtreVLsSpf+aNDs
	cSWCJuI21VwNVp3llEwZgwwC01zLGN/uDXHGxTlfWp33EUPsQ0Wl8tzlU0AHaLHe
	hLzhDXxvW+5fsrUawrV1qC6D7HTD7xcSyiPjY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CA28B7A93;
	Thu, 27 May 2010 15:50:23 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F0FCB7A82; Thu, 27 May
 2010 15:50:19 -0400 (EDT)
In-Reply-To: <AANLkTingglKSMHOcHXTg3hGF_czcFsnWLTd3GuSp-Mm6@mail.gmail.com>
 (Nazri Ramliy's message of "Wed\, 26 May 2010 16\:33\:26 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 16796F2E-69C9-11DF-9F18-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147895>

Nazri Ramliy <ayiehere@gmail.com> writes:

> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git grep '"[A-z ]\+" section'
>
> See how all of them use all-caps when referring to man page sections.

"TEMPLATE DIRECTORY" and "SPECIFYING REVISIONS" are shown quite often, =
but
there are some others that deviate from your "all caps" norm.  For
example, 'see the "Configuration Mechanism" section' appears in git.txt
and it matches how the section header that is referred to is spelled.

Also the section headers referred to in caps in the current documentati=
on
set are indeed spelled in caps (grep for "TEMPLATE DIRECTORY" in
Documentation/git-init.txt for example).

Having said that, I wouldn't mind if the theme of your improvement were=
 to
spell manual section *headers* in caps, instead of leaving the actual
section names still spelled as "Note about fast-forwards" and upcasing
only the reference(s) to it, which can make things inconsistent dependi=
ng
on how the documentation is typeset (e.g. I read the documentation sour=
ce
as text files).  Obviously the resulting patchset may also have to upca=
se
e.g. "combined diff format" section header to bring consistency into th=
e
whole documentation set, not just the "Note about fast-forwards" sectio=
n.
