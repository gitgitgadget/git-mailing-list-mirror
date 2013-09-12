From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] remote-bzr: reuse bzrlib transports when possible
Date: Thu, 12 Sep 2013 14:11:12 -0700
Message-ID: <xmqqeh8toidr.fsf@gitster.dls.corp.google.com>
References: <522C0B66.1080707@bbn.com>
	<1378619269-21991-1-git-send-email-rhansen@bbn.com>
	<xmqqa9jl1u7j.fsf@gitster.dls.corp.google.com>
	<xmqqbo40wd3d.fsf@gitster.dls.corp.google.com>
	<52322C8C.4000501@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, felipe.contreras@gmail.com
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Thu Sep 12 23:11:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKEAc-0002rX-3K
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 23:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755807Ab3ILVLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 17:11:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54587 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753485Ab3ILVLR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 17:11:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7565418D8;
	Thu, 12 Sep 2013 21:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m8QBiRdeWhP9jtZBplT7/iumbsw=; b=Yx//YF
	JlBauZFKFNO5MS9UaDE1Pczpf2JMujlu3ZvEM9d9IUTSHUWSAy7DU81xtxZVL2RS
	hnO15OCUOuRXjSsArqeEh/KaWFqsHoHfNJLHE/3+MLZ8IFmME49M6fRZNCgF44iH
	BhJtGanvbdH2oG+hH8fRfoRvXy3DCUGFpPyUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pTCf+TQCrUOMhIzAuVNCkSexY/ExBlT+
	lPrCJeuZ5D2+cJg2tj77GlkrmuMc+GiVpLcCo6g1vKmNNteyjAQp7Umwqf2FleKp
	Qhq7jvLhjXCdOFTXVR47bUpzqXhZal63Jtp/uSXlNrcf5319I+K2wmgY86LXlLPN
	qy1ojQx057Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E3A6418D3;
	Thu, 12 Sep 2013 21:11:16 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B250A418CF;
	Thu, 12 Sep 2013 21:11:15 +0000 (UTC)
In-Reply-To: <52322C8C.4000501@bbn.com> (Richard Hansen's message of "Thu, 12
	Sep 2013 17:05:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DC3DA0DC-1BEF-11E3-AD69-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234698>

Richard Hansen <rhansen@bbn.com> writes:

>> Ping?  I'd like to merge fc/contrib-bzr.hg-fixes topic to 'next'
>> (and fast track it to 'master' after that), and it would be helpful
>> to get an Ack on the conflict resolution I have.
>
> Sorry for the delay.
>
> Looks good to me, and the tests still pass.

Thanks.
