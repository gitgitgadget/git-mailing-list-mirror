From: Adria Farres <14farresa@gmail.com>
Subject: Trailing whitespace on git diff output.
Date: Mon, 1 Sep 2014 19:47:09 +0200
Message-ID: <20140901174709.GA23397@vimeitor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 01 19:47:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOVgE-0004A8-6E
	for gcvg-git-2@plane.gmane.org; Mon, 01 Sep 2014 19:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754437AbaIARqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2014 13:46:09 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:48565 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754186AbaIARqI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2014 13:46:08 -0400
Received: by mail-wi0-f179.google.com with SMTP id q5so6526581wiv.12
        for <git@vger.kernel.org>; Mon, 01 Sep 2014 10:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=tYoZO8kYRkh62Ew513ZUmdod3ezyJPJ+TN1BUCyjQlY=;
        b=LylLx8o8yiagl6i83wfvj+xhZNyPBO9S0CWbXKDr4SaT8eBhcU8VZJx3aqvBnExIsZ
         J6thu1w+tVycI0NpuWMh317vm/o+saeY5Xa63h3fGEMt2Rm8rJAg9CmKdkEbhEFD1pCA
         lxb6w97BBCqEDHSkIwK4Ch3Fysrr7d7psO1bwcZlv2FvFxpV6WCegWdW17AlDRy9EOY5
         Ies1zPgp4If//85F8TPxl8eval1BZruJSlYITKly43h5J593AnxmMvqDryEdkWLqXXgV
         Y1e8EPWBqcJQW33wF2OuuOp13vtadx8fpwZc/D9Rk9vBMwIi09eFTVYxuSJsF385A/d0
         3aIw==
X-Received: by 10.194.84.69 with SMTP id w5mr34786961wjy.0.1409593566957;
        Mon, 01 Sep 2014 10:46:06 -0700 (PDT)
Received: from vimeitor (231.Red-83-60-240.dynamicIP.rima-tde.net. [83.60.240.231])
        by mx.google.com with ESMTPSA id r19sm27551867wik.0.2014.09.01.10.46.05
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Sep 2014 10:46:06 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256308>

Hello,

Today, while redirecting git diff's output to a text file, I noticed git diff
leaves a trailing whitespace between different deltas of the same file (the line
that separates two different deltas). For example, committing a file with the
following content:
---
test

test
---

then changing it to the following:
---
test
test

test
test
---

committing and diffing it, leaves a trailing whitespace on line 8 of the
diff output.

Is that expected behavior? I'm using git 2.1.0.

Sorry for taking your time,

Adria
