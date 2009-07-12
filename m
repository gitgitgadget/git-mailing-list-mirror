From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] init-db: migrate to parse-options
Date: Sun, 12 Jul 2009 11:27:14 -0700
Message-ID: <7v8witn4e5.fsf@alter.siamese.dyndns.org>
References: <4A598E03.10204@gmail.com>
 <1247394272-6944-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 12 20:27:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQ3lp-0004IR-8a
	for gcvg-git-2@gmane.org; Sun, 12 Jul 2009 20:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754549AbZGLS1V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jul 2009 14:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754511AbZGLS1U
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jul 2009 14:27:20 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64374 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754329AbZGLS1U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2009 14:27:20 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3DB1E27D98;
	Sun, 12 Jul 2009 14:27:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7479F27D96; Sun,
 12 Jul 2009 14:27:16 -0400 (EDT)
In-Reply-To: <1247394272-6944-1-git-send-email-michal.kiedrowicz@gmail.com>
 (=?utf-8?Q?=22Micha=C5=82?= Kiedrowicz"'s message of "Sun\, 12 Jul 2009
 12\:24\:32 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A214FD5E-6F11-11DE-9432-424D1A496417-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123155>

Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:

> Also add missing --bare to init-db synopsis.
>
> Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
> ---
>  Documentation/git-init-db.txt |    2 +-
>  builtin-init-db.c             |   51 ++++++++++++++++++++++++-------=
----------
>  2 files changed, 31 insertions(+), 22 deletions(-)

The subject says patch v2 but there is no description since the previou=
s
round, nor ...

> diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-d=
b.txt
> index 1fd0ff2..eba3cb4 100644
> --- a/Documentation/git-init-db.txt
> +++ b/Documentation/git-init-db.txt
> @@ -8,7 +8,7 @@ git-init-db - Creates an empty git repository
>  ...
> diff --git a/builtin-init-db.c b/builtin-init-db.c
> index 4a56006..d68f61b 100644
> --- a/builtin-init-db.c
> +++ b/builtin-init-db.c
> @@ -6,6 +6,7 @@
> ...

=2E.. I see any change in the blob object name recorded on the index li=
ne.

What is going on?
