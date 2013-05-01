From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Add new @ shortcut for HEAD
Date: Wed, 01 May 2013 15:56:58 -0700
Message-ID: <7v8v3y48cl.fsf@alter.siamese.dyndns.org>
References: <1367401888-21055-1-git-send-email-felipe.contreras@gmail.com>
	<7vr4hq7fjy.fsf@alter.siamese.dyndns.org>
	<CAMP44s16X8c_5GgW=ZcA9wrd=oHAiVDZFWxqiGmysaUJckZ5wQ@mail.gmail.com>
	<7vsj264am4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 00:57:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXfxT-00042o-8m
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 00:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758148Ab3EAW5D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 18:57:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60756 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757086Ab3EAW5B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 18:57:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EA321BF4D;
	Wed,  1 May 2013 22:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ui+V7+8QXkNrrEXU9jYIVPiGjyQ=; b=V4UtOU
	W1x08YZsJCAwx2efZLWXIt9uDTwxdvFEmagzL4emt39GTxvdsVy+8sg5yePIL+NN
	sWmYdSmb8by5ueEVm8WXg7ARb/tvz/iUcaiRCqWP9QlkqItGdK9QRubxl7SNMwBu
	wfON9cQ1WEIbZLUv4Qxc/OeuKesFenGHKu3qY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sorj9xgn1QhHWHkBt3r0Zx/VvMHzzkG1
	OwCLlQrLGZ656TETWWcUj1Oa6CVVRaot+l+KiGPkV+do6kJbSusf/mz7cb0L13Zg
	mvgZY6RII7TP1ESE94uLw+2jJ5h8iiEeHGr/0WHJYwAnl4PdkqOjaFihQ2ABdCFK
	hk2Nk9R+Bs8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 82C4A1BF4C;
	Wed,  1 May 2013 22:57:00 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EF5741BF4A;
	Wed,  1 May 2013 22:56:59 +0000 (UTC)
In-Reply-To: <7vsj264am4.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 01 May 2013 15:08:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6E680C24-B2B2-11E2-BFCB-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223162>

Junio C Hamano <gitster@pobox.com> writes:

> The thing is, HEAD@{0}~0^0 nor HEAD@{u}~0^0 is not a valid
> explanation why it is "@", either.
>
> But that does _not_ mean "@" is a good choice.  Nor the explanation

Arrgh.  It does not mean " '@' is a BAD choice ".  '@' _is_ good.
But the point is that the explanation does not have to be a
technically incorrect "strip this, strip that".
