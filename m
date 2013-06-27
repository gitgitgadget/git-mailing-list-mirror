From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] lib-rebase: use write_script
Date: Thu, 27 Jun 2013 13:50:45 -0700
Message-ID: <7vvc4zqnve.fsf@alter.siamese.dyndns.org>
References: <1372357825-21824-1-git-send-email-andrew@pimlott.net>
	<7va9mbs8lw.fsf@alter.siamese.dyndns.org>
	<1372359086-sup-9704@pimlott.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Andrew Pimlott <andrew@pimlott.net>
X-From: git-owner@vger.kernel.org Thu Jun 27 22:50:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsJ9Y-0000dS-8V
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 22:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753895Ab3F0Uus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 16:50:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41303 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753765Ab3F0Uur (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 16:50:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B41E297C5;
	Thu, 27 Jun 2013 20:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TD6A8uaYGW3NxN3BKwKOv1lXD8U=; b=ipzwHv
	UInzRTMO1SYnGFLyRA57cP/6gHMEg9/PYjhj7JT7O2IHVxtV1DrYNHHkayMVW0XI
	VJwsbF6ooYi6sKTvSz3WPGhEOLA+Dk+PakEtTDZXdGrDbaGy/biZWbn3OUbX6x74
	JPU5JqRjTXRqCy9HwIflc4B4mon5AoPICeZII=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nXbVsq0LvWGO4VwIiiGxEiMz/8Thw8Qe
	lWeraVqAP3rrmcATYr12GIiCCbCts3n8jcfHINGr6KQ1sKTJrQ1lWVf7EnixwBUy
	vymEICqSUOkFaGrVfd9e/br+im9AQkqbcUJujfhpG9QxzH5feShClkUwWsRPghMO
	BlUTz8/G9rE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DF2B297C3;
	Thu, 27 Jun 2013 20:50:47 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2E97297C2;
	Thu, 27 Jun 2013 20:50:46 +0000 (UTC)
In-Reply-To: <1372359086-sup-9704@pimlott.net> (Andrew Pimlott's message of
	"Thu, 27 Jun 2013 12:02:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3DDA84D4-DF6B-11E2-BB77-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229155>

Andrew Pimlott <andrew@pimlott.net> writes:

> I should update the function I introduced first.  I will re-submit
> the rebase -i --autosquash patch and wait for acceptance before
> trying to fix other things.

Thanks.
