From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v10 2/2] pull --rebase: add --[no-]autostash flag
Date: Mon, 21 Mar 2016 19:39:58 +0100
Message-ID: <vpq37rjr7y9.fsf@anie.imag.fr>
References: <1458584283-23816-1-git-send-email-mehul.jain2029@gmail.com>
	<1458584283-23816-3-git-send-email-mehul.jain2029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com, pyokagan@gmail.com,
	sunshine@sunshineco.com
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 20:37:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai5dZ-0004Gd-7Z
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 20:37:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757626AbcCUTgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 15:36:37 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51063 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757208AbcCUTgg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 15:36:36 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u2LIdua9017728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 21 Mar 2016 19:39:56 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u2LIdwX0008893;
	Mon, 21 Mar 2016 19:39:58 +0100
In-Reply-To: <1458584283-23816-3-git-send-email-mehul.jain2029@gmail.com>
	(Mehul Jain's message of "Mon, 21 Mar 2016 23:48:03 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Mon, 21 Mar 2016 19:39:56 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u2LIdua9017728
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1459190396.84682@CAFDX2QPvBLy8FjRN2YblA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289446>

Mehul Jain <mehul.jain2029@gmail.com> writes:

> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -128,6 +128,15 @@ unless you have read linkgit:git-rebase[1] carefully.
>  --no-rebase::
>  	Override earlier --rebase.
>  
> +--autostash::
> +--no-autostash::
> +	Before starting rebase, stash local modifications away (see
> +	linkgit:git-stash.txt[1]) if needed, and apply the stash when

Please drop the ".txt" after linkgit.

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
