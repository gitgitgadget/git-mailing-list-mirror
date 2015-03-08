From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] reset: allow "-" short hand for previous commit
Date: Sun, 08 Mar 2015 11:33:51 +0100
Message-ID: <vpqioeb22y8.fsf@anie.imag.fr>
References: <xmqq1tl4705j.fsf@gitster.dls.corp.google.com>
	<1425762244-8629-1-git-send-email-sudshekhar02@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com
To: Sudhanshu Shekhar <sudshekhar02@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 11:34:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUYX5-0007tw-7O
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 11:34:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbbCHKd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 06:33:58 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60836 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751368AbbCHKd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 06:33:57 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t28AXokq007444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 8 Mar 2015 11:33:50 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t28AXphh020857;
	Sun, 8 Mar 2015 11:33:51 +0100
In-Reply-To: <1425762244-8629-1-git-send-email-sudshekhar02@gmail.com>
	(Sudhanshu Shekhar's message of "Sun, 8 Mar 2015 02:34:04 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 08 Mar 2015 11:33:50 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t28AXokq007444
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1426415632.17263@rPkI/EA8GrO4WkeTvvCIvQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265082>

Sudhanshu Shekhar <sudshekhar02@gmail.com> writes:

> +		if(!strcmp(argv[0], "-")) {
[...]
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 9f8967d..02f33ef 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -206,7 +206,7 @@ static void parse_args(struct pathspec *pathspec,
>  	 */
>  
>  	if (argv[0]) {
> -		if(!strcmp(argv[0], "-")) {
> +		if (!strcmp(argv[0], "-")) {

Please, squash this hunk into the previous patch, so that reviewers get
the right version right away.

Also, send each patch as a separate email (git send-email can do that
for you).

> +	test_must_fail git reset - 2> output &&

Here and elsewhere: no space after >.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
