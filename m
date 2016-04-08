From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/24] t1430: test the output and error of some commands more carefully
Date: Fri, 08 Apr 2016 13:43:59 -0700
Message-ID: <xmqq4mbbvnjk.fsf@gitster.mtv.corp.google.com>
References: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
	<1460055791-23313-4-git-send-email-dturner@twopensource.com>
	<5707CACB.4030906@alum.mit.edu>
	<1460143577.5540.11.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 22:44:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aodGX-0003Ts-EH
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 22:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932883AbcDHUoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 16:44:09 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:63112 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932818AbcDHUoI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 16:44:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 535CE532B8;
	Fri,  8 Apr 2016 16:44:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pgY01IEFWeDbSe06mMpl3QuAPrI=; b=LRLVxy
	bAE64ChwDMFZRiuym5FCCVXrhlSPOwcTj+NegeEyS+uDhj+SZx3ZIKRqMoAMdiVz
	fr9+/grwpMx3lM1xc+HDDpZQIpeUEQh1YIwyGzMke2IS62Qg5H8K6+zHaZy24aqt
	O4H0cwXm419a+Od0Xiw3ZkTTcXkNRo7WrC01g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=es6VNhDFk64u+TN/jwZ4oxJJpOGI9XaN
	q3kWCsL4ERKPCfT5A40k7cPBkSS0G3EoD0RlMNnHx60euLSibQbJpJgpJ8X5ct3S
	W4bZrO7zP2nfbXy9cLsHWLj7XDMFFbJ/8z109HtB1EUeWGTZYijnkIIBhdnV4bbY
	dzUfntT0ldA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 474C9532B7;
	Fri,  8 Apr 2016 16:44:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4D175532B5;
	Fri,  8 Apr 2016 16:44:01 -0400 (EDT)
In-Reply-To: <1460143577.5540.11.camel@twopensource.com> (David Turner's
	message of "Fri, 08 Apr 2016 15:26:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9FF22962-FDCA-11E5-ACA2-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291072>

David Turner <dturner@twopensource.com> writes:

> Would you like
> me to re-roll with my sign-off, or would you prefer to add it yourself?

I take it that you see no other reason to reroll the series at this
point (otherwise you wouldn't be asking ;-), so I'll check which
ones need amending and add them.

Thanks.
