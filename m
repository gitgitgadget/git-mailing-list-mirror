From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] pretty: support multiline subjects with format:
Date: Sat, 27 Dec 2008 16:13:25 -0800
Message-ID: <7vr63tb1i2.fsf@gitster.siamese.dyndns.org>
References: <1230338961.8363.101.camel@ubuntu.ubuntu-domain>
 <200812280024.59096.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Sun Dec 28 01:14:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGjJ1-0007Bp-El
	for gcvg-git-2@gmane.org; Sun, 28 Dec 2008 01:14:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754592AbYL1ANf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Dec 2008 19:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754582AbYL1ANf
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 19:13:35 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40871 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753558AbYL1ANe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2008 19:13:34 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4A8181B32E;
	Sat, 27 Dec 2008 19:13:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 75BF41B32C; Sat,
 27 Dec 2008 19:13:28 -0500 (EST)
In-Reply-To: <200812280024.59096.markus.heidelberg@web.de> (Markus
 Heidelberg's message of "Sun, 28 Dec 2008 00:24:58 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5D0524F6-D474-11DD-B25D-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104035>

Markus Heidelberg <markus.heidelberg@web.de> writes:

> What's wrong with using the first line instead of the first paragraph
> for the other pretty options and for cases where only a small subject
> line is desired? A sentence would be broken into a small uncomplete part
> for the subject for example. What else?

The "first line" actually was what we used to do originally.

git-native commits did not have problem with this behaviour, but it caused
countless complaints from people looking at the history converted from
other cultures.

The behaviour was later fixed to avoid information loss when a commit from
a different culture begins the log with a long sentence, choped at
mid-sentence, to continue to the second line.

Please check the list archive for the details (sorry, I am bit too lazy to
repeat the argument myself).
