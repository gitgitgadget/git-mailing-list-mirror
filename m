From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7500-commit.sh: do not call test_set_editor
 unnecessarily, it's confusing
Date: Mon, 29 Dec 2008 01:46:02 -0800
Message-ID: <7vmyefco11.fsf@gitster.siamese.dyndns.org>
References: <1230542658-9758-1-git-send-email-dato@net.com.org.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Adeodato =?utf-8?Q?Sim=C3=B3?= <dato@net.com.org.es>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 29 10:47:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHEij-0004iA-M3
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 10:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753544AbYL2JqN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Dec 2008 04:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753505AbYL2JqK
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 04:46:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64232 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752965AbYL2JqJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Dec 2008 04:46:09 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9CA661B495;
	Mon, 29 Dec 2008 04:46:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 545AC1B493; Mon,
 29 Dec 2008 04:46:03 -0500 (EST)
In-Reply-To: <1230542658-9758-1-git-send-email-dato@net.com.org.es> (Adeodato
 =?utf-8?Q?Sim=C3=B3's?= message of "Mon, 29 Dec 2008 10:24:18 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 84CFACD0-D58D-11DD-9712-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104090>

Adeodato Sim=C3=B3 <dato@net.com.org.es> writes:

> I was reading this test case, and it took a small bit to figure out t=
he
> editor was not being used at all. I hope there was no hidden reason f=
or
> it to be there, and it can go away.

That 'zort' came from 1320857 (builtin-commit: fix --signoff, 2007-11-1=
1),
and I _think_ it is trying to make sure that presense of "-F -" makes t=
he
editor not to trigger.

Dscho?
