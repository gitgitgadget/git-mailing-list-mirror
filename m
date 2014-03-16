From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [PATCH] Documentation/git-am: Document supported --patch-format
 options
Date: Sun, 16 Mar 2014 20:59:14 +1300
Message-ID: <532559D2.3050802@gmail.com>
References: <1394509917-9679-1-git-send-email-judge.packham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 16 08:59:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WP5z5-0007t8-GZ
	for gcvg-git-2@plane.gmane.org; Sun, 16 Mar 2014 08:59:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbaCPH7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2014 03:59:20 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:44220 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973AbaCPH7T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2014 03:59:19 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so4292972pdi.19
        for <git@vger.kernel.org>; Sun, 16 Mar 2014 00:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=CHe5ucLvb2PKxeiXzcmHnK5rUJQep3Y/klS55VJ5ZKA=;
        b=iSGi3Ag/gZIA87Cj2ozETW6LG9cX5Tk2MpgdDiL0UVM35ZAdoiWfK1chwYsHfnPile
         Xgw2xVSsC59HQFFUmmeGevvp1vqHam6K970BK3uQCrqVi9g/paPS1uCikiLKSJGyCkxH
         F6QZ7UjUMBiJSKE0TjzIEfP7IMfz8+ktO+5Dy0jhDP4v276mFqv/4J5Dx94QDkusYLp9
         Bb44XvEJepsbH9CrLi0CfEb55/0RWwHO7IkBgy0SFhaqsjTq//tuzKT5GPvItV9N77Wg
         Ktqc9/oO17Nsryo//0ZiyLDJgSTG5ZQM35QChOh/8HkEKGYsHi3V/l1yx0Rk05Lw8ITy
         wupg==
X-Received: by 10.66.218.170 with SMTP id ph10mr18593237pac.53.1394956759251;
        Sun, 16 Mar 2014 00:59:19 -0700 (PDT)
Received: from linux.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id yz5sm53032623pac.9.2014.03.16.00.59.16
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 16 Mar 2014 00:59:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <1394509917-9679-1-git-send-email-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244182>

On 11/03/14 16:51, Chris Packham wrote:
> The --patch-format option has been supported for a while but it is not
> mentioned in the man page and the short help cannot tell the user what
> the supported formats are. Add the option to the man page along with the
> supported options.
> 
> Signed-off-by: Chris Packham <judge.packham@gmail.com>
> ---
> I've not bothered to actually explain what the options mean. I'm not
> sure if readers will care aside from just trying them until one works
> (that's all I did when I had a patch that failed detection).
> 
>  Documentation/git-am.txt |   12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> index 54d8461..76bd359 100644
> --- a/Documentation/git-am.txt
> +++ b/Documentation/git-am.txt
> @@ -12,9 +12,9 @@ SYNOPSIS
>  'git am' [--signoff] [--keep] [--[no-]keep-cr] [--[no-]utf8]
>  	 [--3way] [--interactive] [--committer-date-is-author-date]
>  	 [--ignore-date] [--ignore-space-change | --ignore-whitespace]
> -	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
> -	 [--exclude=<path>] [--include=<path>] [--reject] [-q | --quiet]
> -	 [--[no-]scissors]
> +	 [--whitespace=<option>] [-C<n>] [-p<n>] [--patch-format=<format>]
> +	 [--directory=<dir>] [--exclude=<path>] [--include=<path>]
> +	 [--reject] [-q | --quiet] [--[no-]scissors]
>  	 [(<mbox> | <Maildir>)...]
>  'git am' (--continue | --skip | --abort)
>  
> @@ -97,6 +97,12 @@ default.   You can use `--no-utf8` to override this.
>  	program that applies
>  	the patch.
>  
> +--patch-format::
> +	By default the command will try to detect the patch format
> +	automatically. This option allows the user to bypass the automatic
> +	detection and specify the patch format that the patch(es) should be
> +	intepreted as. Valid formats are mbox, stgit, stgit-series and hg.
> +
>  -i::
>  --interactive::
>  	Run interactively.
> 

Ping?

Actually now that I have the patch in a MUA I see the a simple
s/intepreted/interpreted/ fixup is required.
