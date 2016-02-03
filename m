From: Luca Milanesio <luca.milanesio@gmail.com>
Subject: Re: Bug: Wrong GitHub API result when retrieving repository information
Date: Wed, 3 Feb 2016 08:39:38 +0000
Message-ID: <5C530CF9-26F8-4095-A776-E11D8FF49DEF@gmail.com>
References: <7f00f77e5c8946ae8a17c76feb7dc98b@DGPR01.novatec-gmbh.de>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Wert Alexander <Alexander.Wert@novatec-gmbh.de>
X-From: git-owner@vger.kernel.org Wed Feb 03 09:42:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQt0x-0008RO-3E
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 09:42:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756606AbcBCImL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 03:42:11 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35219 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756768AbcBCIjl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Feb 2016 03:39:41 -0500
Received: by mail-wm0-f49.google.com with SMTP id r129so153584727wmr.0
        for <git@vger.kernel.org>; Wed, 03 Feb 2016 00:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:mime-version:subject:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VSD68L/5bUt4TUEc1mV1x3qJphwziUB7Vx7S8fgBaYU=;
        b=btSWDGRZnqzmpraCbT5X1Tu7m/IUg8iOl06v0IMvWKV69m3Q42manLrvmkyPxjXoqY
         sJrpgrNHNFVGA+QfJk8iQk4MDETS87G20AJjeZp3Evwi04s+6lUPYM4GElLvRM6thBmT
         pF72n7z0eXtIt1MudQwUJ7oLa6qWGboqtzR8NcTr8eqiV/vPdV2S2HwCm+yOa7F0/q4D
         RKWW8pnVPb+l8PTj6FvH9B4Cqc1fBNp3vnKYuTLfsz9y6L6cTlxl4MjRz7IiG2QEUIZA
         rjvJ1PgEISdwDzHHtgGCflk+Pi+W6yh6JoORjQPePFm2h0E9oTQlC5dxpG52HJyhwQsT
         OtNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-type:mime-version:subject
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=VSD68L/5bUt4TUEc1mV1x3qJphwziUB7Vx7S8fgBaYU=;
        b=BTLfY47OWaAlH5k10rK16fvJv5nXJqbaH5szR4mg0QnhIv9jvPjLCeFqPQUisi3XJm
         Fn6Y/2NCfkYc9rEt+EalypOK0tKSQOjaLFCks6/tzDo3TX4a7BTlmwLlSBizN0modoPx
         CwK7l+1JD7RH4gsk5qrONS5WjQnu+7/UpDZNDTxRdbMlFrMJGB5bEpOxSrTD4EXJoK8a
         iJG6KUkEnxj02iOMLngA4SdkU4bO/9VwcPpdL3sadOUJS3XQnYhKN82HX/Np5SlMZnn9
         5GVJLEkI/zlSBsYN42hiwgsoqBIJp2K4hOFEhSfhDc6htK7jet7NRIrrE+J9Jqhrq2an
         HjMQ==
X-Gm-Message-State: AG10YOT8E25L7PEQ1/pYFtCYllbEtkAbbEc1l4zIpnmhzb5X4xwqU3DtsTCYPpouVcJRAg==
X-Received: by 10.28.93.140 with SMTP id r134mr2511204wmb.80.1454488780467;
        Wed, 03 Feb 2016 00:39:40 -0800 (PST)
Received: from [172.16.128.246] ([212.84.183.195])
        by smtp.gmail.com with ESMTPSA id m67sm17797268wma.10.2016.02.03.00.39.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 03 Feb 2016 00:39:39 -0800 (PST)
X-Google-Original-From: Luca Milanesio <Luca.Milanesio@gmail.com>
In-Reply-To: <7f00f77e5c8946ae8a17c76feb7dc98b@DGPR01.novatec-gmbh.de>
X-Mailer: Apple Mail (2.3112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285342>

Wrong mailing list?

> On 3 Feb 2016, at 06:58, Wert Alexander <Alexander.Wert@novatec-gmbh.de> wrote:
> 
> Dear GitHub Developers,
> 
> I'm using the GitHub API for retrieving statistics like stargazers_count or watchers_count.
> Unfortunately, an API call to https://api.github.com/users/<USER>/repos returns (as JSON) the same number for stargazers_count and watchers_count, although on the Website the numbers are different.
> 
> Example:
> ...
> "size": 5279,
> "stargazers_count": 51,
> "watchers_count": 51,
> "language": "Java",
> ...
> 
> 
> The actual count on the website, however,  are 51 for stargazers and 20 for watchers.
> 
> Any idea what could be the problem?
> 
> Thank you in advance!
> 
> Regards,
> Alexander Wert
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
