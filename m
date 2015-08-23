From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v13 11/12] tag.c: implement '--format' option
Date: Sun, 23 Aug 2015 21:56:54 +0200
Message-ID: <vpq37z9lqwp.fsf@anie.imag.fr>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
	<1440214788-1309-12-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 23 21:57:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTbOK-00041w-J4
	for gcvg-git-2@plane.gmane.org; Sun, 23 Aug 2015 21:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839AbbHWT5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2015 15:57:11 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46142 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752728AbbHWT5K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2015 15:57:10 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t7NJuqiE031112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 23 Aug 2015 21:56:52 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t7NJusLG014908;
	Sun, 23 Aug 2015 21:56:54 +0200
In-Reply-To: <1440214788-1309-12-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Sat, 22 Aug 2015 09:09:47 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 23 Aug 2015 21:56:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t7NJuqiE031112
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1440964616.3113@9hC+7ztbMsHX7gS1wbEKLA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276425>

Karthik Nayak <karthik.188@gmail.com> writes:

> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -13,7 +13,8 @@ SYNOPSIS
>  	<tagname> [<commit> | <object>]
>  'git tag' -d <tagname>...
>  'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
> -	[--column[=<options>] | --no-column] [--create-reflog] [--sort=<key>] [<pattern>...]
> +	[--column[=<options>] | --no-column] [--create-reflog] [--sort=<key>]
> +	[--format=<format>] [<pattern>...]
>  'git tag' -v <tagname>...
>  
>  DESCRIPTION
> @@ -158,6 +159,11 @@ This option is only applicable when listing tags without annotation lines.
>  	The object that the new tag will refer to, usually a commit.
>  	Defaults to HEAD.
>  
> +<format>::

Shouldn't this be --format <format>, not just <format>? We usually use
the named argument in the SYNOPSIS for positional arguments, but not for
arguments following an option.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
