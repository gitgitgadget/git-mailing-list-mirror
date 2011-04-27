From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 10:34:47 -0700
Message-ID: <7vbozr8uo8.fsf@alter.siamese.dyndns.org>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
 <4DB80747.8080401@op5.se>
 <BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
 <4DB82D90.6060200@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Seymour <jon.seymour@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Apr 27 19:35:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF8dl-0004xy-EI
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 19:35:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932726Ab1D0Re6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 13:34:58 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63227 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932679Ab1D0Re6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 13:34:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 64A6E4B07;
	Wed, 27 Apr 2011 13:36:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fGyztvRdihpn8gQtEd53x/XopWc=; b=VcL3nN
	ck4Adq6mlctM0xz3EbCbmQqtRBVl2U+t/tlAGD42hV4O7nTCxWxoEDkpQXjf8vNW
	/N3nDiCx/yd/08tThz1zDzYht3QXF4r/7pw/AjLLdeiTLpwO6vGJnZRMnKgZ5YQx
	9zUZMuMnPxRv1Fja2FaY0ZKuju+IQBSilYpp8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mWKwlIGxF7uGHwyoMKrekFv5XhQlfi1A
	HDQN6/XZS6/2ss0qsPK0YJMYJR3LGoqP0tEMBWgv0Vf0UL+UFSw9b1d50NfQvzi0
	k2NIaKVEMuZI478Tj5JqzTVipi4MKY5pDm3igJw4iDwIhHxjPs9vxZjhoCZZFmxw
	tAxyoLSO5R8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3149B4B06;
	Wed, 27 Apr 2011 13:36:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id ED6DD4AF9; Wed, 27 Apr 2011
 13:36:50 -0400 (EDT)
In-Reply-To: <4DB82D90.6060200@op5.se> (Andreas Ericsson's message of "Wed,
 27 Apr 2011 16:52:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F1B3C26E-70F4-11E0-BB7D-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172252>

Andreas Ericsson <ae@op5.se> writes:

> You're utterly horribly wrong. ...
> ...
> So the complete description would be
>
>   git clone git://somerepo/gitworks
>   cd gitworks
>   make install
>
> and the rest is in developer hands.

Yeah, I like this as the conclusion of this thread ;-).
