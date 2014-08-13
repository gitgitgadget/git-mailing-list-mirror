From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 1/5] fast-import.c: replace `git_config()` with `git_config_get_*()` family
Date: Wed, 13 Aug 2014 15:10:48 +0200
Message-ID: <vpq4mxgtu07.fsf@anie.imag.fr>
References: <1407918122-29973-1-git-send-email-tanayabh@gmail.com>
	<vpqppg4vdii.fsf@anie.imag.fr> <53EB58A0.10307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 15:11:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHYKN-0005y9-NU
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 15:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675AbaHMNKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 09:10:52 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59799 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024AbaHMNKv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 09:10:51 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s7DDAkYP011303
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 Aug 2014 15:10:47 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s7DDAmtI024357;
	Wed, 13 Aug 2014 15:10:48 +0200
In-Reply-To: <53EB58A0.10307@gmail.com> (Tanay Abhra's message of "Wed, 13 Aug
	2014 17:52:56 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 13 Aug 2014 15:10:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s7DDAkYP011303
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1408540247.73755@deY127/F2zYd61w10G61Vg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255209>

Tanay Abhra <tanayabh@gmail.com> writes:

> +	if (!git_config_get_int("pack.compression", &pack_compression_level)) {
> +		if (pack_compression_level == -1)
> +			pack_compression_level = Z_DEFAULT_COMPRESSION;
> +		else if (pack_compression_level < 0 ||
> +			 pack_compression_level > Z_BEST_COMPRESSION)
> +			git_die_config("pack.compression",
> +					"bad pack compression level %d", pack_compression_level);

Perfect. With v2 for PATCH 2 and PATCH 5, the series looks good to me.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
