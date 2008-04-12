From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH/RFC 06/10] Unify the lenght of $SHORT* and the commits in
 the TODO list
Date: Fri, 11 Apr 2008 17:00:46 -0700
Message-ID: <7vej9cndqp.fsf@gitster.siamese.dyndns.org>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
 <1207785521-27742-1-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-2-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-3-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-4-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-5-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-6-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-7-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
To: =?utf-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Sat Apr 12 02:02:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkTBv-0003GF-KE
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 02:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756340AbYDLABG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Apr 2008 20:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755840AbYDLABF
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 20:01:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42804 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616AbYDLABD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Apr 2008 20:01:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D6D4E1F89;
	Fri, 11 Apr 2008 20:01:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 0974C1F88; Fri, 11 Apr 2008 20:00:53 -0400 (EDT)
In-Reply-To: <1207785521-27742-7-git-send-email-joerg@alea.gnuu.de>
 (=?utf-8?Q?J=C3=B6rg?= Sommer's message of "Thu, 10 Apr 2008 01:58:37 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79317>

J=C3=B6rg Sommer <joerg@alea.gnuu.de> writes:

> ---
>  git-rebase--interactive.sh |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 1698c3e..060b40f 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -600,9 +600,9 @@ do
>  			MERGES_OPTION=3D--no-merges
>  		fi
> =20
> -		SHORTUPSTREAM=3D$(git rev-parse --short $UPSTREAM)
> -		SHORTHEAD=3D$(git rev-parse --short $HEAD)
> -		SHORTONTO=3D$(git rev-parse --short $ONTO)
> +		SHORTUPSTREAM=3D$(git rev-parse --short=3D7 $UPSTREAM)
> +		SHORTHEAD=3D$(git rev-parse --short=3D7 $HEAD)
> +		SHORTONTO=3D$(git rev-parse --short=3D7 $ONTO)

Lacking is a better justification as to why this is a good change and 7=
 is
a good number.
