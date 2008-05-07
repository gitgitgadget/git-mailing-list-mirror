From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCHv4 4/4] user.warnautomatic: add config to control if the
 committer ident is shown
Date: Wed, 07 May 2008 09:12:58 -0700
Message-ID: <7v8wymdred.fsf@gitster.siamese.dyndns.org>
References: <1209917092-12146-1-git-send-email-sbejar@gmail.com>
 <1209917092-12146-5-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 18:14:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtmHT-0001mv-EX
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 18:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757317AbYEGQNK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 May 2008 12:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756477AbYEGQNJ
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 12:13:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45272 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754073AbYEGQNG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 May 2008 12:13:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 050EC34D8;
	Wed,  7 May 2008 12:13:05 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 6F96D34D6; Wed,  7 May 2008 12:13:02 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 795CE904-1C50-11DD-9AC1-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81457>

Santi B=C3=A9jar <sbejar@gmail.com> writes:

> Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>

By setting this new variable the user can squelch undesired noise the
previous change introduces, but the user can just set user.name and
user.email to desired values to squelch it anyway.

So either this new variable is superfluous, or the previous change is t=
oo
susceptible to produce false positives that need squelching with such a
variable, or both.  In any case, not a very good sign.
