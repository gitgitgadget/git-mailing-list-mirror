From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: How to identify the users?
Date: Thu, 31 Jan 2013 15:42:08 +0530
Message-ID: <510A4378.9010302@gmail.com>
References: <CACkbei+Jby13B7rsEb3iLQM2ZSFDgrkgvrYC5M7u4yatppvLxA@mail.gmail.com> <1359612481-ner-5936@calvin> <510A0ACF.5060501@gmail.com> <CACkbei+_dJowH-odL+UCS3hQwOwFZ7B5_6sxw=ZZg1V4=upSKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Tomas Carnecky <tomas.carnecky@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Scott Yan <scottyan19@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 11:12:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0r8I-0000jD-Lz
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 11:12:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446Ab3AaKMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 05:12:16 -0500
Received: from mail-pb0-f52.google.com ([209.85.160.52]:41350 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754086Ab3AaKMO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 05:12:14 -0500
Received: by mail-pb0-f52.google.com with SMTP id mc8so787791pbc.25
        for <git@vger.kernel.org>; Thu, 31 Jan 2013 02:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=RL8w5Q71AsQlQGVcKEuWYm8tRG6C5OHcxildklnWz7k=;
        b=kLkejB89JEoJBu4CQi6L/XHc6BK8cM7L7DhRyqdKqpEH3IJH85CpxvMHg82q26uy2n
         FkWs2rSS5unBVjHv6juqcTt6bG7SvrcV5//RSwUQJo4jPEFVv2Z4C/Doz9JIs3S4P3FH
         URnHh7+hjhH98ddLon1O+lEaTV/xNDf1DyJmq0f+VFtPX2NvMTCMiuydMIMr+9cDa24X
         4kubqwcazn3e68tdHLCRq9sXClQdzz3Z/T0LnYL7xeshnjWQsc056yv1rjfX9hVprv9A
         bJY6uPHhCd6K5iynpeAVg6vJ8RTy8U8lM8WHwbw2tuasNtohxzKjMKp6r82czD+Va7Dl
         uMQA==
X-Received: by 10.68.219.67 with SMTP id pm3mr20730185pbc.150.1359627133681;
        Thu, 31 Jan 2013 02:12:13 -0800 (PST)
Received: from sita-lt.atc.tcs.com (atcmail.atc.tcs.co.in. [203.200.212.145])
        by mx.google.com with ESMTPS id od3sm4605188pbb.6.2013.01.31.02.12.10
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 31 Jan 2013 02:12:12 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <CACkbei+_dJowH-odL+UCS3hQwOwFZ7B5_6sxw=ZZg1V4=upSKg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215111>

On 01/31/2013 12:23 PM, Scott Yan wrote:

> Sitaram:
> 
> It seems I must host my central repo on Gitolite first...

There is no "must" but yes it is a decent solution and can, in
principle, do the kind of checking you want if you set it up to do that.
 Please note that I don't use that mode and, as my rant would have
indicated, I don't think it's a smart thing to do.

> I don't know Gitolite much, but you are right, maybe I should use
> Gitolite as my git server.
> I'll find more documents about gitolite these days,
> can you give me some suggestion which tutorial should I read?  Thanks!
> ps: my OS is windows.

Try
http://therightstuff.de/CommentView,guid,b969ea4d-8d2c-42af-9806-de3631f4df68.aspx

I normally don't mention blog posts (favouring instead the official
documentation) but Windows is an exception.  Hence the link.

Good luck.
