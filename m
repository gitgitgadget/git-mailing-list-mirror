From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCHv3 1/3] l10n: de.po: switch from pure German to German+English (part 1)
Date: Wed, 17 Jul 2013 11:35:41 +0200
Message-ID: <87sizdbkb6.fsf@linux-k42r.v.cablecom.net>
References: <87bo631odi.fsf@hexa.v.cablecom.net>
	<1374040279-4828-1-git-send-email-ralf.thielow@gmail.com>
	<1374040279-4828-2-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <jk@jk.gs>, <stimming@tuhh.de>, <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 17 11:35:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzO9E-0006Gj-FZ
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 11:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753519Ab3GQJfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 05:35:45 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:16023 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753222Ab3GQJfo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 05:35:44 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 17 Jul
 2013 11:35:39 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.149.220) by
 CAS22.d.ethz.ch (172.31.51.112) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Wed, 17 Jul 2013 11:35:41 +0200
In-Reply-To: <1374040279-4828-2-git-send-email-ralf.thielow@gmail.com> (Ralf
	Thielow's message of "Wed, 17 Jul 2013 07:51:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.149.220]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230610>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> This switches the translation from pure German to German+English.
>

I tried to compare this to the old version, but your patch is damaged at
line 160 counting from this:

> ---
>  po/de.po | 568 +++++++++++++++++++++++++++++++--------------------------------
>  1 file changed, 284 insertions(+), 284 deletions(-)
[...]
>  #: branch.c:137
>  #, c-format
>  msgid "Not tracking: ambiguous information for ref %s"
> -msgstr "Konfiguration zum Folgen von Zweig nicht
> eingerichtet. Referenz %s ist mehrdeutig."
> +msgstr "Konfiguration zum Folgen von Branch nicht
> eingerichtet. Referenz %s ist mehrdeutig."

These two lines apparently got wrapped by your MUA.  There are more
instances of the same damage.  Can you send a fixed patch?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
