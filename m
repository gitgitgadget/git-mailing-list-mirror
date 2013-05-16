From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] remote-bzr: reorganize the way 'wanted' works
Date: Thu, 16 May 2013 16:38:17 -0700
Message-ID: <7vfvxm3386.fsf@alter.siamese.dyndns.org>
References: <1368693407-21267-1-git-send-email-felipe.contreras@gmail.com>
	<1368693407-21267-8-git-send-email-felipe.contreras@gmail.com>
	<7v7giy6aeh.fsf@alter.siamese.dyndns.org>
	<CAMP44s32kNXuijxfibejzOne+5-RsXofyr+CY85NTCy4QTOAaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 17 01:38:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud7ke-0005tq-HL
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 01:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754887Ab3EPXiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 19:38:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36598 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754714Ab3EPXiU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 19:38:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B98631F20B;
	Thu, 16 May 2013 23:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yeL4pV1q59yqbFVfbT5j7tSdU1E=; b=AsBfJP
	z8Wo1gYPOmc/waXdt/7nWe1UrCSMYgE0PgCl/AoZqF7ijqnRbYweX0qes2KuC6Jf
	VpV8HPVZ9X4xlUuP/OgYVyqyLIXqifG2PvroTVAFmkmfUM9RmMN0+IUr+08nmDtT
	kXh+Gh+rGQjVrLL5eCxsMIfCmfkBjeBYFuzwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t1vAdBX6MHmwWC8X6vWy2YQOuJIyuhGA
	VEvwjX3gryBCybJGsb/8voAzw6eAlNBtAPlWX9ptZi/CktF1JLeXto1F6RGeDSPJ
	M3St3zNmpZeAJ4HNReUPDPN7y4j2oGX6ZyQCJlkRBxn1pgKP9Po7uHblwRDDAs6l
	qZ4ixaKWv4g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD6251F20A;
	Thu, 16 May 2013 23:38:19 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 318BA1F206;
	Thu, 16 May 2013 23:38:19 +0000 (UTC)
In-Reply-To: <CAMP44s32kNXuijxfibejzOne+5-RsXofyr+CY85NTCy4QTOAaw@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 16 May 2013 18:09:53 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B047FAE8-BE81-11E2-9BE5-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224636>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> I'll stop at 6/8 for now, as this is not urgent before the 1.8.3
>> release.
>
> I can send the conflict fix, or I can send a v2 of the 47-something
> patches. I already have a few fixes on top that might make sense to
> squash. Up to you.

Probably neither at this point in the pre-1.8.3 cycle; a reroll that
includes these 6 or 8 patches as its early part after the next cycle
begins would be a good way to go.
