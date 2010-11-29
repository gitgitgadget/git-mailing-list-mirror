From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] [RFC] Use --find- instead of --detect- as prefix for
 long forms of -M and -C.
Date: Mon, 29 Nov 2010 14:44:35 -0800
Message-ID: <7vipzfzr58.fsf@alter.siamese.dyndns.org>
References: <1289420833-20602-1-git-send-email-ydirson@altern.org>
 <1289420833-20602-2-git-send-email-ydirson@altern.org>
 <20101129215355.GA3445@home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
To: Yann Dirson <ydirson@free.fr>
X-From: git-owner@vger.kernel.org Mon Nov 29 23:44:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNCSm-0004fo-VB
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 23:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753949Ab0K2Woo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 17:44:44 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56275 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739Ab0K2Woo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 17:44:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B194D3C4C;
	Mon, 29 Nov 2010 17:45:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=onFw/lgmukQLMqIyi2zg/I+2kt0=; b=rsKZE8
	vigyGzGgMruUJ7+PpydJSLSgc5a51vABDEbnlfHQ0TI52dpeeEKrVHtuMWvzjBB6
	bqLwiQCRfFPKLeJGiuOc6JcVX6yWcyb6x2FHzrhcwuokFCPlSLUDEAjd2sqaw4AT
	lvkrrbFYPusAaFXZMdJvqb+LrdZ2CcSHYJ5IU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KoiyEdTdeRSyd4PmCkQvnre3Jsflpxng
	KrDn6uFn/E2heKQxRu5EwuYqV/OiPQxRKjvWX9gqkc7sagFAnRq9/D77hpqzAEdl
	MmeHLqW174ZIj7sbmN7pQ+jaeSAQ6yFg5+A0jD47hzbWS8JHC0rWhej0M/qCSTnc
	nn6KgFeFEKE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8CBD83C49;
	Mon, 29 Nov 2010 17:44:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 536823C48; Mon, 29 Nov 2010
 17:44:55 -0500 (EST)
In-Reply-To: <20101129215355.GA3445@home.lan> (Yann Dirson's message of
 "Mon\, 29 Nov 2010 22\:53\:55 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4B29BF84-FC0A-11DF-8DBC-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162436>

Yann Dirson <ydirson@free.fr> writes:

> So is there an official decision that this idea was a bad one and
> should I drop this patch from my outq ?

I was hoping that I didn't have to make any official decision ;-)

For what I think, please see my other message.
