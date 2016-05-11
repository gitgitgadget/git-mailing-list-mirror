From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: What's cooking in git.git (May 2016, #02; Fri, 6)
Date: Wed, 11 May 2016 09:41:58 +0200
Message-ID: <D959E215-A37B-4F2E-AE09-FA4055E886CE@gmail.com>
References: <xmqqeg9e24ay.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1605100751050.4092@virtualbox>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 11 09:42:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0OmX-0006nJ-Dp
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 09:42:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbcEKHmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 03:42:05 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35583 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbcEKHmD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 May 2016 03:42:03 -0400
Received: by mail-wm0-f43.google.com with SMTP id e201so206731336wme.0
        for <git@vger.kernel.org>; Wed, 11 May 2016 00:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tr8N78Hoy6tYOPSoGx19UePZ1Ba01PzkSoeWu4TT1Ro=;
        b=EYuPC1jgFASmEVv5Y2Wz8OGwemBaZrjpIyfeysjko+HDcKrwStti2Ir1gdwYMXrdYE
         aibJy8WC0dbaCuHLTLPHXUFmOkf0L7MmXKaBoJtjJd0C5E0wC6ijtWC52g6bjMyWmzSd
         mCire6VTpPVw+x1ARkyzeLnIOuck4+KW6h/AdwtMryngyDv+s6gEHoDdRcrZ5v3OtBOH
         JNGSN58Doqb0wYAJZND2yddhfAmJbxj5y+Z09iGbxMDtyfvH/3sr7Clu34Ffamc6NebI
         RmbGKBWOWifiZwjIxelV17HqqhZ7Q0Hm6p1n48klDwIaVLBiBkMlxAyz3oNF4LO/vODB
         Uw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tr8N78Hoy6tYOPSoGx19UePZ1Ba01PzkSoeWu4TT1Ro=;
        b=HlCWuzWLQ90OI1jEcejMRPiG16udmVmxcYAnZHh19jLVst+xmuVLvCl/Fdma4tdEyb
         d+Rk+2yNBn+DMkdLXyOJNqLqQ6BkWUPQZqae46vsbMooWLb1nWUoSM4n3HCNsG27m9DZ
         QkJypKp1bOqLkYjVKIbV0w8JZnj/DoTf84pZO9qWM1jCNjongjDT+t4mN5o2b9glvpB9
         H3Olr9OEctPnUs/1xrfy2MLUKjEEPN2BNAWO71H5EZ7JYsIgJRI70cEPVy46/u2rcjQ5
         pIYPJQ4Gvpu2e8fr4Oy3LbTh5Kx/0foZqIBqDovkIK1a1Sw5Ts5b27pNcUhQYwrwqBFQ
         d5CQ==
X-Gm-Message-State: AOPr4FW5qNgdgF8kh+/KEhFCvrTdKpNVfKXGoEbRt3lY3dp6qb2sy1VEJy7WAW6Kr3zKaw==
X-Received: by 10.28.20.144 with SMTP id 138mr2499748wmu.103.1462952522033;
        Wed, 11 May 2016 00:42:02 -0700 (PDT)
Received: from [10.32.249.146] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id c194sm34439735wme.9.2016.05.11.00.42.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 00:42:00 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1605100751050.4092@virtualbox>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294234>


> On 10 May 2016, at 07:52, Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
> 
> Hi Junio,
> 
> On Fri, 6 May 2016, Junio C Hamano wrote:
> 
>> * jk/submodule-c-credential (2016-05-06) 6 commits
>> - submodule: stop sanitizing config options
>> - submodule: use prepare_submodule_repo_env consistently
>> - submodule--helper: move config-sanitizing to submodule.c
>> - submodule: export sanitized GIT_CONFIG_PARAMETERS
>> - t5550: break submodule config test into multiple sub-tests
>> - t5550: fix typo in $HTTPD_URL
>> 
>> An earlier addition of "sanitize_submodule_env" with 14111fc4 (git:
>> submodule honor -c credential.* from command line, 2016-02-29)
>> turned out to be a convoluted no-op; implement what it wanted to do
>> correctly.
>> 
>> Everybody happy?
> 
> I cannot speak for everybody. I am happy, though. In particular with this
> topic branch ;-)

I want to second both statements :)
This topic branch solves a Git LFS submodule cloning issue nicely [1].

Thanks,
Lars

[1] https://github.com/github/git-lfs/issues/1172#issuecomment-218384460
