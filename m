From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] merge-recursive: porcelain messages for checkout
Date: Mon, 09 Aug 2010 12:58:03 -0700
Message-ID: <7vhbj34kz8.fsf@alter.siamese.dyndns.org>
References: <1281363602-27856-1-git-send-email-Matthieu.Moy@imag.fr>
 <1281363602-27856-3-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Aug 09 21:58:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiYUD-0001KF-Bj
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 21:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755468Ab0HIT6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 15:58:13 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56193 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754343Ab0HIT6M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 15:58:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A6226CCBE3;
	Mon,  9 Aug 2010 15:58:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=4s1P5+A7EA7Sa5/ozk+CzBjcStA=; b=edn8J5HGcVuVDe8vwAha5hP
	y2qAw2H7nEGGwCDv36+ovBGIiE+/xyJ6CkcAsR3viMKtKVvS9hP+gnNwIPkk2/Rc
	b+WSAq5NkX53HuaTnei8uCiGUVPSTF49SbjUS2rMpybBkvsZds8smeZ+40DcReel
	syw4um9YWMlBb4xLSr8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=LZzIthKIq3JMupIeUPYMDdGU9WaOLqrNwK6C5Q2tK29e37Bbe
	vpxiE6C9wLA+5UbOR4+D+qP6yjvUNYF3X1imF8f4FARQoXRCnlg8eWrvtVQNVC12
	L1091pWrG6peKU7dfLNr3sXwqamWiTVpgDVCoiGuAfOdxqhSh28AQ0cNUI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 72DBACCBE1;
	Mon,  9 Aug 2010 15:58:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.126]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B5D36CCBDD; Mon,  9 Aug
 2010 15:58:04 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6E6B6758-A3F0-11DF-A78F-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153010>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> +void set_porcelain_error_msgs(const char **msgs, const char *cmd)
>  {
> +	const char *msg;
> +	char *tmp;
> +	const char *cmd2 = strcmp(cmd, "checkout") ? cmd : "switch branches";

This may have implications to the later i18n effort, but lets ignore it
for now.  I don't think it will be too bad.
