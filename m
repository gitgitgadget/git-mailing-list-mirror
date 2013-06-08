From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Sat, 8 Jun 2013 18:28:56 +0700
Message-ID: <CACsJy8DTKr5Fy3-+8ShUrWQrKC2_7EmLHwyVgQ9Aq5JDOFBAqA@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <7va9n52zjc.fsf@alter.siamese.dyndns.org>
 <rmivc5rp9w2.fsf@fnord.ir.bbn.com> <alpine.DEB.1.00.1306061818191.28957@s15462909.onlinehome-server.info>
 <CACsJy8BMrxLZFGQfUN1YCG+qkAj-91aYkc54R5O4iqgXUNeQOw@mail.gmail.com> <CAMP44s08V1=nVbeo6r8UVT3Fd0=iSpRohinqf77Tmu4=xpDHeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Greg Troxel <gdt@ir.bbn.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 13:29:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlHKu-0005Jl-4b
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 13:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350Ab3FHL32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 07:29:28 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:35827 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097Ab3FHL31 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 07:29:27 -0400
Received: by mail-oa0-f50.google.com with SMTP id l20so4217946oag.37
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 04:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=iMC48bqyPPupp+1OsmTklDy+KPdhn2BVG6ZKh1Yv+ZM=;
        b=rreE1tvDA2zpNOMOR5LVx/I6zeak+ssyLikdIT/a3DJAQdzpWdsT3xJmy6+sa5oWD1
         lc4CQ9f1bB0rrPHZbboSXtXx8/lMPj4GHFeKCr5OzBFpJ3P5HEoj73f76u8IORS+u99l
         bMs71cMkOeDq+pXdRRemdNo/tFt9wM0sqjkVnp0hG2Vnw3vvmaXMMXhA/uDrx44kMlpk
         XOqph/l3q7b1Hxg1APy82KBRUYgK86/efzhSxhoy+qGQtHGKdcHb3Xt20Ru6TbXs9bqw
         ohuzd5EqrtcD8HrhMLwHOtKb4IhapmWrK1fWIZ3FacGdtx4FuGvHyb3IPAq9K97y9Evj
         jv3g==
X-Received: by 10.182.96.37 with SMTP id dp5mr1907762obb.93.1370690966675;
 Sat, 08 Jun 2013 04:29:26 -0700 (PDT)
Received: by 10.76.76.69 with HTTP; Sat, 8 Jun 2013 04:28:56 -0700 (PDT)
In-Reply-To: <CAMP44s08V1=nVbeo6r8UVT3Fd0=iSpRohinqf77Tmu4=xpDHeg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226801>

On Sat, Jun 8, 2013 at 5:02 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Fri, Jun 7, 2013 at 9:17 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Thu, Jun 6, 2013 at 11:22 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>> Hi Greg,
>>>
>>> On Thu, 6 Jun 2013, Greg Troxel wrote:
>>>
>>>> As one of the people who helps maintain git packages in pkgsrc, my
>>>> initial reaction is negative to adding a ruby dependency.
>>>
>>> My initial reaction, too. It was hard enough to get Perl included with Git
>>> for Windows (because of that pesky Subversion dependency).
>>>
>>> As you can see from the commit history, I was the primary force behind
>>> trying to get everything "core" in Git away from requiring scripting
>>> languages (I think it is an awesome thing to provide APIs for as many
>>> languages as possible, but a not-so-cool thing to use more than one
>>> language in the core code). It does not seem that anybody picked up that
>>> task when I left, though.
>>
>> Nobody seems to mention it yet. There's another reason behind the C
>> rewrite effort: fork is costly on Windows. The C rewrite allows us to
>> run with one process (most of the time). This applies for shell, perl
>> and even ruby scripts because libgit.a is never meant to be used
>> outside git.c context (unlike libgit2). In this regard, ruby is just
>> as bad as currently supported non-C languages.
>
> Are you sure?

I'm not saying you can't. I'm saying it's not meant to be used that
way. Which means there may be problems lurking around. You can write a
ruby extension to access libgit.a, sure, but how many people on this
list understand git design and limits _and_ ruby's good enough to spot
the bugs? If a bug is found and requires major restructuring in
libgit.a, how are you sure it's worth the effort and does not
destablize the rest of git? A better way to do it is linking against
libgit2.

>
> ---
> #!/bin/sh
>
> cat > /tmp/test <<EOF
> require './git'
>
> (1..100).each do |e|
>   puts \`git rev-parse HEAD~#{e}\`
> end
> EOF
>
> strace -o /tmp/log -e fork,clone ruby /tmp/test
> cat /tmp/log
> ---
>
> ---
> clone(child_stack=0x7f84131dbff0,
> flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
> parent_tidptr=0x7f84131dc9d0, tls=0x7f84131dc700,
> child_tidptr=0x7f84131dc9d0) = 17455
> +++ exited with 0 +++
> ---
>
> I wrote a simple Ruby extension to access Git builtins so `git
> rev-parse` actually calls cmd_rev_parse directly. I don't know of any
> other language that supports so much extensibility. Of course, as soon
> as one command does exit(), the script ends too. It could be useful to
> do experiments though.
--
Duy
