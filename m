From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC] Zit: the git-based single file content tracker
Date: Fri, 24 Oct 2008 08:55:55 +0200
Message-ID: <cb7bb73a0810232355u6de0479cyc260c80227f44e59@mail.gmail.com>
References: <gdok16$vh2$1@ger.gmane.org> <4901077A.7050904@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jean-Luc Herren" <jlh@gmx.ch>
X-From: git-owner@vger.kernel.org Fri Oct 24 08:57:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtGbf-0003wJ-Tv
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 08:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbYJXGz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 02:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbYJXGz5
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 02:55:57 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:46877 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbYJXGz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 02:55:56 -0400
Received: by yw-out-2324.google.com with SMTP id 9so247706ywe.1
        for <git@vger.kernel.org>; Thu, 23 Oct 2008 23:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=9vFMM9C9n/0beWATBAKOr89YXJbo0zxXECrPOHMBt0I=;
        b=wkQLmAI++3DeK8g6hoPrTodvIsU4rr/50SL40uog4Dy9g58JpE0CXDH/jzapOlEd5o
         t1SbxCWg7MvNiHbNctWNL/mErVAlANugDqjlzasAO/DOV5EvGmo8Pj0EyLhUK8UTcOhy
         e3W46j2qZ2h59YB/uTbSY7TDjEpjEKTIC+uoM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=oH8cTnCVF05ypAun5zuhGceyUvTbNVmK0yVGWGFZLiIoaUu3sJ6i2+CJFt65z+fMjU
         yU5JQHKPakA3ubUyjGTLLVReNDRKVm7VWhy6SBBIDYLzeTqQrb8AQMYSsiFyMJg5/h/x
         vFU2PQJI3I1dnoaeL2ami2T1a121TGUM5BlUI=
Received: by 10.150.181.11 with SMTP id d11mr5298712ybf.105.1224831355599;
        Thu, 23 Oct 2008 23:55:55 -0700 (PDT)
Received: by 10.150.145.2 with HTTP; Thu, 23 Oct 2008 23:55:55 -0700 (PDT)
In-Reply-To: <4901077A.7050904@gmx.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99012>

On Fri, Oct 24, 2008 at 1:23 AM, Jean-Luc Herren <jlh@gmx.ch> wrote:
> Hi!
>
> Giuseppe Bilotta wrote:
>> So today I decided to start hacking at a git-based but file-oriented
>> content tracker, which I decided to name Zit.
>
> This sounds great and would seem very useful to manage my ~/bin/
> directory which contains a set of unrelated one-file-tools that
> evolve over time.  I haven't played with it yet though.

Nice to see I wasn't the only one with such a need 8-)

>> when you choose to start tracking a file with Zit [...]
>> Zit will create a directory .zit.file to hold a git repository
>
> If you have many files you want to track in a single directory
> (like ~/bin/), all those additional directories will quickly feel
> like clutter.  If you track every file, it will even double the
> number of things you see with an "ls -a".

Ah, good point, I hadn't thought about that.

> If you decide against a shared repository, maybe you want to
> consider to not use ".zit.file/", but ".zit/file/" as the
> repository?  This would reduce the clutter to a single directory,
> just like with ".git".  And moving files around wouldn't be that
> much complicated.

Right. I'll give that a shot.

-- 
Giuseppe "Oblomov" Bilotta
