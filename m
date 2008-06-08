From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH] Fix missing "HEAD" in the RewriteRule
Date: Sat, 07 Jun 2008 18:17:51 -0700
Message-ID: <7vbq2cn2rk.fsf@gitster.siamese.dyndns.org>
References: <1212823166-25098-1-git-send-email-ask@develooper.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ask =?utf-8?Q?Bj=C3=B8rn?= Hansen <ask@develooper.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 03:19:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K59Z6-00063l-4V
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 03:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755339AbYFHBSE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Jun 2008 21:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755318AbYFHBSD
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 21:18:03 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38800 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755317AbYFHBSB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jun 2008 21:18:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 78A723926;
	Sat,  7 Jun 2008 21:17:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EFFF23923; Sat,  7 Jun 2008 21:17:54 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BB9805A4-34F8-11DD-A1B2-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84241>

Ask Bj=C3=B8rn Hansen <ask@develooper.com> writes:

> Also add a few more hints for how to setup and configure gitweb as de=
scribed

I'll squash in Mike Hommey's typofix to make the patch to read like thi=
s:

> ...
> +    RewriteEngine on
> +    # make the front page an internal rewrite to the gitweb script=20
> +    RewriteRule ^/$  /cgi-bin/gitweb.cgi
> ...

I'll also retitle it to "gitweb setup instruction: rewrite HEAD and roo=
t
as well".

Please sign-off your future patches.

Thanks.
