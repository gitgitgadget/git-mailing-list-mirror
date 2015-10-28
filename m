From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] object name: introduce '^{/!-<negative pattern>}' notation
Date: Wed, 28 Oct 2015 10:52:14 -0700
Message-ID: <xmqq7fm6lw35.fsf@gitster.mtv.corp.google.com>
References: <1433550295-15098-1-git-send-email-wmpalmer@gmail.com>
	<1433550295-15098-3-git-send-email-wmpalmer@gmail.com>
	<xmqqbngqcfxd.fsf@gitster.dls.corp.google.com>
	<CAAKF_ub5c+2vVmG161O6gnUUeEcNfDUMU=mtn+k0T8bC-9ZHPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 18:52:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrUta-0005IW-CK
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 18:52:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755585AbbJ1RwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 13:52:18 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53324 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755117AbbJ1RwR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 13:52:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 12BE723362;
	Wed, 28 Oct 2015 13:52:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gPXiV86H356cEz34bUUJJdQrFyw=; b=RFyi/D
	AmxUUetOOlXPLclNo7j3K9kUkNv/HeaXRF+8FyGN2nn3SY1l2j1/E8MPD3eXDxMS
	qK5qlp7XHwreEt0EHrbN3KI5pAD8YJBMnc3NN5WpzUYZAIM+HCoV8Z/ZqCcRgIqS
	1/ybNYTNS/8ji4W4QayBmJdYD9TQa6VMdCYXk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AAX3xHbS9S1HRSEUlDeOX1lOwqh8KXRF
	x+2xoOCfvXJN558RsZgXOvLCB/SvXycGINdRnhNKA+uGJt398MJCaa4t8ettEtKN
	8K2hHoPnkfOC+Uu/U1La0qDbUE5Dp40q0ryKrCgz2e2Jdgl5pidC16kXdzDnTyeb
	hoM7hzveVFg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0898423360;
	Wed, 28 Oct 2015 13:52:17 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 084CD2335E;
	Wed, 28 Oct 2015 13:52:15 -0400 (EDT)
In-Reply-To: <CAAKF_ub5c+2vVmG161O6gnUUeEcNfDUMU=mtn+k0T8bC-9ZHPw@mail.gmail.com>
	(Will Palmer's message of "Tue, 9 Jun 2015 19:14:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A02F11D2-7D9C-11E5-BE06-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280386>

Will Palmer <wmpalmer@gmail.com> writes:

> In summary: it looks like I'll be sending another one.

Has anything happened to this topic since then?  I am asking
primarily because I want to decide if I should discard
wp/sha1-name-negative-match topic from my tree [*1*].

I think what it attempts to do is a worthy thing, and it is shame to
see the initial implementation and review cycles we have spent so
far go to waste.


[Footnote]

*1* Not that my dropping a topic from 'pu' means very much; a
    dropped topic can still be submitted and requeued after all.
