From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] checkout: allow dwim for branch creation for "git checkout $branch --"
Date: Thu, 17 Oct 2013 13:47:53 -0700
Message-ID: <xmqqvc0vy686.fsf@gitster.dls.corp.google.com>
References: <1380113349-19838-1-git-send-email-Matthieu.Moy@imag.fr>
	<CACsJy8AbBrVSz=p+ARxvR_QXtku1BxbtQPv7pz_QCveeUEtwCQ@mail.gmail.com>
	<vpqob7huhyw.fsf@anie.imag.fr>
	<xmqq7gdc6gl8.fsf@gitster.dls.corp.google.com>
	<vpqr4bkqhfg.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>, jc@sahnwaldt.de
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Oct 17 22:48:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWuUD-0006B1-SO
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 22:48:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762502Ab3JQUr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Oct 2013 16:47:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43336 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759409Ab3JQUr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Oct 2013 16:47:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31EFE4BEA4;
	Thu, 17 Oct 2013 20:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xSzps3okhDTKaFYD0LNVLPCKu2A=; b=p2HC9b
	21wHJwZ5vcahUwVQ3pX69s41XcO/8eMHbQC73Dr1MJK7Lmlv/wllI1S3qIgmaSiU
	SDy9CcCvMXLKhY+8VzZtZYtfTJCOXjJgz6xZEs/QvqQDKcj24OF/masDByUoPVoe
	+xCUK/nK5nJrKO3bGEkndy++lgW01vFsZrKGA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z5J62cQiuUqhMEbmHSYrz1GSJq1QFwMi
	KacoHFt6H+lbF9LhREp5U6E4FNzirtx1o/JSsjaJuf28qmSS4dXe6MDnUAjPzqB7
	shNAIeOd2HLb0H2YyI8dPxBR2vV/Zt4yDxDPPpkIHZ3uKyRJ8chbqiK9nqpM3V+B
	ZrsOSuE99mM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 261474BEA2;
	Thu, 17 Oct 2013 20:47:56 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 84A754BE9F;
	Thu, 17 Oct 2013 20:47:55 +0000 (UTC)
In-Reply-To: <vpqr4bkqhfg.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	17 Oct 2013 13:13:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 661F1C5C-376D-11E3-9CC2-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236318>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> v3
> ( http://thread.gmane.org/gmane.comp.version-control.git/235409/focus=235408 )
> is the last version I sent, and I got no feedback on it, so I guess it's
> ready for you to pick.

Thanks; done with s/pick/nitpick/ ;-).
