From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1 2/2] travis-ci: enable sequential test execution for t9113 and 9126
Date: Sun, 22 May 2016 12:10:28 +0200
Message-ID: <7A9DE9C1-4AC7-4FF3-B8B1-26DE84BA625B@gmail.com>
References: <1463649009-56941-1-git-send-email-larsxschneider@gmail.com> <1463649009-56941-3-git-send-email-larsxschneider@gmail.com> <20160519100658.GA20225@dcvr.yhbt.net> <xmqqwpmqj7m1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <e@80x24.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 22 12:11:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4QLC-0001uE-R7
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 12:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbcEVKKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2016 06:10:30 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38005 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbcEVKK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2016 06:10:29 -0400
Received: by mail-wm0-f51.google.com with SMTP id n129so37127387wmn.1
        for <git@vger.kernel.org>; Sun, 22 May 2016 03:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=A4Vo3FdIOJvDTT2RpiJlImsgosZDTfGtUCVl1a+ZHQM=;
        b=MQ8EofNmjmOZwox4t2eQ69b9gLaAoBSZCNrUZERNwgYxWo2zxOMtlj78okSvdRxFkA
         4FeO4g8syqoV9nxOHWhtv2NKhNv76CZMUN4hVkAC3y5P1Zy4XDmhcJ1GJHg6YWJm7b53
         MpN/YlB/n2lBkCkiM6RrpxBbeHBVjSxRK5+OlUw+jvr7m+/ytqc+dA047pfyRDze15tc
         x+BCmv6pegvvzOpnp8q+IlkjTR+wU4jXeLlthnZduZi8ZEFp7ytj6vscdDgb4KCS5VD8
         E6KNcQcOmtUaYMOEjqIksSzr6d66F8txur8hnygydO/6/uYD/ZOrc4mr5g8cc5P7tPpt
         kw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=A4Vo3FdIOJvDTT2RpiJlImsgosZDTfGtUCVl1a+ZHQM=;
        b=NcNMVb4cI1gMkftqLNbYgItxNWdQxkAYxFUNCLuiQa1h5mN7kFmEOMTstqtiL1VHd/
         qaeTOcB0yLT/i1rlSSFIfJakLBT2/VjE4YEdEKaF4pzxXXua4n/WeHjXAmQI7K0Pzy+p
         Jzsm4YkKaO/Na3ZsW3AWGF7i2Bm6V12jezEoB09Bbh9BtKkz9tAiHZSv0lkih+VTUxzb
         L7aAgfYL9QBzWlJya37EAcd+++gwvpIUiBZqZPQ+EAd6JXEgUh+5IdDUsK9w8ZDOT5zX
         KZRykxQLTJ2WKksA5UQ+vca5pztaK66/jnRPtNg2FjbJHE8pK/6GicxsjvZO0g7TH4jY
         mlew==
X-Gm-Message-State: AOPr4FVZP7L8aWKkWX/30SSplRiOaxNFmH7O7vftPPhBjj/o/rnZ9u75MJ3FAod5y9eFRQ==
X-Received: by 10.28.1.151 with SMTP id 145mr11033944wmb.25.1463911827615;
        Sun, 22 May 2016 03:10:27 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB5ECD.dip0.t-ipconnect.de. [93.219.94.205])
        by smtp.gmail.com with ESMTPSA id xt9sm29119884wjb.17.2016.05.22.03.10.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 May 2016 03:10:26 -0700 (PDT)
In-Reply-To: <xmqqwpmqj7m1.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295268>


> On 19 May 2016, at 19:11, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Eric Wong <e@80x24.org> writes:
> 
>> Anyways, how about making the tests run on separate ports and
>> not worry about serializing them at all?
> 
> Yeah, that does sound like a more sensible approach.

Makes sense. However, it's not something I will tackle soon.
Would you be willing to pick up $gmane/295048 (the first patch) as is 
and drop $gmane/295050 (the patch discussed here)? Then the majority
of Git SVN tests would run on Travis CI.

Thanks,
Lars
