From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v6 01/13] test-lib: unset GIT_NOTES_REF to stop it from
 influencing tests
Date: Thu, 11 Mar 2010 09:55:05 +0100
Message-ID: <201003110955.06170.johan@herland.net>
References: <cover.1268229087.git.trast@student.ethz.ch>
 <31001e0ddcf756d542e2c899f61c78e25beaf6fa.1268229087.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: Thomas Rast <trast@student.ethz.ch>, Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 11 09:55:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpeAp-0002GO-2G
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 09:55:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753037Ab0CKIzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 03:55:11 -0500
Received: from smtp.getmail.no ([84.208.15.66]:51327 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752702Ab0CKIzK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 03:55:10 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KZ400IUA0RWA080@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 11 Mar 2010 09:55:08 +0100 (MET)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KZ400J5A0RV0V30@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 11 Mar 2010 09:55:08 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.3.11.84232
User-Agent: KMail/1.13.1 (Linux/2.6.32-ARCH; KDE/4.4.1; x86_64; ; )
In-reply-to: <31001e0ddcf756d542e2c899f61c78e25beaf6fa.1268229087.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141942>

On Wednesday 10 March 2010, Thomas Rast wrote:
> ---
> 
> 
>  t/test-lib.sh |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index a0e396a..400bc6b 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -54,6 +54,7 @@ unset GIT_OBJECT_DIRECTORY
>  unset GIT_CEILING_DIRECTORIES
>  unset SHA1_FILE_DIRECTORIES
>  unset SHA1_FILE_DIRECTORY
> +unset GIT_NOTES_REF
>  GIT_MERGE_VERBOSITY=5
>  export GIT_MERGE_VERBOSITY
>  export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME

Acked-by: Johan Herland <johan@herland.net>


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
