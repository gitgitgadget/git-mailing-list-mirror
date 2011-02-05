From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Add support for merging from upstream by default.
Date: Sat, 05 Feb 2011 11:03:09 +0100
Message-ID: <m2k4he23z6.fsf@whitebox.home>
References: <1296866721-27818-1-git-send-email-jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 05 11:03:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlezB-0003aw-N2
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 11:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657Ab1BEKDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 05:03:10 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:59088 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136Ab1BEKDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 05:03:09 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 79A9D1C0F593;
	Sat,  5 Feb 2011 11:03:07 +0100 (CET)
X-Auth-Info: 6N11I1q3Y62mQWK0pifoAWlHAbD24mCqiLi86AWnKIs=
Received: from linux.local (ppp-88-217-112-144.dynamic.mnet-online.de [88.217.112.144])
	by mail.mnet-online.de (Postfix) with ESMTPA id 6ECDA1C00203;
	Sat,  5 Feb 2011 11:03:07 +0100 (CET)
Received: by linux.local (Postfix, from userid 501)
	id 8A4BB1E5434; Sat,  5 Feb 2011 11:03:09 +0100 (CET)
X-Yow: FROZEN ENTREES may be flung by members of opposing SWANSON SECTS..
In-Reply-To: <1296866721-27818-1-git-send-email-jaredhance@gmail.com> (Jared
	Hance's message of "Fri, 4 Feb 2011 19:45:21 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166083>

Jared Hance <jaredhance@gmail.com> writes:

> diff --git a/builtin/merge.c b/builtin/merge.c
> index 42fff38..a69b69f 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -37,6 +37,7 @@ struct strategy {
>  };
>  
>  static const char * const builtin_merge_usage[] = {
> +        "git merge",

Doesn't that form take options as well?

>  	"git merge [options] <remote>...",

IOW, how about changing that to

  	"git merge [options] [<remote>...]",

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
