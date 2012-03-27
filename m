From: elton sky <eltonsky9404@gmail.com>
Subject: Re: GSoC - Designing a faster index format
Date: Tue, 27 Mar 2012 13:49:26 +1100
Message-ID: <CAKTdtZngYaTCwd5cri=XjUu3-o44ECjDotrDBNxqYL-Kcsosnw@mail.gmail.com>
References: <CAKTdtZm3qfG1rcoashDoMoqtD34JJDUDtDruGqGn9bSMzQTcFA@mail.gmail.com>
	<87aa3aw5z8.fsf@thomas.inf.ethz.ch>
	<CAKTdtZkGP3KbMGf88yW7zcCjemUyEy_4CVNkLD0SV=Lm7=Kveg@mail.gmail.com>
	<CAKTdtZmYc=xz4zCPQiuSTUvdmbLRKXNWNL3N6_4Bj0gujYmRvw@mail.gmail.com>
	<CACsJy8AYs5bzRnhRj_R33qTt-2gPh-rJaO0=1iTva9n14wHB4w@mail.gmail.com>
	<CAKTdtZk4FJD9qXEybpN01+S=5fOm=4AbOp8trFr5c6Uxbfykkg@mail.gmail.com>
	<CACsJy8CU_q+3ROO9z5nHe8NZDjTD4mvnEUP7C0+T3u3bRD11rQ@mail.gmail.com>
	<CAKTdtZmLOzAgG0uCDcVr+O41XPX-XnoVZjsZWPN-BLjq2oG-7A@mail.gmail.com>
	<CACsJy8C=4WaN4MZrZMaD3FqZrF2jCP5sm0F0SpDvzQnYfka9Ew@mail.gmail.com>
	<CAKTdtZkpjVaBSkcieojKj+V7WztT3UDzjGfXyghY=S8mq+X9zw@mail.gmail.com>
	<CACsJy8D85thmK_5jLC7MxJtsitLr=zphKiw2miwPu7Exf7ty=Q@mail.gmail.com>
	<CAKTdtZkx+7iU5T4oBNDEx-A5cgZCLU9ocdXmC9jRbD39J1zb3Q@mail.gmail.com>
	<87iphrjv23.fsf@thomas.inf.ethz.ch>
	<CACsJy8CsdZpQUQ7ydM1fOpSomm6+LyACCR83ccncVtUk+HbLKA@mail.gmail.com>
	<CAJo=hJsPgUZi2qMc5aDUn0+o5=9n7pBS+yWBASfqtov8WuFBRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 27 04:49:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCMTU-0005Kb-R8
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 04:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756785Ab2C0Ct2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 22:49:28 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:60900 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755232Ab2C0Ct1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 22:49:27 -0400
Received: by vcqp1 with SMTP id p1so4855134vcq.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 19:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=TJrRLUWEcY+u+fNHTbxbyL+zQ738Y45T7ZNuY3rg7nk=;
        b=d80yIqTLux3o96W12AIWvOm0zcPqyu+uh0YkGTQNVZ4pe+vwoHAYs76XTCJodFUcce
         kzmBzCkmKU9GYRNAf/fyvxRXhND/w1sXrZ5W29lJJOu+tqbvmIeLpgSMeCadsM1vCEsx
         l5GBgTD5rYcFRIZRROymh/catpzq3X/fBNaAURTF0j+WdDy2VLz6C1e9tLwzwDGDNomd
         b41qSQ1jQCFRcmyBViEl4gVg588zUalRCroQZlUQR6onb2ma+f2p6dk0PdKVEgpP7ebQ
         lrSybHaxENISUnI0OPl6iDPfHCRCV7RqEPs5l4uRniZMPyt4su0QmKdT3nvJ2nL9MKAp
         hffQ==
Received: by 10.220.229.66 with SMTP id jh2mr11249908vcb.40.1332816566914;
 Mon, 26 Mar 2012 19:49:26 -0700 (PDT)
Received: by 10.52.182.233 with HTTP; Mon, 26 Mar 2012 19:49:26 -0700 (PDT)
In-Reply-To: <CAJo=hJsPgUZi2qMc5aDUn0+o5=9n7pBS+yWBASfqtov8WuFBRA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193996>

Thanks Shawn,

> Or use LevelDb[2]. Its BSD license. Uses an immutable file format, but
> writes updates to new smaller files and eventually collapses
> everything back together into a bigger file. This can be a
> dramatically simpler approach than dealing with your own free block
> system inside of a single file. Its only real downside is needing to
> periodically pay a penalty to rewrite the whole index. But this
> rewrite is going to be faster than the time it takes to rewrite the
> pack files for the same repository, which git gc or git repack
> handles. So I don't think its actually a problem for the index.
>
> You might even be able to take a two level approach to compacting the
> LevelDb database (or something like it). In a minor compaction you
> compact all of the files except the huge base file, leaving you with 2
> files. A huge base file that contains the first tree the user checked
> out, and a second smaller file containing any differences they have
> since the initial checkout (this may just be updated stat data for a
> handful of files that differed across two branches as they switched
> back and forth). During a git gc or git repack, add a new stage to
> collapse the base file and everything else into a single new base file
> as a major compaction.
>
> [2] http://code.google.com/p/leveldb/

I don't know leveldb, but like to have a look.
Just realize this solution is kinda popular. HDFS also uses the
similar image file with edit file format for its file block index.
