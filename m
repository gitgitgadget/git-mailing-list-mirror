From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] revision.c: treat A...B merge bases as if manually specified
Date: Mon, 13 May 2013 09:04:45 -0700
Message-ID: <7v1u9aoogy.fsf@alter.siamese.dyndns.org>
References: <5190F806.6040207@bracey.fi>
	<1368457247-19822-1-git-send-email-kevin@bracey.fi>
	<1368457247-19822-3-git-send-email-kevin@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Mon May 13 18:04:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbvF6-0001oz-JW
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 18:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684Ab3EMQEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 12:04:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52482 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750992Ab3EMQEr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 12:04:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43FF51E06F;
	Mon, 13 May 2013 16:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vKGe6HQjXWZrrvu2dv8e74KQegs=; b=R6csHc
	kxEBvgbXSJPPL+SaCV/S/NTwtfQqIwaxFoKjW3pNkHaNUGgHc9zIVLHCIJLlKI59
	MSX/ToWSrtBjNfj+1XYcZ4ta9Bis3hNHnrzWednuJD5dBKKiutu7RvuL3+IHqrjb
	08SpyjjfjlEeezb8/0//1+gJSf/d9Lka4TQj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TJAGesM/KgctMAEY6WJPrk+bPi7tzD39
	25T7t+pSOcgY1fisQChuSpFdEFSnhxkevhHAKxmW6pQHHnfoiS+PnqVShL+0rXsi
	Xfw7luBmpGv1u8rNrqrbrVQBZtp0ORkeYUYUBt61oOwXQmyy9/4Qby7RrCUHthdS
	11p07iRRPBY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 376BE1E06E;
	Mon, 13 May 2013 16:04:47 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B27161E069;
	Mon, 13 May 2013 16:04:46 +0000 (UTC)
In-Reply-To: <1368457247-19822-3-git-send-email-kevin@bracey.fi> (Kevin
	Bracey's message of "Mon, 13 May 2013 18:00:47 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D525A7D6-BBE6-11E2-88E8-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224176>

Looks good.  Thanks.
