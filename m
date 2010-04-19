From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GSoC 2010: "Integrated Web Client for git" proposal
Date: Mon, 19 Apr 2010 00:23:17 -0700
Message-ID: <7vfx2rsy6y.fsf@alter.siamese.dyndns.org>
References: <201004150630.44300.chriscool@tuxfamily.org>
 <201004180246.18263.jnareb@gmail.com> <20100418005917.GO10939@machine.or.cz>
 <201004180324.54722.jnareb@gmail.com> <20100418021223.GP10939@machine.or.cz>
 <n2le72faaa81004180152pb84cef2cn2a7eb95da64420b1@mail.gmail.com>
 <20100418223120.GB3563@machine.or.cz>
 <u2ve72faaa81004182346zdf4bd0b3m3341717b1555c0a9@mail.gmail.com>
 <vpqeiicey0d.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, Sam Vilain <sam@vilain.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 19 09:23:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3lKh-0005SE-DF
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 09:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289Ab0DSHXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 03:23:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43012 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756Ab0DSHXn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 03:23:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CE7EABE89;
	Mon, 19 Apr 2010 03:23:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Uc4C5U2aNcxAdbizFfJhXZCJ2Zg=; b=N9pDvA
	4liwjURoEgbqBrWo1zW6+3j5ceOifpgb5q8hNhrBaRPJvkAkEkYhLsOjRpk7D3qR
	NxhnmDOGkERMVsCWAaWqRHiLA740OEWZY3bWuAk0smFt9GIIug6LopUk7gNLPAE/
	qia7PxXlv1Fv0NpZ5XcpRtZ9+k4Dn57QCBX10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pVWIgUd0N9y5UZff2Lj2JyLEu6fEksrz
	ZvWfOpALVzhOTHIfroloT+k0MfRUxyqlKoqXL96Ez/syk720g+RvPeteFW/9AJyB
	9/P6pvt3HL+cYDyaUWpdQyaAx1M1OLv0Nkvd46nJf2Vto7tyHEqt0sDhOSc1fgxA
	h+L/zLLbs2g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B4094ABE82;
	Mon, 19 Apr 2010 03:23:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 591D5ABE7B; Mon, 19 Apr
 2010 03:23:19 -0400 (EDT)
In-Reply-To: <vpqeiicey0d.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon\, 19 Apr 2010 08\:50\:58 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 74857D8C-4B84-11DF-84A2-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145270>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Pavan Kumar Sunkara <pavan.sss1991@gmail.com> writes:
>
>> Session management reduces the length of URL
>
> ... but OTOH, GET parameters allow painlessly cut-and-paste-able URLs,
> which is in my opinion a must-have for gitweb.

These self-contained URL are used in bookmarks and e-mails to the mailing
list.  I think "the length of URL" is a red herring at best, and shortened
URL that is not self-contained is not an advantage at all.

On the other hand, a proposal about giving multiple clients access to
their own individual server-side checkouts (ala "workspace" in DELTA-V)
would require some mechanism to maintain the state on the server end, and
session management would be one ingredient necessary to achieve that.

When I heard that somebody wants to do a "write support" in gitweb, I
naturally thought the proposal was about implementing RFC3253 using git as
a backend.  I think it would be a reasonable thing to do (as opposed to
coming up with an ad-hoc "write support" mechanism that is not compatible
with anybody else), but on the other hand it might be a bit too ambitious
for a one-student summer project.
