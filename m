From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 1/2] parse-options: Add support for dumping out long options
Date: Thu, 12 Apr 2012 00:02:28 -0700
Message-ID: <4F867E04.8000501@gmail.com>
References: <1334140165-24958-1-git-send-email-bebarino@gmail.com> <1334140165-24958-2-git-send-email-bebarino@gmail.com> <20120411125921.GC3161@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, spearce@spearce.org, szeder@ira.uka.de,
	felipe.contreras@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 09:02:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIE3B-0003wZ-LV
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 09:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762005Ab2DLHCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 03:02:33 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:47541 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756945Ab2DLHCc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 03:02:32 -0400
Received: by obbtb18 with SMTP id tb18so2338581obb.19
        for <git@vger.kernel.org>; Thu, 12 Apr 2012 00:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=gAyvMsUsFL63IYWJLubP+2Ldzd2cBehJdukCjO1KBt0=;
        b=ddmrgcdgbMRNV0w+KZO5KlBpyyMYqVi2SaLbBZbn7mSzc8rUPDU7rFuSCEa2QgHClJ
         7qMo17PrAP725ZXRjOn8i1nXB4NYYa3pl4AXve3WVuGLU6Qv3nhF71+JNU9rCM95Sk/5
         HcvL3MHReSHIQEJkJw3Ln/ozMai/EiahqbEjJSselKPopkertRIOPHILXf5EH0RJ4APT
         VljthZwu8u5DST9yHEqWsDz8kNk1kU9n701F8oIoPfoMCSdhVVxAkTfjLjalUDjWnOwO
         QG/ngdSzGUXjM5mJDZRbiO8pAGQG1zyz6y41EfQx+YS2Yzu797gwgUNy6jeNqs3ngCWZ
         NLxQ==
Received: by 10.182.119.101 with SMTP id kt5mr1525314obb.70.1334214151648;
        Thu, 12 Apr 2012 00:02:31 -0700 (PDT)
Received: from [192.168.2.10] (ip68-105-100-241.sd.sd.cox.net. [68.105.100.241])
        by mx.google.com with ESMTPS id w4sm4958197oeg.12.2012.04.12.00.02.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Apr 2012 00:02:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110911 Thunderbird/6.0
In-Reply-To: <20120411125921.GC3161@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195304>

On 04/11/2012 05:59 AM, Jonathan Nieder wrote:
> Stephen Boyd wrote:
> 
>> The bash completion script wants to know what the long options are for a
>> certain command at runtime. Add a magical long option that nobody could
>> possibly ever use (--dump-raw-long-options) to get this information.
> 
> Neat.  Probably should be documented:
> 
> diff --git i/Documentation/gitcli.txt w/Documentation/gitcli.txt
> index f734f97b..0de074ec 100644
> --- i/Documentation/gitcli.txt
> +++ w/Documentation/gitcli.txt
> @@ -96,6 +96,11 @@ usage: git describe [options] <committish>*
>  	are deprecated, and such options are hidden from the default usage. This
>  	option gives the full list of options.
>  
> +--dump-raw-long-options::
> +	prints a space-separated list of supported options, including
> +	negated `--no-<foo>` forms.  Long options taking an argument are
> +	printed with a trailing equal sign, as in "`--depth=`".
> +
>  
>  Negating options
>  ~~~~~~~~~~~~~~~~

Thanks. Squashed in.
