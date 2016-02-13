From: =?iso-8859-1?Q?V=EDt_Novotn=FD?= <witiko@gmail.com>
Subject: Re: `.git` symlink makes `git submodule add` fail
Date: Sat, 13 Feb 2016 05:20:09 +0100
Message-ID: <20160213042008.GA26677@witiko>
References: <20160212164853.GA6888@witiko>
 <xmqqio1tvlzu.fsf@gitster.mtv.corp.google.com>
 <xmqq60xtvlj9.fsf@gitster.mtv.corp.google.com>
 <20160212182733.GA19973@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 13 05:20:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aURha-0005h7-SZ
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 05:20:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbcBMEUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 23:20:15 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37431 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902AbcBMEUO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 23:20:14 -0500
Received: by mail-wm0-f51.google.com with SMTP id g62so43360569wme.0
        for <git@vger.kernel.org>; Fri, 12 Feb 2016 20:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=mR3J7Qyfkf94CAhboJNiSMwXl4wBhG+NJIeesgwwl/M=;
        b=ernXXxMDm5V0YS5geBXZAqpjw+KhaTqczMC6s1Ab35cWmjPMplQEIDOEiv10amz8Xp
         vCLwKzEBr2Nuw9++Vyv9T5vwyZYGcubtS5N2wbv96U4aslmZ8O8+eq0IAYjXzv8LIsba
         W1hL1Rqm047rxppC/2U8kLosCjiqKeGVQRfk5ageJqwy31ZUq4db4SAfPz8RQot0X8GO
         MXaL0pwpP/88/LA8+vqqyp8feYKH0q7Wdwa2V/S237jw31wdJ5AwxIyjcQSL6jQFxKxN
         59Kx0I216y6FMv6ORIKd+7o3iR5+PDHIkZtGqOuZSOC9fmUe73tT50QHmPOidpTEi1m2
         7NhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=mR3J7Qyfkf94CAhboJNiSMwXl4wBhG+NJIeesgwwl/M=;
        b=mJ4NlSE8LMEVD36YtrfkWiKriw+KO9VENcSQBezU+pdWznnD9MyUhH6c35KusA/2fj
         IUkloaMvYG1cq2NMkcdwVfdk0jWhrvDUfJ/x6l00aKF0m3pLZBOvnnwxRA6qq0MP8IPb
         7oXUY5O0sxaNqOUEX9b6sYUFCg8UTCyr2yTreyCiI6PVSrDIt9DbivsEg1E6D9zCdyZ6
         OxsZHtv7AkNfBFO+3g4DtjHbXP21sY2WZwv425Ilb25/xND6iOdYUoDLkkxnn5GwAx8+
         tnpJdFFQNN3bphI7QGXfJxNse+hc70UQvYNl8YdwLtdlh0oTss5C5YOqJAdv85mPRASd
         FsiA==
X-Gm-Message-State: AG10YOThhOy9Wm7opEkWxQtXgAaoW+WHPhRJYl7V0tpuEjut8ebMMtjXpAZlUCdDzQKLdQ==
X-Received: by 10.194.185.84 with SMTP id fa20mr5025833wjc.31.1455337212505;
        Fri, 12 Feb 2016 20:20:12 -0800 (PST)
Received: from witiko (dynamic-2a00-1028-8d1c-ac1a-021f-3cff-fe2d-27ad.ipv6.broadband.iol.cz. [2a00:1028:8d1c:ac1a:21f:3cff:fe2d:27ad])
        by smtp.gmail.com with ESMTPSA id jc7sm14803951wjb.33.2016.02.12.20.20.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Feb 2016 20:20:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160212182733.GA19973@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286105>

On Fri, Feb 12, 2016 at 01:27:33PM -0500, Jeff King wrote:
> On Fri, Feb 12, 2016 at 10:19:38AM -0800, Junio C Hamano wrote:
> 
> > >> Is this a bug, or is the ability to symlink `.git` just a happy coincidence?
> > >
> > > It has never been supported.
> > 
> > Oops, hit "send" too early.
> > 
> > We have support for a "gitdir:" facility that would work even on a
> > filesystem that cannot do symlinks (see gitrepository-layout(5)),
> > and both the higher-level submodule Porcelain and the more recent
> > "worktree" experimental code do use it.
> 
> And the way to convince git to make the link for you is with clone's
> "--separate-git-dir" option.
> 
> -Peff

What's curious is that this doesn't really work either, so the issue
doesn't seem to be the lack of symlink support, but rather the lack of
willingness on the part of Git to resolve a path recursively.

The following works flawlessly:

  $ mkdir repos
  $ git init
  $ mv .git repos/repoA
  $ printf 'gitdir: repos/repoA\n' >.git
  $ git submodule add https://github.com/witiko/git-parallel

There is, however, a minor pain, which makes the repository unportable:

  $ cat git-parallel/.git
  gitdir: /tmp/foobar/repos/repoA/modules/git-parallel

When I change the gitdir symlink to a relative path, everything works
fine as long as I don't make Git go over two gitdir symlinks:

  $ sed -i 's#^/tmp/foobar#..#' git-parallel/.git
  $ git status
  [works]
  $ sed -i 's#repos/repoA#.git#' git-parallel/.git
  $ git status
  fatal: Not a git repository: git-parallel/../.git/modules/git-parallel

Clearly, Git resolves the first gitdir symlink:

  git-parallel/.git => git-parallel/../.git/modules/git-parallel

but refuses to resolve recursively:

  git-parallel/../.git/modules/git-parallel =>
  git-parallel/../repos/repoA/modules/git-parallel
