From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: GSoC intro
Date: Mon, 26 Mar 2012 16:36:46 +0530
Message-ID: <CALkWK0nW91PE2810qrZUbL0x-_YTTA_2tLFVhvXBJ2NFGvVxog@mail.gmail.com>
References: <11292500.AVmZFUUvNi@flobuntu> <CAFfmPPPabm_H9f2Zr8eWc7Wxo6UDz-km_Vg8cc-O38XhGCrj7Q@mail.gmail.com>
 <11105663.xsXc2sBkNH@flobuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Barr <davidbarr@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 13:07:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SC7lc-0001Fo-Hw
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 13:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757358Ab2CZLHJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Mar 2012 07:07:09 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:52161 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757307Ab2CZLHH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Mar 2012 07:07:07 -0400
Received: by wibhr17 with SMTP id hr17so3662827wib.1
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 04:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=EAgQVaOQIB8m88ooEeiEoa6hDWKYpG1lSmt3L9BScnY=;
        b=QcuutZZYWzag7iccpu2EQsNgEfMcKnJkROvF9vSKAe1g2npp2uOPj9sPlRpMUlGyW4
         v8YUulJ2q0sQHwvkTmOgOcD4kUuBqmFY51KfHMT0N5TSjFh9cmN1YNqPuo4jpzb/33zB
         rsJiHSc9ClAvn7eIV4Fxbz627Hzcm50q/jOh2j8+iEMTJs6LKJ+sKrWLQqghyR0gSU30
         kDw5FqPNG6jtLqVV6QSltCWfMGamw8VUzhBqJVeyMWqpag6Zk6WDLhcD5erbsOkkNoO+
         VY7Z2sX7GAaWkXOtlPFNk2CEo3DFOXZCM76kjxUerGzh1ZqswXizmuQYayL80bDsJds6
         +GDg==
Received: by 10.180.102.3 with SMTP id fk3mr17671756wib.9.1332760026755; Mon,
 26 Mar 2012 04:07:06 -0700 (PDT)
Received: by 10.216.11.199 with HTTP; Mon, 26 Mar 2012 04:06:46 -0700 (PDT)
In-Reply-To: <11105663.xsXc2sBkNH@flobuntu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193901>

Hi Florian,

=46lorian Achleitner wrote:
> On Wednesday 21 March 2012 00:19:41 David Barr wrote:
>> Much of the progress so far has been merged into master.
>> Still outstanding are some of Dmitry's patches:
>> remote-svn-alpha_v2 [1]
>> svn-fe-options_v7 [2]
>
> I tried to find svn-related parts in gits sources. I found:
> =C2=A0- the huge ./git-svn.perl, which seems to be the git-svn implem=
entation.
> =C2=A0- ./contrib/svn-fe/ and ./vcs-svn/,
> those you pointed me at.
> Did I miss something?
> Is there any seperate source documentation? The source files I looked=
 at
> contain only very few comments. And nothing about the big picture.

A lot of big-picture discussions can be found in mailing list
archives.  Let us know what you're looking for exactly.

>> Yes, that's the plan. To be fair, it is a stretch goal. Two GSoC
>> students have brought us as far as a read-only remote helper. So I
>> think there's at least two summers' worth of work remaining.
>
> What is the remote helper? How can I use/try it?

The remote helper is an external program that git invokes to handle
specific protocols.  See ./git_remote_helpers for example.

>> [1] https://github.com/divanorama/git/tree/remote-svn-alpha_v2
> Is it in here? Should my project continue on this work?
> Until now, I've never used any remote that was not git.

You might also decide to build a brand new remote helper.

>> A track record is a plus.
>
> If you like, I could provide more references, e.g. a university cours=
e project
> in C using git.
>
>> Some extra reading:
>> [...]
> Haven't yet read it.
>
> Hm, and there are still some general questions:
> What about git-svn? Whats wrong with it? (I haven't used it) I saw th=
e huge
> perl script, this looks a little extreme ;). But it provides bi-direc=
tional
> access?!

The main problem with git-svn.perl is that it's hard to maintain or
extend.  See also: David Barr's LCA talk [1].

> svn-fe reads a dump of the svn repo. How can this approach ever be
> bidirectional? Probably I've to do the extra reading first ..

It can't.  You'll have to write something to handle the Git -> SVN
conversion.  See also: one of my earlier attempts in this regard [2].

[1]: http://www.youtube.com/watch?v=3D0hVuv-wv4Dw
[2]: https://github.com/artagnon/git/tree/svn-fi

    Ram
