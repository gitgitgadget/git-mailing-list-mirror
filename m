From: Perry Smith <pedzsan@gmail.com>
Subject: Re: git 1.6.1 on AIX 5.3
Date: Tue, 27 Jan 2009 19:35:00 -0600
Message-ID: <BAD975AD-323D-4278-8405-0B57E7202797@gmail.com>
References: <A8D76E61-4442-4640-BD0C-84085375E6F1@gmail.com> <20090126210027.GG27604@coredump.intra.peff.net> <e2b179460901261432r601fa006iaf04fc42487e7235@mail.gmail.com> <9E98493A-B17A-4905-8BEA-3E0B837961D6@gmail.com> <e2b179460901270210q69fe1e42xb801553e4e9005e9@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 02:37:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRzN2-0003ON-HO
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 02:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942AbZA1BgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 20:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751905AbZA1BgI
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 20:36:08 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:7601 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbZA1BgG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 20:36:06 -0500
Received: by yx-out-2324.google.com with SMTP id 8so2913332yxm.1
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 17:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=kjGdLfKtveYcO78Ae29elmlS2A4n/VZs4emkbcUlBro=;
        b=HTye5TsRdr6C3Q5vE9mKvVJUZzzl7zdgMF8byHo9EWX8LoqebTmPbKNTsGUqgru1uj
         QDfFRyjWpp813vYns5hCmdGz+GuHPc8sVJeQFeN7R5RWpScS7/dCXqj5fLeU5f+r7vko
         HUadpKSnpTr4dFMlYMkOtjZbzXf+8hE26p/NA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=E5N3/jKRjCdjNVMACR9bFwbHMc0zAAna4yGA94muz2wJnUAar9JEcczh0O/FEv7uUc
         RbBNklaa9iyqLJJxg6ZG0hsARPtWcmlMx34VSR+UEiGt4VAp8TeFfmNl0fw50FopXtBo
         Hsdoo/D2HTMBKMA5FwglFRImHE7ZvHhL61pOY=
Received: by 10.231.19.72 with SMTP id z8mr2370554iba.6.1233106564103;
        Tue, 27 Jan 2009 17:36:04 -0800 (PST)
Received: from newtoy.easesoftware.com ([64.128.19.234])
        by mx.google.com with ESMTPS id k30sm17312832qba.8.2009.01.27.17.36.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jan 2009 17:36:03 -0800 (PST)
In-Reply-To: <e2b179460901270210q69fe1e42xb801553e4e9005e9@mail.gmail.com>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107444>


On Jan 27, 2009, at 4:10 AM, Mike Ralphson wrote:

> 2009/1/26 Perry Smith <pedzsan@gmail.com>:
>> Thanks guys.  I picked up coreutils version 7.   I didn't
>> install them but just moved ginstall over to /usr/local/bin.
>>
>> A few other comments:  I had to add in the --without-tcltk flag.  I  
>> don't
>> have tcl installed but the config did not autodetect that it was  
>> not present.
>
> Yup, I usually build with NO_TCLTK=YesPlease in my config.mak, which
> you can see from the link Peff posted.
>
> When you said 'out of tree builds' I thought you meant using the AIX
> defaults in the Makefile without running ./configure, but it seems
> not, you meant is a clone of the tree buildable by itself or are only
> release snapshots buildable. Sorry.

Sorry... I thought "out of tree" was a universal term.

Just to be sure we are on the same page.  My directory structure has a  
top/src/git-1.6.1
and top/build/git.1.6.1.  The src/git-1.6.1 is the tar ball.  The  
build/git-1.6.1 starts out
empty.  I cd into it and then do: ../../src/git-1.6.1/configure  
<options>  After this completes,
you can do "make".

About 90% of the open source configure / autoconf code out there can  
do this with.
The other 10% you can not.  I like it because when things die, its  
easier to grep around
the source tree and I blow away the build directory and start back  
over and I know that
I'm starting fresh.

>
>
> ./configure is (deliberately) a second-class citizen in the world of
> git, and may still get you a slightly suboptimal build compared with
> the defaults on platforms such as AIX... e.g. it doesn't test for
> performance-related switches such as INTERNAL_QSORT. If you have run
> configure, there's some file you need to blow away to get back to a
> non-autoconf world... is it config.mak.autogen?
>
> Despite that, your problem with --without-tcltk falling back to wish,
> but not falling back if that isn't installed does look like something
> we should fix, as per Peff's mail.
>
>> I can't tell if make test is happy or not.  The output looks like  
>> its happy
>> but the exit code is 2.
>>
>> Below is my "configure" script if anyone is interested.
>>
>> #!/usr/bin/env bash
>>
>> export CONFIG_SHELL=/usr/local/bin/bash
>> export LDFLAGS='-L/usr/local/lib -L/usr/local/ssl/lib'
>> export CFLAGS='-I/usr/local/include -I/usr/local/ssl/include'
>> export CC=gcc
>> echo CONFIG_SHELL set to ${CONFIG_SHELL}
>>
>> ${CONFIG_SHELL} ../../src/git-1.6.1/configure --without-tcltk
>>
>> #
>> # Note that to install you need to do:
>> # make INSTALL=ginstall install
>> # to use GNU's install program
>
> I build with SHELL_PATH={path}/bash as well. If I don't, the test
> suite exits after t0000-basic.sh with an unexpected error despite
> passing all the tests.
>
> gmake -C t/ all
> gmake[1]: Entering directory `/usr/local/src/gitbuild/t'
> rm -f -r test-results
> gmake aggregate-results-and-cleanup
> gmake[2]: Entering directory `/usr/local/src/gitbuild/t'
> *** t0000-basic.sh ***
> * passed all remaining 40 test(s)
> FATAL: Unexpected exit with code 0
> gmake[2]: *** [t0000-basic.sh] Error 1
> gmake[2]: Leaving directory `/usr/local/src/gitbuild/t'
> gmake[1]: *** [all] Error 2
> gmake[1]: Leaving directory `/usr/local/src/gitbuild/t'
> gmake: *** [test] Error 2
>
> Is that what you're seeing? There's many more test scripts than that  
> 8-)
>
> With GIT_SKIP_TESTS='t3900 t3901 t5100.[12] t8005' (to omit some cases
> not handled by the version of iconv I have access to on all the AIX
> boxes I deploy to) the test suit runs to completion on AIX 5.3 for me.

Yea, part of my larger quest is to start a web site to provide AIX  
builds
of open source images as installp images.  I have not added iconv to the
mix yet because I fear bad interactions with GNU's and AIX's.  In  
theory, AIX's
commands should use AIX's library but it would not surprise me if  
there are
a few AIX applications that are not built properly.

>
>
> BTW Are you running AIX's make or GNU make?

yes -- GNU's make and gcc 4.3.1

I just tried setting SHELL_PATH (and exporting it) and the make test  
gets into
the second batch and then fails two tests.  I assume the  
GIT_SKIP_TESTS is
done:

make GIT_SKIP_TESTS=....test

I get further.  But now test 10 of t0001.sh fails because test_cmp can  
not be found.

Is that a GNU tool?  (I didn't see it in git or coreutils.)

(I'll go searching for it...)

Thank you,
Perry
