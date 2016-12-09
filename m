Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EBF41FF7F
	for <e@80x24.org>; Fri,  9 Dec 2016 09:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932564AbcLIJrk (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 04:47:40 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34478 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932245AbcLIJrh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 04:47:37 -0500
Received: by mail-pg0-f67.google.com with SMTP id e9so1843824pgc.1
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 01:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IjOXpeO1igQlsE5ABOYrqMewBgZpUWQLxUZ2dgCo2QE=;
        b=ZzqfMCwjtpECYYFaLm6pMgXQU7SJokjypQGL3Pu2p0V04hHrTh6JOcHz6HvBJMjDbi
         fb7ESNOxbQdtGB2lDG5lZbDVMw9qpos0c5bbTgdBWlWSYbkmZmJR0Amdm7y1Ux00hdvR
         fjoIjgQPEuxfxyKbLHH0jkAdnQdXTJdfe6AjL4w3tWJ94YKYYFFBh/X3mtF/apI4BoKn
         t/fYn4ZG/XqC9UuZrmfOhrz+Ngf86PwZANwgk76oVFggIZJbZc5T1LJVTaQRyMrBgnU+
         0Tv5bLMEsg2JGzuD+kuEgUtUrazxMNPWlft/5eE4zbHQCRZatL/2dmrOfg2tzSVTtObX
         feCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IjOXpeO1igQlsE5ABOYrqMewBgZpUWQLxUZ2dgCo2QE=;
        b=m9KXhbtGB7GuRAOdou0jbjoQBQEFQtdH/gOWh0ryeDDKmxOWP/j7ZMcUQ9N3L2ucvl
         AZlm74P5X3bEwfsfIqd1syXMOVEMskLLPj6r3afBdQ+NES5L7la6tZfKcMZFr5/BkJC5
         zFDgfVWhtQRV7CiuDP7CN4YAhcATmAn8PxxwHjcv+MSzbbkjx7eZcaUAeP/J83LbHU8V
         9mF4VN4x7akaUgP+pmphPbc2Ad1GywbOzUxZzCnLsW12oSZLqM5DXxrOAB6ljdpezoyE
         oE+pxoaufJfKzIi8IVSpVcAu/0ZVzTjXTrB3zqV9G8kM9GNTgHTQbYHVXNfO2k78SpNe
         NjTg==
X-Gm-Message-State: AKaTC02qVxXNG958zLYbHEU4gGzUR21DRz4gzUouuleeoMKrRzTgcWS1PveM5O9Bu5hENQ==
X-Received: by 10.98.73.1 with SMTP id w1mr80979381pfa.123.1481276857171;
        Fri, 09 Dec 2016 01:47:37 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id v82sm56202528pfi.6.2016.12.09.01.47.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Dec 2016 01:47:35 -0800 (PST)
Date:   Fri, 9 Dec 2016 01:47:33 -0800
From:   David Aguilar <davvid@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "P. Duijst" <p.duijst@gmail.com>, git@vger.kernel.org
Subject: Re: Error after calling git difftool -d with
Message-ID: <20161209094733.f2ism4snbrsbe2nw@gmail.com>
References: <5f630c90-cf54-3a23-c9a9-af035d4514e0@gmail.com>
 <alpine.DEB.2.20.1612021704170.117539@virtualbox>
 <20161205051510.itftw4hyzkv6nnxn@gmail.com>
 <c0c8c333-adfa-ad58-f1ec-7239a3a16528@gmail.com>
 <alpine.DEB.2.20.1612051142550.117539@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1612051142550.117539@virtualbox>
User-Agent: NeoMutt/20161104 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 05, 2016 at 11:56:31AM +0100, Johannes Schindelin wrote:
> Hi Peter,
> 
> On Mon, 5 Dec 2016, P. Duijst wrote:
> 
> > On 12/5/2016 06:15, David Aguilar wrote:
> > > On Fri, Dec 02, 2016 at 05:05:06PM +0100, Johannes Schindelin wrote:
> > > >
> > > > On Fri, 2 Dec 2016, P. Duijst wrote:
> > > >
> > > > > Incase filenames are used with a quote ' or a bracket [  (and
> > > > > maybe some more characters), git "diff" and "difftool -y" works
> > > > > fine, but git *difftool **-d* gives the next error message:
> > > > >
> > > > >     peter@scm_ws_10 MINGW64 /d/Dev/test (master)
> > > > >     $ git diff
> > > > >     diff --git a/Test ''inch.txt b/Test ''inch.txt
> > > > >     index dbff793..41f3257 100644
> > > > >     --- a/Test ''inch.txt
> > > > >     +++ b/Test ''inch.txt
> > > > >     @@ -1 +1,3 @@
> > > > >     +
> > > > >     +ddd
> > > > >       Test error in simple repository
> > > > >     warning: LF will be replaced by CRLF in Test ''inch.txt.
> > > > >     The file will have its original line endings in your working
> > > > >     directory.
> > > > >
> > > > >     peter@scm_ws_10 MINGW64 /d/Dev/test (master)
> > > > >     *$ git difftool -d*
> > > > >     *fatal: Cannot open '/d/Dev/test//Test ''inch.txt': No such file or
> > > > >     directory*
> > > > >     *hash-object /d/Dev/test//Test ''inch.txt: command returned error:
> > > > >     128*
> > > > >
> > > > >     peter@scm_ws_10 MINGW64 /d/Dev/test (master)
> > > > >     $
> > > > >
> > > > >
> > > > > This issue is inside V2.10.x and V2.11.0.
> > > > > V2.9.0 is working correctly...
> > > > You say v2.11.0, but did you also try the new, experimental builtin
> > > > difftool? You can test without reinstalling:
> > > >
> > > >  git -c difftool.useBuiltin=true difftool -d ...
> > >
> > > FWIW, I verified that this problem does not manifest itself on Linux,
> > > using the current scripted difftool.
> > >
> > > Peter, what actual diff tool are you using?
> > >
> > > Since these filenames work fine with "difftool -d" on Linux, it
> > > suggests that this is either a tool-specific issue, or an issue
> > > related to unix-to-windows path translation.
> > 
> > @Johannes: "git -c difftool.useBuiltin=true difftool -d" works OK :-), beyond
> > compare is launching with the diff's displayed
> 
> Perfect.
> 
> In that case, I think it is not worth fixing the scripted tool but focus
> on getting rid of it in favor of the builtin version.
> 
> It's not like it is the only problem with having difftool implemented
> as a script...

I just sent some patches[1] that makes it so that difftool always
operates from the top-level of the repo, particularly when
calling hash-object.  They also eliminate using paths with
embedded "//" in them, both of which may have caused this issue

Though we can side-step this specific issue with the new builtin
difftool, if our use of hash-object with double-slashed absolute
paths was not the problem reported above, then another
possibility is that there's a problem in the Git.pm Perl module,
which affects more than just difftool.

I'm curious to understand the root cause of the problem.

Does Git.pm go through a shell on Windows?

Why was hash-object complaining about the correct path,
but reported that it didn't exist?
Did having "//" in the path cause the problem?

Enlightenment from the GFW internals perspective is much
appreciated.

Since this reportedly worked in older versions, I'm led to
believe that 32b8c581ec (difftool: use Git::* functions instead
of passing around state), which first introduced the use of
paths with embedded "//", was the root cause.  If this is true
then the patches should fix the scripted difftool on Windows.

[1] http://public-inbox.org/git/20161209085848.10929-1-davvid@gmail.com/T/#t

cheers,
-- 
David
