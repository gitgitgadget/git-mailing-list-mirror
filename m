From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-pack: Filter unknown commits from alternates of the
 remote
Date: Tue, 27 Jan 2009 20:32:16 -0800
Message-ID: <7v63k0xd7z.fsf@gitster.siamese.dyndns.org>
References: <7vk58gz04l.fsf@gitster.siamese.dyndns.org>
 <20090128013840.GA7224@atjola.homenet>
 <7vskn4xfyg.fsf@gitster.siamese.dyndns.org>
 <20090128035804.GC7503@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: PJ Hyett <pjhyett@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 28 05:33:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS27f-0004SK-1n
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 05:33:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752436AbZA1Eca convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jan 2009 23:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752415AbZA1Ec3
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 23:32:29 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37972 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309AbZA1Ec3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jan 2009 23:32:29 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2984D1D6F2;
	Tue, 27 Jan 2009 23:32:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 231041CFAA; Tue,
 27 Jan 2009 23:32:19 -0500 (EST)
In-Reply-To: <20090128035804.GC7503@atjola.homenet> (=?utf-8?Q?Bj=C3=B6rn?=
 Steinbrink's message of "Wed, 28 Jan 2009 04:58:04 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AA22DBC8-ECF4-11DD-808C-0372113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107473>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> ... Do we need to
> fetch from multiple repos when alternates are involved?

This part is a slightly different issue than the rest of your message, =
so
I'll answer separately.

Yes, in the example, if Bob fetched from Alice before he pushed, his pu=
sh
will succeed with the 1.6.1 send-pack.

But that is a workaround, and it is not a fix.
