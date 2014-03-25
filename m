X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 015/144] t0204-gettext-reencode-sanity.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 09:36:44 +0100
Message-ID: <vpq4n2m7jz7.fsf@anie.imag.fr>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
	<1395735989-3396-16-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 25 Mar 2014 08:36:51 +0000 (UTC)
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
In-Reply-To: <1395735989-3396-16-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Tue, 25 Mar 2014 01:24:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 25 Mar 2014 09:36:43 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s2P8ahkG027825
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1396341404.72155@PmDxvftft2kX7tMo6hgmbQ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245000>
Received: from vger.kernel.org ([209.132.180.67]) by plane.gmane.org with
 esmtp (Exim 4.69) (envelope-from <git-owner@vger.kernel.org>) id
 1WSMqy-0001pQ-8E for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:37:00
 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753345AbaCYIgv convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:36:51 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60634 "EHLO rominette.imag.fr"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1753702AbaCYIgs
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 25 Mar 2014 04:36:48 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215]) by
 rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s2P8ahkG027825
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); Tue, 25
 Mar 2014 09:36:43 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32]) by
 clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s2P8aiUH022449; Tue, 25 Mar
 2014 09:36:44 +0100
Sender: git-owner@vger.kernel.org

Elia Pinto <gitter.spiros@gmail.com> writes:

> --- a/t/t0204-gettext-reencode-sanity.sh
> +++ b/t/t0204-gettext-reencode-sanity.sh
> @@ -58,7 +58,7 @@ test_expect_success GETTEXT_LOCALE 'gettext: Fetchi=
ng a UTF-8 msgid -> UTF-8' '
>  # How these quotes get transliterated depends on the gettext impleme=
ntation:
>  #
>  #   Debian:  ,einfaldar' og ,,tv=F6faldar" [GNU libintl]
> -#   FreeBSD: `einfaldar` og "tv=F6faldar"  [GNU libintl]
> +#   FreeBSD: $(einfaldar) og "tv=F6faldar"  [GNU libintl]
>  #   Solaris: ?einfaldar? og ?tv=F6faldar?  [Solaris libintl]

I don't think you wanted this to be changed.

--=20
Matthieu Moy
