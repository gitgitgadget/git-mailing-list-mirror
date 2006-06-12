From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: svn to git, N-squared?
Date: Mon, 12 Jun 2006 11:32:08 -0400
Message-ID: <9e4733910606120832xaf74e77pad7f70df864541fc@mail.gmail.com>
References: <20060612043949.20992.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Mon Jun 12 17:32:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpoOk-0005Gt-At
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 17:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038AbWFLPcL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 11:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752042AbWFLPcK
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 11:32:10 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:54686 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1752038AbWFLPcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 11:32:09 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1659355nze
        for <git@vger.kernel.org>; Mon, 12 Jun 2006 08:32:08 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fIhlClkW6xirquezL9A8ZhEZsJOHoEv+/8x6PY7BTxHIziEc3mI7Y9SZmTjvfWmwlkY/iK+ry3bFYrsQ4XO67D25r0IefUOMvG+5TNin526j6WIDVshT7LTcmLxCppUklxs8fCgPBBPQ5ij8+YTLrBrkvZ6lprnYAKOX15obrgg=
Received: by 10.37.15.52 with SMTP id s52mr8907653nzi;
        Mon, 12 Jun 2006 08:32:08 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Mon, 12 Jun 2006 08:32:08 -0700 (PDT)
To: "linux@horizon.com" <linux@horizon.com>
In-Reply-To: <20060612043949.20992.qmail@science.horizon.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21706>

On 12 Jun 2006 00:39:49 -0400, linux@horizon.com <linux@horizon.com> wrote:
> Insanity is copying the data rather than just the file name.  Git is
> good about not reading unnecessary files, and anything necessary should
> be cached, so on-disk fragmentation is not a concern.

I've run a pack and I moved the objects to new directories. Directory
is 746M with 64K files now.

I've stablized like this. 1GB RAM with 2.8Ghz P4 hyperthread. Is there
anyway to tell what it is doing in the kernel for so much time?

procs -----------memory---------- ---swap-- -----io---- --system--
-----cpu------
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us
sy id wa st
 1  0 599128  24712  38196 247008    0    0     0     0  451   382 12
39 48  0  0
 1  0 599128  24836  38196 246872    0    0     0     4  413   354 15
38 48  0  0
 1  0 599128  24960  38212 246856    0    0     0    64  453   390 15
37 48  0  0
 1  0 599128  24960  38212 246856    0    0     0     0  414   367 12
40 49  0  0
 1  0 599128  23504  38212 248216    0    0     0     0  448   365 13
39 48  0  0
 1  0 599128  24156  38212 247604    0    0     0     0  407   355 13
39 49  0  0
 1  0 599128  25240  38212 246652    0    0     0     0  446   390 13
39 48  0  0
 1  0 599128  25240  38224 246572    0    0     4    48  415   418 12
40 47  0  0
 1  0 599128  25116  38232 246496    0    0     0    12  452   432 12
40 48  0  0

Still doesn't seem to be making much forward progress.

-- 
Jon Smirl
jonsmirl@gmail.com
