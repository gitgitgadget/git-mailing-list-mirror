From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Fixing volatile HEAD in push.default = current
Date: Tue, 21 May 2013 13:04:10 -0700
Message-ID: <7vy5b8m75x.fsf@alter.siamese.dyndns.org>
References: <1369160600-22337-1-git-send-email-artagnon@gmail.com>
	<7v38tgno2k.fsf@alter.siamese.dyndns.org>
	<CALkWK0m3QP_eE14y8UoJ+HeFzkKM=1nVKAnYJcTrwQMp+Atphg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 21 22:04:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UesnD-0006Tz-I4
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 22:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303Ab3EUUEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 16:04:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64138 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751760Ab3EUUEP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 16:04:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D79F20B7C;
	Tue, 21 May 2013 20:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zxnS3GU/JztguADid1GPV5TFjck=; b=Co2HRp
	tMh5iy9MXTMDybqT5N16SxMDvqWzqPPz9TpUn9HYwVZ6kLHUc//D/RroiCUNyZuC
	e4dT7tGCL5rlU2o/pGl4Xx+amf/A72kg2/eN+JKhvD8X7GmgpQ03ANzkYPWBkbEW
	TBzxJiQ6ufrklZSe4cOLXU1UtCr3w4IqXsljg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ldC+fisgr7vmO/QV1BQmwRxL2ltJZJn+
	5XIs2vBarb6g/l3ruic2krDtv6r4BT7zjdzw/7sXOeAcAjcnuuyGjMQRtnu+aNNx
	IFJ5Y0nUzeP13RohbWaVYV8zljNkIBQ/8mViZ0x+0G823YIdb+LttRzkAMhIJYYO
	EoCbhgoT/aQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20C6F20B7B;
	Tue, 21 May 2013 20:04:14 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F9AF20B7A;
	Tue, 21 May 2013 20:04:13 +0000 (UTC)
In-Reply-To: <CALkWK0m3QP_eE14y8UoJ+HeFzkKM=1nVKAnYJcTrwQMp+Atphg@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Wed, 22 May 2013 01:22:45 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9BBA000C-C251-11E2-8A90-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225070>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> We're at 1.8.3; isn't it a little early to be thinking of 2.0?  Is it
> conflicting with jc/push-2.0-default-to-simple in pu?  I should
> re-send after this topic graduates to master in 2.0?

I implicitly asked you not to ask as I do not even have to worry
about conflicts ;-)  That does not mean I'll discard.  Please ping
me back later after 1.8.3 if you do not see it in my tree anywhere;
I may have found time to splice these _before_ the 2.0 patch (which
is where it should come, I think) by then.
