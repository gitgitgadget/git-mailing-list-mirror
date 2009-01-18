From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/workdir: create logs/refs and rr-cache in the
 origin repository
Date: Sat, 17 Jan 2009 17:31:57 -0800
Message-ID: <7vbpu54cxe.fsf@gitster.siamese.dyndns.org>
References: <1232208943-31756-1-git-send-email-dato@net.com.org.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Adeodato =?utf-8?Q?Sim=C3=B3?= <dato@net.com.org.es>
X-From: git-owner@vger.kernel.org Sun Jan 18 02:34:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOMYP-0000Uh-P3
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 02:34:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756497AbZARBcK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Jan 2009 20:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756065AbZARBcI
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 20:32:08 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48117 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754685AbZARBcG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Jan 2009 20:32:06 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 98FE21CBE9;
	Sat, 17 Jan 2009 20:32:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 34A931CBE8; Sat,
 17 Jan 2009 20:31:59 -0500 (EST)
In-Reply-To: <1232208943-31756-1-git-send-email-dato@net.com.org.es>
 (Adeodato =?utf-8?Q?Sim=C3=B3's?= message of "Sat, 17 Jan 2009 17:15:43
 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CFDCF77E-E4FF-11DD-952D-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106127>

Adeodato Sim=C3=B3 <dato@net.com.org.es> writes:

> If logs/refs or rr-cache are dangling symlinks in the workdir, and re=
flogs
> and/or rerere are enabled, commit will die with "fatal: Could not cre=
ate
> directory". (In the case of rr-cache, it will die after having create=
d the
> commit.)
>
> This commit just creates logs/refs and rr-cache in the origin reposit=
ory if
> they don't exist already.

Hmm, is that better than not creating the symlink of the borrowed
repository does not have them?
