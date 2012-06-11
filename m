From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv2 1/2] git-remote-mediawiki: import "File:" attachments
Date: Mon, 11 Jun 2012 22:38:36 +0200
Message-ID: <vpq7gvd1t4j.fsf@bauges.imag.fr>
References: <1339442945-8561-1-git-send-email-Pavel.Volek@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Volek Pavel <me@pavelvolek.cz>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
To: Pavel Volek <Pavel.Volek@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 11 22:38:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeBNw-0002Q4-DG
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 22:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175Ab2FKUio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 16:38:44 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58888 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752138Ab2FKUin (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 16:38:43 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5BKTgGo026323
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 11 Jun 2012 22:29:42 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SeBNl-0004fY-1Q; Mon, 11 Jun 2012 22:38:37 +0200
In-Reply-To: <1339442945-8561-1-git-send-email-Pavel.Volek@ensimag.imag.fr>
	(Pavel Volek's message of "Mon, 11 Jun 2012 21:29:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 11 Jun 2012 22:29:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5BKTgGo026323
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1340051386.38948@qVHMk8b2B690IISgnlhWnQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199725>

Pavel Volek <Pavel.Volek@ensimag.imag.fr> writes:

> +		# Get pages of related media files.
> +		if ($import_media) {
> +			get_mw_pages_for_linked_mediafiles(\@tracked_pages, \%pages);
> +		}

The comment is useless given the function name.

> +# Returns MediaWiki id for a canonical namespace name.
> +# Ex.: "File", "Project".
> +# Looks for the namespace id in the local configuration
> +# variables, if it is not found asks MW API.

Functions are usually specified in imperative form, hence "Return", not
"Returns" for example.

> +	my $file = $mediawiki->download( { title => $filename } );

I'd call that $file_content, to avoid confusion with the file name.

Other than that, the patch looks good (but I didn't review very
carefully).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
