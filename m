From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] Easier access to index-v4
Date: Mon, 24 Feb 2014 09:56:13 -0800
Message-ID: <xmqqios49yyq.fsf@gitster.dls.corp.google.com>
References: <1393188599-5391-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 18:56:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHzlN-0004oI-M5
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 18:56:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188AbaBXR4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 12:56:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53118 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752846AbaBXR4R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 12:56:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95D6B6BC66;
	Mon, 24 Feb 2014 12:56:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XTGGZBQ5miYMxDlJOaB6COtPfI0=; b=VCdg/P
	6lzFuRKW76YtLIxQRAC+7GXwKEKrfPVMIdXH607gyRx8Xn5rl32rZ4Hc+fyrVtmQ
	Oymh8sigDCxFnqtrDqakOSKY27j8jmoij+RTbyg3HrSko+pXUoIIvlsCpNTlJesq
	c/kvPxaee6jRi82s2+21SNdUydFAGTV8VzzPc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gtuEPZiJTCw5WDEYAPpxWsLODllv/348
	QAMAhAGDtiUP8J38CCJrRbKQQYDhhDDNKXbCtyLgqMk4gaUqpM8ILOssN9Cws1YE
	yK3G9Ccwg6n+1bN2P89J6p1NhzAhQs4PSA1Z5SBPhWLoAojCSP0QrDkpCXThRRTs
	uLAMghqU6cA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 603E46BC65;
	Mon, 24 Feb 2014 12:56:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7BE426BC63;
	Mon, 24 Feb 2014 12:56:15 -0500 (EST)
In-Reply-To: <1393188599-5391-1-git-send-email-t.gummerer@gmail.com> (Thomas
	Gummerer's message of "Sun, 23 Feb 2014 21:49:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F485C318-9D7C-11E3-A035-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242624>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> previous round was at $gmane/242198.
>
> Since then I've squashed the fixes suggested by Junio, added a test
> showing what should happen if an index file is present and
> GIT_INDEX_VERSION is set and fixed the typo found by Eric.

Looks good; thanks.
