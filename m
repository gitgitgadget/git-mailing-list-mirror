From: "Pavel Raiskup" <xraisk00@gmail.com>
Subject: Histogram diff, libgit2 enhancement, libgit2 => git merge (GSOC)
Date: Sun, 20 Mar 2011 11:55:31 +0100
Message-ID: <op.vsm1yszq2m56ex@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 20 11:56:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1GIi-0007ra-2a
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 11:56:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842Ab1CTKz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 06:55:56 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51876 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618Ab1CTKzy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 06:55:54 -0400
Received: by bwz15 with SMTP id 15so4394348bwz.19
        for <git@vger.kernel.org>; Sun, 20 Mar 2011 03:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:content-type:date:to:subject:mime-version
         :content-transfer-encoding:from:message-id:user-agent;
        bh=Lyl+hSgtXgMtqOkDLhGC/tApeRaFXvc4411n9DG+tYs=;
        b=Rlh8UQOV4X8q1YWA20VQ76eqGU95VwSzh9f/TmDzX8xSX7qos0llZ+9XzqvkQooKOD
         WLA/YZKCZE3cIwntzRRV7DTgsIOqxhZAQkacit+lgud+kKwiETg7P4VX9guw99ywEkc/
         Vo2In+wntQBA35V1NFJGSQLeNZeZYpwL9s2VM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=content-type:date:to:subject:mime-version:content-transfer-encoding
         :from:message-id:user-agent;
        b=BP0Tg+ckXq84PT6DrOO+v7dzPJOlabFiD6PDu/SP1Ou2XPOpy1978jWWDw4mMMCIzm
         /PAbZ7wsg8WUokWJfggXJbROUEY5jnlw13Rr3XH8U1V5spzkPU6cWV4tmgLWKguOELb6
         dR/n/mNuJbL4Qjm59yvBQQsDhoyeg4tq8kMRU=
Received: by 10.204.29.21 with SMTP id o21mr2656658bkc.97.1300618551996;
        Sun, 20 Mar 2011 03:55:51 -0700 (PDT)
Received: from localhost.localdomain (skola.mikroo.uh.cz [80.251.252.132])
        by mx.google.com with ESMTPS id y9sm267901faj.2.2011.03.20.03.55.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 Mar 2011 03:55:48 -0700 (PDT)
User-Agent: Opera Mail/11.01 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169498>

Hi Git's community!

I'd like to ask you for some details about "histogram diff" and "libgit"
enhancement/git-merge tasks for this year's GSOC.

Histogram diff:
There is no mentor mentioned in [1]. Does it mean that there is no person
who can be a mentor for this task or is that assignment possible to be
mentored by everyone mentioned in other tasks? I'd like to do this task  
very
much. After doing a small observing around source code of git/jgit it looks
feasible for me.
There is a goal "Get this feature merged to the upstream git." -- but I  
have
one theoretical question -- what if the benchmarking/study of histogram  
diff
leads to conclusion that this algorithm will not be useful for upstream?
Does it mean "fail" in terms of GSOC? I have to think about it even if it
looks that there should be speedup quite obvious. I don't want to fail
a priory :).

libgit2:
I really like the concept of libraries for to be binding-able from dozens  
of
languages - this leads to expanding functionality among masses users
almost everywhere. In this part I like the idea of implementing new  
features
inside library (diff, config file parsing) but also maybe the task of  
merging
libgit2 into git upstream. Basically I don't know much about that.. and
you wrote that this task is more difficult then others, so I probably need
to study git's and libgit's architecture very precisely beforehand .. but
could you tell me some details about that? Is it impossible to do it before
GSOC deadline and is it worth making a serious big efforts to this task
(from your point of view onto project objectives)? How big are requirements
for this task in term of GSOC?

Now it is quite hectic time because of my study :) it's been a long time
since I've had time for myself but I'd like to prepare some patch for to
proof my interests and abilities.

====
And now not so important part of message (you can skip).. I plan to write
this informations later on to google-melange more precisely.

Something about me || I am:
-- I like C language but there is no problem to study more deeply other
    commonly used languages (I need only little brainstorming),
-- interested in Open Source in general, programming (especially in
    parallel), chess playing and challenges,
-- student of master's degree BUT (CZ), penultimate year of study, my last
    summer :(
-- a fan of Git because of many reasons, I'd like to become a contributor  
even
    if the GSOC opportunity wont come.
-- not so good English speaker so sometimes my messages could be a little
    harder to understand.

Experiences:
In most cases I have only school projects experiences (even if programming
projects are some kind of evergreen here in Brno). But I've had one Open
Source experience -- enhancement for Daniel Stenberg's libcurl [2] followed
with some continuing patches. The main patch implements shell-like wildcard
pattern matching functionality for FTP protocol and makes an enhancement of
API to allow implementing of this functionality among other protocols.
(I've done implementation of wildcard "*.txt, [a-z]???.txt" compiler, auto
testing script, enhancement for testing FTP server inside libcurl, man  
pages,
.. )
The most difficult part was to understand how it works inside curl library
-- but now I think I'm better in that aspect so I think I can make some  
useful
work for Git too.
====

Don't worry please, my next messages will be much briefer :)

Pavel

[1] https://git.wiki.kernel.org/index.php/SoC2011Ideas
[2]  
https://github.com/bagder/curl/commit/0825cd80a62c21725fb3615f1fdd3aa6cc5f0f34
