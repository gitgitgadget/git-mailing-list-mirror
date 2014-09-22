From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: How to compile Git with NDK?
Date: Mon, 22 Sep 2014 23:22:59 +0200
Message-ID: <54209333.7090300@gmail.com>
References: <CAHd499C3iwpcGf+Zt+jDJfqW41P=6Uu=b8VGZKJpFZCtw56beg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Robert Dailey <rcdailey.lists@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 22 23:23:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWB4b-0001Wg-Am
	for gcvg-git-2@plane.gmane.org; Mon, 22 Sep 2014 23:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754339AbaIVVXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2014 17:23:00 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:48817 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128AbaIVVW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2014 17:22:59 -0400
Received: by mail-wg0-f52.google.com with SMTP id n12so1691608wgh.23
        for <git@vger.kernel.org>; Mon, 22 Sep 2014 14:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=iIv30tT7caRrWbrOQek1IOYZnvHeI4sG48FB/DsR+Gs=;
        b=czPSQe4c4jvPk4yTWTKUo53MwYJv2o9U/ID4AGcdgV9oYvHw7gVCfZ2BfC9RF026S6
         JPr0JpwAn9f7uUeiGyocYkndvEl5lxrl2mATsLyKHGikvsm2170UoY0zyrDAt61MCNvG
         C916+7CcAIU4MUup7bnI8OwhxqJOGFRECKSIpJ5e+1FSnY+1n4cQQWK69ShqFsm6bwKL
         tJZhvSof1PS37C8aImByatvO/Cmabp4m88HOJwRfq/+opCjqAtEt20U/z6IE0U3QgY4A
         zH7ntfhibciJc1eRScyJLFPxsz2iFNjhUn9ULybiR2dyAcOO0/TdbmnNXJwnMBkRjZtT
         omWw==
X-Received: by 10.194.187.241 with SMTP id fv17mr23446508wjc.13.1411420978811;
        Mon, 22 Sep 2014 14:22:58 -0700 (PDT)
Received: from [192.168.1.7] (p5B0957B5.dip0.t-ipconnect.de. [91.9.87.181])
        by mx.google.com with ESMTPSA id td9sm14173wic.15.2014.09.22.14.22.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Sep 2014 14:22:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <CAHd499C3iwpcGf+Zt+jDJfqW41P=6Uu=b8VGZKJpFZCtw56beg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257385>

On 22.09.2014 21:04, Robert Dailey wrote:
> I run the following on Ubuntu:
> 
> fe@BLD01:~/code/git$ autoconf
> fe@BLD01:~/code/git$ ./configure --prefix=/home/fe/git-arm
> --build=x86_64-linux-gnu --host=arm-linux-androideabi
> configure: Setting lib to 'lib' (the default)
> configure: Will try -pthread then -lpthread to enable POSIX Threads.
> configure: CHECKS for site configuration
> checking for arm-linux-androideabi-gcc... arm-linux-androideabi-gcc
> checking whether the C compiler works... no
> configure: error: in `/home/fe/code/git':
> configure: error: C compiler cannot create executables
> See `config.log' for more details
> 
> 
> I have my NDK's prebuilt GCC 4.8 toolchain on PATH (the bin folder).
> Can someone help me cross compile Git using Android NDK toolchain?
> 
> Thanks.

You don't need autoconf, just type 'make' and you'll be fine.

Please read the file INSTALL for installation instructions.

    Stefan
