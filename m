From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] howto: Use all-space indentation in ASCII art
Date: Mon, 15 Jul 2013 15:00:17 -0700
Message-ID: <7v61wba3gu.fsf@alter.siamese.dyndns.org>
References: <20130715164658.GA8675@bottich>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>,
	Thomas Ackermann <th.acker@arcor.de>
To: Dirk Wallenstein <halsmit@t-online.de>
X-From: git-owner@vger.kernel.org Tue Jul 16 00:00:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uyqoi-0002gg-Tc
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 00:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755310Ab3GOWAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 18:00:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58141 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755095Ab3GOWAU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 18:00:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DBD231B26;
	Mon, 15 Jul 2013 22:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PbCXLONIv5h1mT0xJsAAUaCghP8=; b=twtKMh
	6MyaosQUHamfucQvsBG09mahiZG1J4rbf4QM4SAwhGxBNa6PKvw/2VDhfp9VSK+Y
	EkuB+uCju82bp2zbxXLRdPHiYamI13U5asCJe+dQXD7TDHSPwZjdn0AxsIztCHpE
	C4+2xP5z3NrGzd38u6icRRTsKlJmubHolPf+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LSWzs1JVDdVZMXxqx7PUAfugF1QuXPjM
	fLW32cLHtllCCl1efrpUSG0pO2dG/vaOcUmLn7NNhXVxrxO1I18IVRZ86a29DiAn
	LHFnCSpGj4m0IecbeCqnbGtufTcvCDzjmroBiYlmW89ImdWFjfDDxeXQCPHS/Ra5
	n1J7E25BLDE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 751C131B25;
	Mon, 15 Jul 2013 22:00:19 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD33231B23;
	Mon, 15 Jul 2013 22:00:18 +0000 (UTC)
In-Reply-To: <20130715164658.GA8675@bottich> (Dirk Wallenstein's message of
	"Mon, 15 Jul 2013 18:46:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F0234B12-ED99-11E2-A772-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230529>

Dirk Wallenstein <halsmit@t-online.de> writes:

> Keep the sketch aligned independent of the tabstop width used.

Thanks.

This is a source text to be formatted into HTML, isn't it?

In our sources, a HT indents to multiple of 8 columns.  As long as
the output HTML produced from the source can be seen on a terminal
with any tab-width correctly, I do not see any reason to apply this
patch.

Am I missing something???
