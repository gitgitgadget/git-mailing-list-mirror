From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/3] shortlog: handle multi-line subjects like log
 --pretty=oneline et. al. do
Date: Wed, 07 Jan 2009 13:19:27 -0800
Message-ID: <7vocyi95ls.fsf@gitster.siamese.dyndns.org>
References: <1230338961.8363.101.camel@ubuntu.ubuntu-domain>
 <200812280024.59096.markus.heidelberg@web.de>
 <4956C47B.4020602@lsrfire.ath.cx> <49594C16.2010406@lsrfire.ath.cx>
 <7vocynz8y6.fsf@gitster.siamese.dyndns.org> <4963C1E2.8070906@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: markus.heidelberg@web.de, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Jan 07 22:21:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKfqM-0000mL-AR
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 22:21:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761805AbZAGVTh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Jan 2009 16:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761798AbZAGVTh
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 16:19:37 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54548 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759489AbZAGVTg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jan 2009 16:19:36 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A943C1C06B;
	Wed,  7 Jan 2009 16:19:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1EBC21C06A; Wed, 
 7 Jan 2009 16:19:30 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E243C354-DD00-11DD-974D-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104834>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> The commit message parser of git shortlog used to treat only the firs=
t
> non-empty line of the commit message as the subject.  Other log comma=
nds
> (e.g. --pretty=3Doneline) show the whole first paragraph instead (unw=
rapped
> into a single line).
>
> For consistency, this patch borrows format_subject() from pretty.c to
> make shortlog do the same.

Thanks; will queue.
