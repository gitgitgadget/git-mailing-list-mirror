From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Fri, 2 Nov 2012 19:01:55 +0100
Message-ID: <CAMP44s1mbNBUspJ8SX=VwGSXthxWAHkrQLFRxzyCzkupLYSagA@mail.gmail.com>
References: <alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info>
	<CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com>
	<alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info>
	<CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com>
	<5090EFCA.7070606@drmicha.warpmail.net>
	<CAMP44s2a7fmxFmdn0CAcVtX8NxVtPdBKH9RY+i_Og53jb1Ju5Q@mail.gmail.com>
	<509149D9.3070606@drmicha.warpmail.net>
	<CAMP44s2oKMog5GygrAag8SOdwhQJr4gCZxZAwWUo-ERDzni0ag@mail.gmail.com>
	<CAMP44s0KFJW2F3gbO_Xd9QKrZ1OoxvUCvecU084-zH2UDqXKag@mail.gmail.com>
	<CAMP44s3UHQE69O__EVK29uN_VPdZN=a0-Gczeh-Tbjp1ZAAbJw@mail.gmail.com>
	<20121102144827.GB11170@sigill.intra.peff.net>
	<CAMP44s1P5Y_H24=ZKS5n_rUORf1dTiqg3qXm3bHcOiQ8K12PUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 02 19:02:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TULZJ-0001P1-2a
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 19:02:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933564Ab2KBSB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 14:01:56 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:39899 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932452Ab2KBSBz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 14:01:55 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so3860060obb.19
        for <git@vger.kernel.org>; Fri, 02 Nov 2012 11:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dhY/Phm2eBWXC9NQ6h+S5YSV1LCwqV2yWdwd79hFwLQ=;
        b=b8F6QekkdNGBzDn6jVYcPVn3+0V+YLMqOd6K77uZln6faWH6Fm4M/0fJ1EL/wTor0b
         s1zzVLbI9Ldg4TuusXXPZwQGaZV8KZSqAw1IPMnSZYX6ca3gqEBUWCRjIg5WWPtahKvI
         wsK3I9/ExJy1J0mEYX7e5tL+ZgrTMMiGJ6PM+qAefSQ1P5tspVizr0M7+5c+hC4b8MKj
         uh2v25k2ICvhSaY6xVIOYNFd6jTqsD+1M2NHbYIqAt5At7OH1FIv6PaHokoeQu4OLdCd
         OhrpPLGr4QurUKyJfjj7mSN+fY/1NWRk8dumgODfCJymYSo2jjZ7DPfR258v/hB0ARaI
         vuiw==
Received: by 10.182.194.70 with SMTP id hu6mr2059878obc.4.1351879315159; Fri,
 02 Nov 2012 11:01:55 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Fri, 2 Nov 2012 11:01:55 -0700 (PDT)
In-Reply-To: <CAMP44s1P5Y_H24=ZKS5n_rUORf1dTiqg3qXm3bHcOiQ8K12PUQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208966>

On Fri, Nov 2, 2012 at 5:41 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Fri, Nov 2, 2012 at 3:48 PM, Jeff King <peff@peff.net> wrote:
>> On Thu, Nov 01, 2012 at 05:08:52AM +0100, Felipe Contreras wrote:
>>
>>> > Turns out msysgit's remote-hg is not exporting the whole repository,
>>> > that's why it's faster =/
>>>
>>> It seems the reason is that it would only export to the point where
>>> the branch is checked out. After updating the to the tip I noticed
>>> there was a performance difference.
>>>
>>> I investigated and found two reasons:
>>>
>>> 1) msysgit's version doesn't export files twice, I've now implemented the same
>>> 2) msysgit's version uses a very simple algorithm to find out file changes
>>>
>>> This second point causes msysgit to miss some file changes. Using the
>>> same algorithm I get the same performance, but the output is not
>>> correct.
>>
>> Do you have a test case that demonstrates this? It would be helpful for
>> reviewers, but also helpful to msysgit people if they want to fix their
>> implementation.
>
> Cloning the mercurial repo:
>
> % hg log --stat -r 131
> changeset:   131:c9d51742471c
> parent:      127:44538462d3c8
> user:        jake@edge2.net
> date:        Sat May 21 11:35:26 2005 -0700
> summary:     moving hgweb to mercurial subdir
>
>  hgweb.py           |  377
> ------------------------------------------------------------------------------------------
>  mercurial/hgweb.py |  377
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 377 insertions(+), 377 deletions(-)
>
> % git show --stat 1f9bcfe7cc3d7af7b4533895181acd316ce172d8
> commit 1f9bcfe7cc3d7af7b4533895181acd316ce172d8
> Author: jake@edge2.net <none@none>
> Date:   Sat May 21 11:35:26 2005 -0700
>
>     moving hgweb to mercurial subdir
>
>  mercurial/hgweb.py | 377
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 377 insertions(+)

I talked with some people in #mercurial, and apparently there is a
concept of a 'changelog' that is supposed to store these changes, but
since the format has changed, the content of it is unreliable. That's
not a big problem because it's used mostly for reporting purposes
(log, query), not for doing anything reliable.

To reliably see the changes, one has to compare the 'manifest' of the
revisions involved, which contain *all* the files in them.

That's what I was doing already, but I found a more efficient way to
do it. msysGit is using the changelog, which is quite fast, but not
reliable.

Unfortunately while going trough mercurial's code, I found an issue,
and it turns out that 1) is not correct.

In mercurial, a file hash contains also the parent file nodes, which
means that even if two files have the same content, they would not
have the same hash, so there's no point in keeping track of them to
avoid extracting the data unnecessarily, because in order to make sure
they are different, you need to extract the data anyway, defeating the
purpose.

Which means mercurial doesn't really behave as one would expect:

# add files with the same content

 $ echo a > a
  $ hg ci -Am adda
  adding a
  $ echo a >> a
  $ hg ci -m changea
  $ echo a > a
  $ hg st --rev 0
  $ hg ci -m reverta
  $ hg log -G --template '{rev} {desc}\n'
  @  2 reverta
  |
  o  1 changea
  |
  o  0 adda

# check the difference between the first and the last revision

  $ hg st --rev 0:2
  M a
  $ hg cat -r 0 a
  a
  $ hg cat -r 2 a
  a

I will be checking again from where did I get the performance
improvements, but most likely it's from my implementation of
mercurial's repo.status().

Cheers.

-- 
Felipe Contreras
