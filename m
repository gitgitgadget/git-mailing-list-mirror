From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Remote's 'currently active branch' not HEAD?
Date: Tue, 03 Sep 2013 08:33:39 -0700
Message-ID: <xmqqd2opvs18.fsf@gitster.dls.corp.google.com>
References: <20130903104652.GA5813@inner.h.apk.li>
	<20130903114831.GA8559@inner.h.apk.li>
	<20130903123733.GR12966@inner.h.apk.li>
	<20130903130250.GB20459@pc.elego.de>
	<20130903135034.GS12966@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Schubert <mschub@elegosoft.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 03 17:33:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGsc1-0001Rm-AC
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 17:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756599Ab3ICPdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 11:33:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56804 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754722Ab3ICPdo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 11:33:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71C653E1F1;
	Tue,  3 Sep 2013 15:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IKWhYynfghKzDaFSqrsusAihtWw=; b=vc9b7U
	o5qpKlsv3DMiHs2TTurGgIzQLZ/eqB0lB1Z2Q94eVpv4hl5iiCt9qAQw7pLl/Mk6
	ho2tdCuQPp+N5/pV8HvLp9E8IHa5wjDQOBo9QWBAp1GT2NCd44VIvJK63QTdFZ2a
	TXryGhgyGoE7rgtKJODTQ2QP98rXHKevKUkY4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jVwZZSk8jQNyqmL7GpjX8tU2yZ2OHDW7
	9sqbPHHSZrN8bWZy83pyUkLYseosHJdRHrjPtXJV2WsHNW3hlY6fA/CiYGZfwL9F
	5r+fDMbC4TYBNcpDH7xF6CgfmX7gto5OYe2mR+TyEQogt9C/HxulbvH8Mb7z/ul9
	7cy0fWfjVMs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE4353E1ED;
	Tue,  3 Sep 2013 15:33:42 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B1DB43E1E6;
	Tue,  3 Sep 2013 15:33:41 +0000 (UTC)
In-Reply-To: <20130903135034.GS12966@inner.h.apk.li> (Andreas Krey's message
	of "Tue, 3 Sep 2013 15:50:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3635E69C-14AE-11E3-97B9-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233730>

Andreas Krey <a.krey@gmx.de> writes:

> On Tue, 03 Sep 2013 15:02:50 +0000, Michael Schubert wrote:
> ...
>> > happen to have the HEAD *commit* as their tip.
>> 
>> Yes, it picks the first of those:
>> 
>> http://thread.gmane.org/gmane.comp.version-control.git/168144
>
> Thanks for the pointer.
>
> And pity, the patches didn't make it that time either...

And the key article in that discussion by Peff points to
http://thread.gmane.org/gmane.comp.version-control.git/102039 with
"I had some complaints at the time, but re-reading it I don't see
anything that would prevent us from revisiting the topic now."
Reading the patch series from 2008 again, I do agree with J6t's
comment that it should be just a regular capability, i.e. like what
Peff suggests in his comment on [PATCH 5/6 (v2)], but other than
that, I do not see anything that would prevent us from revisiting
the topic now, either.
