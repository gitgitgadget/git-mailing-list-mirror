From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] test-lib-functions.sh: fix the second argument to some helper functions
Date: Thu, 16 Apr 2015 16:38:21 +0200
Message-ID: <vpqoamop28y.fsf@anie.imag.fr>
References: <1429193527-1528-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 16 16:38:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yikw3-0007ZH-Rl
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 16:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754754AbbDPOi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 10:38:28 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49103 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753985AbbDPOi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 10:38:26 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t3GEcJ0Z016204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 16 Apr 2015 16:38:19 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t3GEcLwk032753;
	Thu, 16 Apr 2015 16:38:21 +0200
In-Reply-To: <1429193527-1528-1-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Thu, 16 Apr 2015 07:12:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 16 Apr 2015 16:38:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t3GEcJ0Z016204
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1429799901.73603@8CjlyZBSu46Y7yiPOf+PZA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267290>

Elia Pinto <gitter.spiros@gmail.com> writes:

> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -478,7 +478,7 @@ test_external_without_stderr () {
>  test_path_is_file () {
>  	if ! test -f "$1"
>  	then
> -		echo "File $1 doesn't exist. $*"
> +		echo "File $1 doesn't exist. $2"
>  		false
>  	fi
>  }
> @@ -486,7 +486,7 @@ test_path_is_file () {
>  test_path_is_dir () {
>  	if ! test -d "$1"
>  	then
> -		echo "Directory $1 doesn't exist. $*"
> +		echo "Directory $1 doesn't exist. $2"
>  		false
>  	fi
>  }

Sounds straightforwardly correct to me.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
