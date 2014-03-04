From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-bisect.sh: fix a few style issues
Date: Mon, 03 Mar 2014 18:30:58 -0800
Message-ID: <xmqqzjl6lmot.fsf@gitster.dls.corp.google.com>
References: <1393892503-12765-1-git-send-email-jacopo.notarstefano@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 03:31:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKf8R-0007X8-V6
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 03:31:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756097AbaCDCbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 21:31:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51216 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755576AbaCDCbG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 21:31:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE13671F7A;
	Mon,  3 Mar 2014 21:31:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w7QxIt6fnk19c+7N7tVnQMaHpMY=; b=JYLJk1
	kGLL2qdT6+svHJA26ZaoR/NsCUmvVG8wUQ5IRIyvPVLh6dvp8GOy96V8YUfyBzSD
	74PGFudsI6BA/mt4yAK9K3hJyhcv8obvegwDhY3LZ15B23QqE/9DK0u3eEymh8Gh
	emGqz7MfFw0YnJdVnU+iR61lA26/dm1LGqG1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NlUy+sOKI0h+7civ7qCONpBItHaa4ZFo
	l+lfSbHZqB8A0W8IlubKholE7IfeXdL1TAqaJ7unlT/9NYSN8aN7b5qCSiwfTdDs
	9N+0I0XqPdCV0grMRNK1GtIvPWEOi8wM8Jt5gRozYnCDcjj2yMQ4WFYYGCtL7wVj
	GUHHA7l12Yw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D330071F79;
	Mon,  3 Mar 2014 21:31:03 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 259AA71F77;
	Mon,  3 Mar 2014 21:31:03 -0500 (EST)
In-Reply-To: <1393892503-12765-1-git-send-email-jacopo.notarstefano@gmail.com>
	(Jacopo Notarstefano's message of "Tue, 4 Mar 2014 01:21:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 07E31686-A345-11E3-9DBF-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243323>

Jacopo Notarstefano <jacopo.notarstefano@gmail.com> writes:

> Redirection operators should have a space before them, but not after them.
>
> Signed-off-by: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
> ---

Looks obviously harmless ;-)

Thanks.
