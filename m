From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/2] pull: handle --log=<n>
Date: Wed, 13 May 2015 11:38:47 +0200
Message-ID: <vpqlhgszujc.fsf@anie.imag.fr>
References: <1431508661-21729-1-git-send-email-pyokagan@gmail.com>
	<1431508661-21729-3-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 11:39:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsT83-0007Bz-Dt
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 11:39:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933470AbbEMJiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 05:38:54 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42439 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753574AbbEMJiw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 05:38:52 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t4D9cjkp003280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 May 2015 11:38:45 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4D9clTh021824;
	Wed, 13 May 2015 11:38:47 +0200
In-Reply-To: <1431508661-21729-3-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Wed, 13 May 2015 17:17:41 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 13 May 2015 11:38:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4D9cjkp003280
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1432114727.37645@/L6vTu4eV4AtJ5BIwm6TJg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268966>

Paul Tan <pyokagan@gmail.com> writes:

> -	--log|--no-log)
> -		log_arg=$1 ;;
> +	--log|--log=*|--no-log)
> +		log_arg="$1" ;;

I think you actually don't need the double quotes here (var=$value works
even if $value has spaces IIRC), but they don't harm and I prefer having
them.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
