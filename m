From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: How to compile Git with NDK?
Date: Tue, 23 Sep 2014 07:47:11 -0500
Message-ID: <CAHd499C0XJDwNa3n3bzK7hu6iRunV1d=nvbqi+2pyoB8uSzDFA@mail.gmail.com>
References: <CAHd499C3iwpcGf+Zt+jDJfqW41P=6Uu=b8VGZKJpFZCtw56beg@mail.gmail.com>
	<54209333.7090300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 14:47:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWPUz-00076B-Pe
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 14:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755515AbaIWMrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 08:47:14 -0400
Received: from mail-vc0-f176.google.com ([209.85.220.176]:63371 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754171AbaIWMrM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 08:47:12 -0400
Received: by mail-vc0-f176.google.com with SMTP id la4so3459891vcb.7
        for <git@vger.kernel.org>; Tue, 23 Sep 2014 05:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=668KGuGP+8kw6Nce8UFhTstwzzBhnCO6E8ZzqHLo3PA=;
        b=d1T3PhXSovM/g1nJ/3XFxksSkTdVeVkbRlkiEh8hPdAROW8xD2ZaumQcV1N+xYjIkg
         Jv2zXwYFejrkFDUA22uhCNLWJvHrPbJCudqH7wYSGYvXEMtmlTS9WpAniqiwLYn2kAzV
         RBMGDVrA0l5VcOwAhPSPpdFqxtsWzvVt0K6hYL8HPskIL81/8yDvlHe4D15A3c1OwOQV
         Y6ER8eq2VeokMju1HiiQmZBc7yCHp1dYpBQEFCeJFgW/BPJdTy3uiiEgMAiNKviVPiFW
         aXuALw2EZGBtj0lpJGLenQfQebHtOLg6RtULqJm57JLQtIVJzAAlnvHQ1YSUJB50jWIb
         1FZg==
X-Received: by 10.52.30.2 with SMTP id o2mr20614627vdh.12.1411476431462; Tue,
 23 Sep 2014 05:47:11 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.221.3.200 with HTTP; Tue, 23 Sep 2014 05:47:11 -0700 (PDT)
In-Reply-To: <54209333.7090300@gmail.com>
X-Google-Sender-Auth: 5RWmKyKwvL1pyej_OdwO8iV8obQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257414>

But if I type just 'make', I don't see how it will know where my ARM
toolchain is. I'll read the INSTALL file in the meantime.

On Mon, Sep 22, 2014 at 4:22 PM, Stefan Beller <stefanbeller@gmail.com> wrote:
> On 22.09.2014 21:04, Robert Dailey wrote:
>> I run the following on Ubuntu:
>>
>> fe@BLD01:~/code/git$ autoconf
>> fe@BLD01:~/code/git$ ./configure --prefix=/home/fe/git-arm
>> --build=x86_64-linux-gnu --host=arm-linux-androideabi
>> configure: Setting lib to 'lib' (the default)
>> configure: Will try -pthread then -lpthread to enable POSIX Threads.
>> configure: CHECKS for site configuration
>> checking for arm-linux-androideabi-gcc... arm-linux-androideabi-gcc
>> checking whether the C compiler works... no
>> configure: error: in `/home/fe/code/git':
>> configure: error: C compiler cannot create executables
>> See `config.log' for more details
>>
>>
>> I have my NDK's prebuilt GCC 4.8 toolchain on PATH (the bin folder).
>> Can someone help me cross compile Git using Android NDK toolchain?
>>
>> Thanks.
>
> You don't need autoconf, just type 'make' and you'll be fine.
>
> Please read the file INSTALL for installation instructions.
>
>     Stefan
