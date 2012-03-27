From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: GSoC - Designing a faster index format
Date: Tue, 27 Mar 2012 13:31:54 +0700
Message-ID: <CACsJy8BZVFKZvd1=jz8PoCvTKjX6LorRidJgTxsjFUGfBUai+w@mail.gmail.com>
References: <CAKTdtZm3qfG1rcoashDoMoqtD34JJDUDtDruGqGn9bSMzQTcFA@mail.gmail.com>
 <87aa3aw5z8.fsf@thomas.inf.ethz.ch> <CAKTdtZkGP3KbMGf88yW7zcCjemUyEy_4CVNkLD0SV=Lm7=Kveg@mail.gmail.com>
 <CAKTdtZmYc=xz4zCPQiuSTUvdmbLRKXNWNL3N6_4Bj0gujYmRvw@mail.gmail.com>
 <CACsJy8AYs5bzRnhRj_R33qTt-2gPh-rJaO0=1iTva9n14wHB4w@mail.gmail.com>
 <CAKTdtZk4FJD9qXEybpN01+S=5fOm=4AbOp8trFr5c6Uxbfykkg@mail.gmail.com>
 <CACsJy8CU_q+3ROO9z5nHe8NZDjTD4mvnEUP7C0+T3u3bRD11rQ@mail.gmail.com>
 <CAKTdtZmLOzAgG0uCDcVr+O41XPX-XnoVZjsZWPN-BLjq2oG-7A@mail.gmail.com>
 <CACsJy8C=4WaN4MZrZMaD3FqZrF2jCP5sm0F0SpDvzQnYfka9Ew@mail.gmail.com>
 <CAKTdtZkpjVaBSkcieojKj+V7WztT3UDzjGfXyghY=S8mq+X9zw@mail.gmail.com>
 <CACsJy8D85thmK_5jLC7MxJtsitLr=zphKiw2miwPu7Exf7ty=Q@mail.gmail.com>
 <CAKTdtZkx+7iU5T4oBNDEx-A5cgZCLU9ocdXmC9jRbD39J1zb3Q@mail.gmail.com>
 <87iphrjv23.fsf@thomas.inf.ethz.ch> <CACsJy8CsdZpQUQ7ydM1fOpSomm6+LyACCR83ccncVtUk+HbLKA@mail.gmail.com>
 <CAJo=hJsPgUZi2qMc5aDUn0+o5=9n7pBS+yWBASfqtov8WuFBRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	elton sky <eltonsky9404@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 27 08:32:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCPxI-00059U-Kw
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 08:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757228Ab2C0Gc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 02:32:27 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:33843 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756788Ab2C0Gc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 02:32:26 -0400
Received: by wejx9 with SMTP id x9so4687894wej.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 23:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qoIXNitOtQevVmGg++DjG3vcGcREh85m+syYFq9CclQ=;
        b=EI/xGgyNFl3tt1GVGBHBLgbDU3w47hlmQPmQZ6xkQ8WFOHzo0Mjg8knU6V5uzI3S1J
         smbeMd0yqKB3dx9Ez8kPBolzovlzglOWtyEJgFRkHrT3ExRVUlDZdobdNYKeXU+PkCUY
         WKqpNkyOpm5zPyafSFhCHeveuLZeTRo0IL6GcQzChlB+cZnBIYg9twP1QRmY19mGr8LA
         3h1uhSncVIa9DwDY/925teRQsNZzTpWSjO2Y4MJAdh7nGptwXZ+/yI9blBgEcgwIE2yW
         QbbFJAfR+FzoGm/dQCxN8qiVmpQdpZUIKuAanyTmplvoEwI7NJ+5DRVUR30CPBFyKZGH
         OBVA==
Received: by 10.180.102.102 with SMTP id fn6mr24735691wib.10.1332829944934;
 Mon, 26 Mar 2012 23:32:24 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Mon, 26 Mar 2012 23:31:54 -0700 (PDT)
In-Reply-To: <CAJo=hJsPgUZi2qMc5aDUn0+o5=9n7pBS+yWBASfqtov8WuFBRA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194024>

On Mon, Mar 26, 2012 at 11:08 PM, Shawn Pearce <spearce@spearce.org> wrote:
>> [1] http://www.sqlite.org/fileformat2.html
>
> Or use LevelDb[2]. Its BSD license. Uses an immutable file format, but
> writes updates to new smaller files and eventually collapses
> everything back together into a bigger file. This can be a
> dramatically simpler approach than dealing with your own free block
> system inside of a single file. Its only real downside is needing to
> periodically pay a penalty to rewrite the whole index. But this
> rewrite is going to be faster than the time it takes to rewrite the
> pack files for the same repository, which git gc or git repack
> handles. So I don't think its actually a problem for the index.

Cool. I had an experiment with it. A database is created where are
keys  `git ls-files` on linux-2.6. A few things after the experiment:

 - we need to link to libstdc++.so. I still hope to avoid any new
runtime dependencies
 - I use gettimeofday to time some operations. On linux-2.6,
read_cache() costs 27ms. leveldb_open() alone takes 90ms. Iterating
over all keys takes ~200ms.

Performance wise it does not look very good but maybe I'm just not
doing it right.

> [2] http://code.google.com/p/leveldb/
-- 
Duy
