From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: extract Q_() source strings as ngettext()
Date: Mon, 11 Apr 2011 14:38:43 -0700
Message-ID: <7v1v18v57g.fsf@alter.siamese.dyndns.org>
References: <1302464221-23381-1-git-send-email-avarab@gmail.com>
 <20110410195436.GD28163@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 23:39:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9Op2-0007Sj-4V
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 23:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755662Ab1DKViz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 17:38:55 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38818 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754258Ab1DKViy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 17:38:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3B3D14BD4;
	Mon, 11 Apr 2011 17:40:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=K8NKbAhk0IGrXTG7dnSOYXtlaGs=; b=YKQxkEhEV8UTcidRh4s5
	uXY16VgUAMUEoJNyu+KUKTYx7vQu5phaKXDbB1DHE0zztZ89YatMJwgCPmaHlz6u
	s4YMm1J1LP834JiTs5CwrTcdHNh0J+qCJUz7V98zMF4ufkmrb/9gpL2TICcS9bVx
	LdvCvg/elEXts+z8r3x9szw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=GlU8ttSyvUMSoi4J7I1igmHpoUqz6+5af8mSprC6MbYfpE
	4B1nCViRRfAS4Bb4JxoOkqsmpKpHWvBNgY6f+wgjXB0FOemZjmsJnuVpv9+MYCtT
	f19xZNbAdVKV598MyO7yjOz6auOMRz2Du5yCadvthZ9m8ymdf/jmqVuVrWXzg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 090B54BCE;
	Mon, 11 Apr 2011 17:40:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EA2D94BCB; Mon, 11 Apr 2011
 17:40:43 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5CFBA2DA-6484-11E0-9E93-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171359>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Ack.  The line is getting long.  Maybe it would make sense to split
> it up (like this)?

Makes sense, thanks both.

I've re-written the commit log message, by the way.  Instead of saying "X
forgot to do Y and broke Z", I prefer to say "To make sure Z happens, we
need to do Y to augment what X did, and W is how we do Y".
