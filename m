From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: Starting on a microproject for GSoC
Date: Thu, 28 Jan 2016 09:51:48 +0100
Message-ID: <1FEDCA48-FE77-44C3-8C4A-65B4C435E6B3@gmail.com>
References: <56A96380.3020308@moritzneeb.de>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Moritz Neeb <lists@moritzneeb.de>
X-From: git-owner@vger.kernel.org Thu Jan 28 09:52:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOiJ3-0000cr-K8
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 09:51:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754936AbcA1Ivy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 03:51:54 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37169 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbcA1Ivw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jan 2016 03:51:52 -0500
Received: by mail-wm0-f48.google.com with SMTP id l66so590611wml.0
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 00:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mMTQyzQ+m04iSDEpKgP+l9xtb/kjfU9Xr7uJxkGc8tc=;
        b=RquSPWi93Ugwfg3As2Pcal1fOps8Qkk1s63kDcqEBhf8UF6lmBdp6VnJuRO4lgzFA4
         p8QPZHc28qLZbvWOulP8ZpGzxqkfShJtmV7B3RdM/kBnHOjbuHzlIwNubOGqkZdw7O4S
         n4SdxVPnL5EdLKU2vLVhgfk1zgHmmq7Sy38pnqi8qsPTAS/WDOX5Y5IsVkY2cu7nO9JK
         ireZvJEZJNniYCTG2R43KbWq9wzMgZ1+ApMXwKj8ClZdb5ZPaFZE1Hi5FNEtqtwUpWAr
         4056u72k/PpAJ2+R9JTfKXkb/TRur0itNFnt8rMlB+LR6TdccZJZNdoNW8+0dfVuFNZm
         4gAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=mMTQyzQ+m04iSDEpKgP+l9xtb/kjfU9Xr7uJxkGc8tc=;
        b=U+gXQFgFKubCggJOzYUH08sM+H5y+5MOLuGRuVPLIoCvFrv66LX0Q1UX/y6GOHG0fn
         AXgvvX1KvdTqf/pDf+l9nn700pGTJhsuist1YPKagsvmrTnH8jmH9liIBTpxABKwiVMG
         BL2MSiOkwxG1C78UHl0XV0Xkaiz0u5flfar4jEBfZ8JCvCwaKHyNXXe1Ta8X6TR+u5zl
         7MPHDiHVf9KQYO5S1yuENynDn+L4nvwjm1THPQjLitvRy41DAcg5hfApkzZXWfgCJjsx
         DA05RZWv47iKPs5p9YHXf3bNz+pHsSdcE0tmZmDxgFDl703W+AH8jqueskz+RDRFv+Ga
         XM4Q==
X-Gm-Message-State: AG10YORxlh3wiUEsasx6lnQqxLa032xdRedVrFgwGiFDpadpCaZMYyf0kHc9NWlDV1Ll/A==
X-Received: by 10.28.146.8 with SMTP id u8mr1686619wmd.72.1453971111088;
        Thu, 28 Jan 2016 00:51:51 -0800 (PST)
Received: from slxbook3.fritz.box (p508BA68D.dip0.t-ipconnect.de. [80.139.166.141])
        by smtp.gmail.com with ESMTPSA id 17sm1790578wmy.15.2016.01.28.00.51.49
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Jan 2016 00:51:50 -0800 (PST)
In-Reply-To: <56A96380.3020308@moritzneeb.de>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284990>


On 28 Jan 2016, at 01:40, Moritz Neeb <lists@moritzneeb.de> wrote:

> As the list of available microprojects 2016 is still to be created, I
> might need your help in finding a project to work on.

As Stefan already pointed out, working on something that scratches your (Git) itch is probably the best way to find a project.
My recent itch was that I broke a test on Linux which I did not realize as I primarily work on OSX. As a solution for myself I suggested a TravisCI patch to the mailing list and it was accepted:
https://travis-ci.org/git/git/branches 

I see a number of ways to improve the Git TravisCI integration:

* install CVS on the build machines to run t94?? and t96?? tests
* install SVN on the build machines to run t91?? tests
* install Apache Web Server to run 5539, 5550, and 5561
* investigate if it is possible to run t1509 root worktree test
* investigate if it is possible to add jgit to run t5310
* investigate why GIT_TEST_LONG=YesPlease does not work on TravisCI
* investigate if we can use pylint to analyze the git-p4 Python code
* investigate if we can trigger Coverity static code analysis for the Git master
  branch (hint: Stefan Beller already looked into this)
  https://scan.coverity.com/travis_ci

I think all of these tasks can be done without deep Git knowledge. However, working with the tests is quite a good way to learn more about a complex project like Git.

Cheers,
Lars