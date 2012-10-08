From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: build deps
Date: Mon, 08 Oct 2012 18:52:41 -0400
Message-ID: <50735939.10604@gmail.com>
References: <CACnwZYe_vhH9Ui8W9D=M_8avgEugR+UvM1E+jH7fxr+8yk2UtQ@mail.gmail.com> <5072FAD1.1000807@gmail.com> <CACnwZYeJ-FKXterxd697iu+U4HobqEaP0zx_p8CZDsPZx4hbHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Scott Chacon <schacon@gmail.com>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 00:52:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLMC2-0007rL-SI
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 00:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755148Ab2JHWwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 18:52:49 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:41677 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754204Ab2JHWwr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 18:52:47 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so870557iea.19
        for <git@vger.kernel.org>; Mon, 08 Oct 2012 15:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=REdBVZj36vFUxe7qfHJhP3XTNJZDEn7rfGTUoWPJc1w=;
        b=FjVAXJ7B7U7HgzmokSlWuKi2NFDocOJJjuGeDUNGu+KbTvxlYLAKGrxQAfTLSHgbzx
         /W3C4RlaoH+bsvwPsBtCRAn1BUpXi5c7DP2nDgKeOhOwQz2IgGljCn2eZfx/S8miIqII
         gHE/YOUo6EE9lQtY0JhJYv8U4FW8+/xmGJLUUXwDu96wIZwzUdCEmJ+z0F/IgEUMSIDv
         FC4WcX9imr3fE36SanDNQPBvVwKaEeIVh0gg+FCoS1wLXamUbXbGlE74+t6z7RBzJgb7
         N2Vo+h2dnCBdJqerGSzS6NH2vCHKuWU2uRt8KniHIJ/tkeV/HuOCj/ou94sTwp9wB1NF
         O7tA==
Received: by 10.50.213.1 with SMTP id no1mr7461199igc.64.1349736767250;
        Mon, 08 Oct 2012 15:52:47 -0700 (PDT)
Received: from [192.168.1.3] ([69.165.255.59])
        by mx.google.com with ESMTPS id n5sm8512299igw.13.2012.10.08.15.52.45
        (version=SSLv3 cipher=OTHER);
        Mon, 08 Oct 2012 15:52:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.7) Gecko/20121007 Thunderbird/10.0.7
In-Reply-To: <CACnwZYeJ-FKXterxd697iu+U4HobqEaP0zx_p8CZDsPZx4hbHQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207278>

On 10/08/12 17:36, Thiago Farina wrote:
> OK, after running ./configure I tried the make command again.
>
> CC credential-store.o
> /bin/sh: clang: not found
> make: *** [credential-store.o] Error 127
>
> $ which clang
> /home/tfarina/chromium/src/third_party/llvm-build/Release+Asserts/bin/clang
>
> $ clang --version
> clang version 3.2 (trunk 163674)
> Target: x86_64-unknown-linux-gnu
> Thread model: posix
Looks like something went wrong with "make" setting PATH. I wonder if
the "+" sign in your path is somehow messing things up.

Are you trying to compile specifically with clang? If not, maybe try
unsetting the CC env var, and run configure again?
