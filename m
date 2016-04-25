From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1] travis-ci: build documentation
Date: Mon, 25 Apr 2016 10:35:24 +0200
Message-ID: <B674CC4C-5506-4E5C-B638-45E0FAD50842@gmail.com>
References: <1461314042-3132-1-git-send-email-larsxschneider@gmail.com> <20160423033922.GA15994@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 25 10:35:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aubzR-0003MW-1L
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 10:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753997AbcDYIf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 04:35:29 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35960 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864AbcDYIf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 04:35:28 -0400
Received: by mail-wm0-f48.google.com with SMTP id v188so88519398wme.1
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 01:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Wc4x6E/EJ/Lq0ObCD2/mp8mMfNQrjlFGod+AgRWLf2c=;
        b=ZpYOroA/W4ku3IUr8+4tAKF1DB41KKcg7NRKoG0oEDaFujO3z4OrXSuJfGgtsilzMb
         fQ8PV2Z+K0qNxeooCtiSz6zslFTlDANHKhcO9T427kaUDOiDe6A7I+5i7tRvcpsxCtbJ
         txgzNp8xnXYbJb9Se6igw5FvlsKOdWqce3+vbLBAyj4kq29F6CT0FbBZMoiob8BctVwi
         bVT+C4XdtF0miCkWt1zBvXm5QbOkPU4/NjSMf0UNZ2wFPD+e08Ed/e7yVPybQuvmw1vG
         PSSxoKnR1lZvBFBT1OyOnGTADXDsFv1ZRj5z+DCSyqWn15adsWYPWLxC5SuYtGg5y6G2
         2kIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Wc4x6E/EJ/Lq0ObCD2/mp8mMfNQrjlFGod+AgRWLf2c=;
        b=VKCLvFMdR4q8bpEhSp4q+cBHK2yrhRvHoTJeJUAyU5Df1CylJgkBhrHQVEGE4UI9Br
         A4by4RPUFkgvgbBmHPbSKk6NFmfgQDONczfnZdEtY0IiFa5oT3+qnM0pGTPEQKx6ging
         1m9/bCNc/a+llyfGYJEt5xNMrIFmEPiLGxF1zZnyL5h/Bu0NKtVUhFrZkmXtQfekzZ70
         GvzmoZiWTNQ6DaFJpwWzZMwG54dwe3Pz5nJJ7TcAi9Us5ZlrA5PEsUyD/Txmd2/mjqRv
         NaJ2H2FrVGhtnmoW3n5dR4O9aW26roAcvWeEb3QbwXTOkjUEQ3ZHPyuD5w3rbquHuTxg
         lh3w==
X-Gm-Message-State: AOPr4FXTO184QXKAiyz3yp4IOUbDoGWQlJhdNJZdqdw/MZjCamH+OcLm0DquygKAp864/A==
X-Received: by 10.28.165.216 with SMTP id o207mr10237998wme.31.1461573327332;
        Mon, 25 Apr 2016 01:35:27 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB4886.dip0.t-ipconnect.de. [93.219.72.134])
        by smtp.gmail.com with ESMTPSA id s6sm22379403wjy.31.2016.04.25.01.35.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Apr 2016 01:35:26 -0700 (PDT)
In-Reply-To: <20160423033922.GA15994@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292459>


On 23 Apr 2016, at 05:39, Jeff King <peff@peff.net> wrote:

> On Fri, Apr 22, 2016 at 10:34:02AM +0200, larsxschneider@gmail.com wrote:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> Run "make doc" to check if all documentation can be build without errors.
>> Since the documentation is the same on every platform/compiler, the check
>> is only performed as part of the Linux/GCC build job to maintain a fast
>> CI process.
> 
> This does slow down the normal test results for linux/gcc, though. I
> don't know very much about Travis, but is it possible to break out the
> documentation build into its own test, with a separate build status from
> the other runs?

Great idea. This is how it looks.

All jobs of a run:
https://travis-ci.org/larsxschneider/git/builds/125506781

The documentation job:
https://travis-ci.org/larsxschneider/git/jobs/125506786

Thanks,
Lars
