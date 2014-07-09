From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 1/2] add `config_set` API for caching config-like files
Date: Wed, 09 Jul 2014 14:12:52 +0200
Message-ID: <vpq61j6d92z.fsf@anie.imag.fr>
References: <1404903454-10154-1-git-send-email-tanayabh@gmail.com>
	<1404903454-10154-2-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 14:13:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4qk9-0005ht-ME
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 14:13:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbaGIMM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 08:12:57 -0400
Received: from mx2.imag.fr ([129.88.30.17]:39148 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082AbaGIMM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 08:12:56 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s69CCpVM018522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 9 Jul 2014 14:12:51 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s69CCqXm024009;
	Wed, 9 Jul 2014 14:12:52 +0200
In-Reply-To: <1404903454-10154-2-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Wed, 9 Jul 2014 03:57:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 09 Jul 2014 14:12:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s69CCpVM018522
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1405512772.30041@JZXPV5RL+NMvpv95ktT1kQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253121>

Tanay Abhra <tanayabh@gmail.com> writes:

> diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
> index 230b3a0..65a6717 100644
> --- a/Documentation/technical/api-config.txt
> +++ b/Documentation/technical/api-config.txt

> +`int git_config_get_bool(const char *key, int *dest)`::
> +
> +	Finds and parses the value into a boolean value, for the configuration
> +	variable `key`respecting keywords like "true" and "false". Integer

Missing space after ` => badly formatted in HTML.

I didn't find any other formatting error, but you may double-check with

cd Documentation/ && make technical/api-config.html && firefox technical/api-config.html

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
