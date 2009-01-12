From: mark <markkicks@gmail.com>
Subject: Re: [kde] kde konsole color settings in terminal
Date: Mon, 12 Jan 2009 14:30:36 -0800
Message-ID: <82fa9e310901121430q75c497dfye51a58cce19d2d94@mail.gmail.com>
References: <82fa9e310901121335p4bd1e223x8eea1881c0add364@mail.gmail.com>
	 <200901121618.52636.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: kde@mail.kde.org, git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Mon Jan 12 23:32:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMVKt-0008Bk-1Y
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 23:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759133AbZALWak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 17:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759132AbZALWaj
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 17:30:39 -0500
Received: from rv-out-0506.google.com ([209.85.198.236]:14609 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757643AbZALWah (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 17:30:37 -0500
Received: by rv-out-0506.google.com with SMTP id k40so10419251rvb.1
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 14:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=8y5Qvrs7CLosjuyC3IHPYWmPr1x6/09LyaYObeo8q/Y=;
        b=qNIX2YJEk+FMDagF2QPyR8sNSZVT0bG33g7xl5y4yt1lKizD5Q5LJQ7Z/s44Ye0Pbo
         5pn+Z9sGRyffUBsOpfq8+zYvih2619rdWtZOwlUnydG4rPNoyA6mQ1U0iSmlifNxXECK
         z0rEVlM4aqDo19aN6PIleD8t5j+hU7bJPul1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=sIyfsh6dDg2qn3Ny/43KH7mspUQ1VXOxMkErZpd4agdDczGgqwgafk1f3ufLDyYIGP
         3t/dQccygqz7g55x1lqsYoHDi8EIQJP8ap+MyPcCtLb0L6JjzUL4AAjvKJcDDXksKfUR
         BUf0LSyL7+x22CVbmEA9GAqIrFH4FLL2vyYFE=
Received: by 10.114.181.6 with SMTP id d6mr19838985waf.8.1231799436516;
        Mon, 12 Jan 2009 14:30:36 -0800 (PST)
Received: by 10.114.59.17 with HTTP; Mon, 12 Jan 2009 14:30:36 -0800 (PST)
In-Reply-To: <200901121618.52636.bss@iguanasuicide.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105403>

On Mon, Jan 12, 2009 at 2:18 PM, Boyd Stephen Smith Jr.
<bss@iguanasuicide.net> wrote:
> On Monday 2009 January 12 15:35:08 mark wrote:
>>i am using kde konsole, and i am getting weird output for colors, for
>>example for git log i get the following output
>>
>>git log
>>ESC[33mcommit 8b918256d944221f741e5d7300873810e31466a6ESC[m
>
> Looks like konsole isn't interpreting the color codes.  However, it also looks
> like git doesn't use termcap/terminfo/etc. to determine the correct way to
> write colors for your terminal and just defaults to ANSI.
>
> Do you get odd output from:
> grep --color=always o <<< foo
> or are the "o"s properly colored red?
[mark@localhost blue]$ grep --color=always o <<< foo
foo

yes the oo s are colored yellow.


>>settings in my bash and git.
>>
>>export | grep -i term
>>declare -x TERM="xterm-256color"
>
> So you have a /usr/share/terminfo/k/konsole-256color file?  If so, it might be
> better to use TERM="konsole-256color".
i do not have that file you specify.
I have only these
ls /usr/share/terminfo/k/*
/usr/share/terminfo/k/kon  /usr/share/terminfo/k/kon2



> I never use 256 color mode, so I'm not clear on how that works.  However, what
> git is outputting look more like ANSI 16-color codes.
>
> Does this work as you expect in other terminal applications (like rxvt or
> xterm or gnome-terminal) with the same settings for TERM?
no, it is not working on gnome-terminal or xterm. i do not have rxvt.
i even tried with TERM=xterm.

still the same problem!!
i am running on kde 4.1.3, fedora 10 latest updates.

i am getting good colors on vim.

i like git colors, help me out!
thanks a lot!
