From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH -resend] Add a helper script to send patches with Mozilla
 Thunderbird
Date: Thu, 19 Jun 2008 17:43:12 -0700
Message-ID: <7vmylhq6lb.fsf@gitster.siamese.dyndns.org>
References: <484D6A40.60002@etek.chalmers.se>
 <485AE9FD.8050508@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Lukas =?utf-8?Q?Sandstr=C3=B6m?= <lukass@etek.chalmers.se>
X-From: git-owner@vger.kernel.org Fri Jun 20 02:44:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9Ujt-0002DM-Ca
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 02:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbYFTAnc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jun 2008 20:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbYFTAnc
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 20:43:32 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40711 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbYFTAnb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jun 2008 20:43:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 577D21D255;
	Thu, 19 Jun 2008 20:43:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7679D1D253; Thu, 19 Jun 2008 20:43:20 -0400 (EDT)
In-Reply-To: <485AE9FD.8050508@etek.chalmers.se> (Lukas =?utf-8?Q?Sandstr?=
 =?utf-8?Q?=C3=B6m's?= message of "Fri, 20 Jun 2008 01:21:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E3AC6F40-3E61-11DD-88C0-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85582>

Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se> writes:

> The script appp.sh can be used with the External Editor extension for
> Mozilla Thunderbird in order to be able to send inline patches in an
> easy way.
>
> Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
> ---
>
> Resending. It would be nice if this ended up in contrib/
>
> /Lukas
>
>  Documentation/SubmittingPatches          |    5 +++
>  contrib/thunderbird-patch-inline/README  |   20 +++++++++++
>  contrib/thunderbird-patch-inline/appp.sh |   55 ++++++++++++++++++++=
+++++++

A silly question.  What does "appp" stand for?  AppendPatch does not ha=
ve
that many P's in it.

> diff --git a/contrib/thunderbird-patch-inline/appp.sh b/contrib/thund=
erbird-patch-inline/appp.sh
> new file mode 100755
> index 0000000..cc518f3
> --- /dev/null
> +++ b/contrib/thunderbird-patch-inline/appp.sh
> @@ -0,0 +1,55 @@
> +#!/bin/bash
> +# Copyright 2008 Lukas Sandstr=C3=B6m <luksan@gmail.com>
> +#
> +# AppendPatch - A script to be used together with ExternalEditor
> +# for Mozilla Thunderbird to properly include pathes inline i e-mail=
s.
> ...

Eh, pathes?
