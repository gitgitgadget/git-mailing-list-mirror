From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v1] config: add '--sources' option to print the source of
 a config value
Date: Fri, 5 Feb 2016 12:31:15 +0100
Message-ID: <56B48803.9080909@gmail.com>
References: <1454661750-85703-1-git-send-email-larsxschneider@gmail.com>
 <20160205112001.GA13397@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Fri Feb 05 12:31:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRebj-0000P6-FB
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 12:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752452AbcBELbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 06:31:19 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36629 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbcBELbS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 06:31:18 -0500
Received: by mail-wm0-f67.google.com with SMTP id 128so2558907wmz.3
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 03:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=xxxsQUAQRS55znuzQFE3yADpHtZeVavUScZOu9MJ+Bk=;
        b=TiDCbwG7Fr1Gx4JSBFnV9UKoGGhYzcOztzO/TbCJMPGVvbvathMXU0slmwRWY7qkbT
         JgdInrOFusrA/vwUVVpwHJ5Ftu4nlivLV/A3cVas/q1sJTlriY+vgB0CkkGxCgniHbkA
         G1+k4ZCd/a68HXk/sNkv1mNk/GdmdBFZp74VUsmt/D/QF1tTtUtzpmpPvZ2HOwxWnj3i
         DOL4vI7UDRuW7oCdzJnJeFw7hN6KPrV0bju0Gb0DsNAquIFqZKcEzz05LnblMSCQf+n9
         CqSmJjjAe7aClyF5MCe71iqJfyk8QoE6X2ZZuCwV39ZmWhhn9dclcowoYMacKeVJ7yth
         yy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=xxxsQUAQRS55znuzQFE3yADpHtZeVavUScZOu9MJ+Bk=;
        b=RVYW/y1nJR9glj/z6g0s+rgNwwjQe3FWfHWNWBFeJT9JDed4Rfz2eARF6aLYHlwob9
         WgeOcAZeR74hrswyDLrai7Xoudx4Vfh7AYaDBUPBiDD57CTYiHXlfBFQwFewA7tQTFuq
         0NjWJ4SK/9rSEWZ2imjqMByE82eo/m0CpPsFeRKRALV+X1zzy790dX71xv8Th+cCwU96
         ylM3NsKwHBsImwXPKC6QQpJXbDdCWJ4+A1ddZ5mtyTsq4u0G1tLSJuwAebAYSAh8zX3P
         Pm2OlNxOlBe1O7MoGY3oEFuWJ3GuOZrLZkHvfj/RMgze7xTcHuETUwYAeJdr2c/dbSQS
         2TOg==
X-Gm-Message-State: AG10YOSfOASTN8Utf9gXiKjtzORyO8mcS+VUQG/1Ga0FXUQIXrMfwqSsuI9/O38qVHGx/A==
X-Received: by 10.28.11.73 with SMTP id 70mr15606015wml.40.1454671877248;
        Fri, 05 Feb 2016 03:31:17 -0800 (PST)
Received: from [10.223.62.214] ([131.228.216.134])
        by smtp.googlemail.com with ESMTPSA id i1sm575448wjs.45.2016.02.05.03.31.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Feb 2016 03:31:16 -0800 (PST)
Newsgroups: gmane.comp.version-control.git
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <20160205112001.GA13397@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285571>

On 2/5/2016 12:20, Jeff King wrote:

> Hmm. I had originally envisioned this only being used with "--list", but
> I guess it makes sense to say "--sources --get" to show where the value
> for a particular option is coming from.

Being able to use "--sources --get" is a feature that I'd definitely 
like to see, too.

> I'm not sure returning here is the best idea. We won't have a config
> filename if we are reading from "-c", but if we return early from this
> function, it parses differently than every other line. E.g., with your
> patch, if I do:
>
>    git config -c foo.bar=true config --sources --list
>
> I'll get:
>
>    /home/peff/.gitconfig <tab> user.name=Jeff King
>    /home/peff/.gitconfig <tab> user.email=peff@peff.net
>    ...etc...
>    foo.bar=true
>
> If somebody is parsing this as a tab-delimited list, then instead of the
> source field for that line being empty, it is missing (and it looks like
> "foo.bar=true" is the source file). I think it would be more friendly to
> consumers of the output to have a blank (i.e., set "fn" to the empty
> string and continue in the function).

Or to come up with a special string to denote config values specified on 
the command line. Maybe somehting like

     <command line> <tab> foo.bar=true

I acknowledge that "<command line>" would be a valid filename on some 
filesystems, but I think the risk is rather low that someone would 
actually be using that name for a Git config file.

Regards,
Sebastian
