From: "Kelvie Wong" <kelvie@ieee.org>
Subject: Re: Mergetool generating blank files (1.5.3)
Date: Thu, 27 Sep 2007 13:12:03 -0700
Message-ID: <94ccbe710709271312k7eac8e35y353180596a0abc9a@mail.gmail.com>
References: <94ccbe710709271131o620bf1far8893328ce98f0ba4@mail.gmail.com>
	 <20070927185707.GC12427@artemis.corp>
	 <94ccbe710709271224rc65b6f4k8b68419629ed5b45@mail.gmail.com>
	 <7vhclfubh5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 22:12:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iazia-0000U1-GG
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 22:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753534AbXI0UMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 16:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753388AbXI0UMH
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 16:12:07 -0400
Received: from el-out-1112.google.com ([209.85.162.176]:29551 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753532AbXI0UMF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 16:12:05 -0400
Received: by el-out-1112.google.com with SMTP id v27so540005ele
        for <git@vger.kernel.org>; Thu, 27 Sep 2007 13:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=KpOIuQXjDLC8vWvZtjm3/qISJcPefKZmXRHe39B0vlA=;
        b=hdILfFoVjvxZNRxkCuoPUwWWnhgxPWXmBvQEyXvn3gRxnNKJR1w1PCK82VX+sXEIJ+jP5h47zo/f9JdF+zfPdwDCJWCbazKHUoirdUNNH4sTcyqTxquIh4viwTzK7W0c/HofmwcpAMxx7qcnrpUXPCGt/agZ+uAROPFydlpJ3K8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=E8kIk/KQk37ecQBI6hVULrLCYGku4/qEUiQecEfMVB/cxoQsWC5q2vCBst7SvRPI4i/oEX85tBXPuqwKHFJsBcgXYBBq8rkTzxIaMUTYamehizBWIfHP9Dh5471dqhRM3iCumyKO7UILq6RVMNp44ayicNGwzbiISctrGtvRsQE=
Received: by 10.114.209.1 with SMTP id h1mr99771wag.1190923923863;
        Thu, 27 Sep 2007 13:12:03 -0700 (PDT)
Received: by 10.114.144.17 with HTTP; Thu, 27 Sep 2007 13:12:03 -0700 (PDT)
In-Reply-To: <7vhclfubh5.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: 1a40aa13a9687461
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59327>

On 9/27/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Kelvie Wong" <kelvie@ieee.org> writes:
>
> > I've tried all of the ones that were supported, the result is the same
> > -- blank files in all three windows.
> >
> > It is because git mergetool fails to generate these files for whatever
> > reason (the filebasename.{REMOTE,LOCAL,BASE}.* files).  I don't know
> > why this happens.
>
> Can you run git-mergetool under "sh -x"?
>
> That is,
>
>         $ sh -x git-mergetool
>
> around ll.160-170 these files are created.
>

#######################################
$ sh -x /usr/local/bin/git-mergetool --tool=meld
+ USAGE=[--tool=tool] [file to merge] ...
+ SUBDIRECTORY_OK=Yes
+ . git-sh-setup
+ unset CDPATH
+ [ -z  ]
+ LONG_USAGE=Usage: /usr/local/bin/git-mergetool [--tool=tool] [file
to merge] ...
+ [ -z Yes ]
+ git rev-parse --git-dir
+ GIT_DIR=/home/kelvie/src/trunk/.git
+ test -n /home/kelvie/src/trunk/.git
+ cd /home/kelvie/src/trunk/.git
+ pwd
+ GIT_DIR=/home/kelvie/src/trunk/.git
+ : /home/kelvie/src/trunk/.git/objects
+ require_work_tree
+ git rev-parse --is-inside-work-tree
+ test true = true
+ expr z--tool=meld : z-[^=]*=\(.*\)
+ merge_tool=meld
+ shift
+ break
+ test -z meld
+ test -z meld
+ type meld
+ test 0 -eq 0
+ git ls-files -u
+ sed -e s/^[^  ]*      //
+ sort -u
+ files=fmeprompter/src/qfmeparameterfloat.cpp
fmeprompter/src/qfmeparameterfloat.h
fmeprompter/src/qfmeparameterinteger.cpp
fmeprompter/src/qfmeparameterinteger.h
+ test -z fmeprompter/src/qfmeparameterfloat.cpp
fmeprompter/src/qfmeparameterfloat.h
fmeprompter/src/qfmeparameterinteger.cpp
fmeprompter/src/qfmeparameterinteger.h
+ echo Merging the files: fmeprompter/src/qfmeparameterfloat.cpp
fmeprompter/src/qfmeparameterfloat.h
fmeprompter/src/qfmeparameterinteger.cpp
fmeprompter/src/qfmeparameterinteger.h
Merging the files: fmeprompter/src/qfmeparameterfloat.cpp
fmeprompter/src/qfmeparameterfloat.h
fmeprompter/src/qfmeparameterinteger.cpp
fmeprompter/src/qfmeparameterinteger.h
+ git ls-files -u
+ sed -e s/^[^  ]*      //
+ sort -u
+ read i
+ printf \n

+ merge_file fmeprompter/src/qfmeparameterfloat.cpp
+ path=fmeprompter/src/qfmeparameterfloat.cpp
+ git ls-files -u -- fmeprompter/src/qfmeparameterfloat.cpp
+ f=100644 bd66831cc4c3fb2907bba0fa9bef6d3e696bf0a3 1
fmeprompter/src/qfmeparameterfloat.cpp
100644 10026c1391fc34485b54727f831ebecfde8711a5 2
fmeprompter/src/qfmeparameterfloat.cpp
100644 0d2e9decf73ae5f5e4143f3181b7c8435c20416c 3
fmeprompter/src/qfmeparameterfloat.cpp
+ test -z 100644 bd66831cc4c3fb2907bba0fa9bef6d3e696bf0a3 1
fmeprompter/src/qfmeparameterfloat.cpp
100644 10026c1391fc34485b54727f831ebecfde8711a5 2
fmeprompter/src/qfmeparameterfloat.cpp
100644 0d2e9decf73ae5f5e4143f3181b7c8435c20416c 3
fmeprompter/src/qfmeparameterfloat.cpp
+ BACKUP=fmeprompter/src/qfmeparameterfloat.cpp.BACKUP.4697
+ LOCAL=fmeprompter/src/qfmeparameterfloat.cpp.LOCAL.4697
+ REMOTE=fmeprompter/src/qfmeparameterfloat.cpp.REMOTE.4697
+ BASE=fmeprompter/src/qfmeparameterfloat.cpp.BASE.4697
+ mv -- fmeprompter/src/qfmeparameterfloat.cpp
fmeprompter/src/qfmeparameterfloat.cpp.BACKUP.4697
+ cp -- fmeprompter/src/qfmeparameterfloat.cpp.BACKUP.4697
fmeprompter/src/qfmeparameterfloat.cpp
+ git ls-files -u -- fmeprompter/src/qfmeparameterfloat.cpp
+ awk {if ($3==1) print $1;}
+ base_mode=100644
+ git ls-files -u -- fmeprompter/src/qfmeparameterfloat.cpp
+ awk {if ($3==2) print $1;}
+ local_mode=100644
+ git ls-files -u -- fmeprompter/src/qfmeparameterfloat.cpp
+ awk {if ($3==3) print $1;}
+ remote_mode=100644
+ base_present
+ test -n 100644
+ git cat-file blob :1:fmeprompter/src/qfmeparameterfloat.cpp
+ local_present
+ test -n 100644
+ git cat-file blob :2:fmeprompter/src/qfmeparameterfloat.cpp
+ remote_present
+ test -n 100644
+ git cat-file blob :3:fmeprompter/src/qfmeparameterfloat.cpp
+ test -z 100644 -o -z 100644
+ is_symlink 100644
+ test 100644 = 120000
+ is_symlink 100644
+ test 100644 = 120000
+ echo Normal merge conflict for 'fmeprompter/src/qfmeparameterfloat.cpp':
Normal merge conflict for 'fmeprompter/src/qfmeparameterfloat.cpp':
+ describe_file 100644 local fmeprompter/src/qfmeparameterfloat.cpp.LOCAL.4697
+ mode=100644
+ branch=local
+ file=fmeprompter/src/qfmeparameterfloat.cpp.LOCAL.4697
+ printf   {%s}:  local
  {local}: + test -z 100644
+ is_symlink 100644
+ test 100644 = 120000
+ base_present
+ test -n 100644
+ echo modified
modified
+ describe_file 100644 remote fmeprompter/src/qfmeparameterfloat.cpp.REMOTE.4697
+ mode=100644
+ branch=remote
+ file=fmeprompter/src/qfmeparameterfloat.cpp.REMOTE.4697
+ printf   {%s}:  remote
  {remote}: + test -z 100644
+ is_symlink 100644
+ test 100644 = 120000
+ base_present
+ test -n 100644
+ echo modified
modified
+ printf Hit return to start merge resolution tool (%s):  meld
Hit return to start merge resolution tool (meld): + read ans

+ touch fmeprompter/src/qfmeparameterfloat.cpp.BACKUP.4697
+ meld -- fmeprompter/src/qfmeparameterfloat.cpp.LOCAL.4697
fmeprompter/src/qfmeparameterfloat.cpp
fmeprompter/src/qfmeparameterfloat.cpp.REMOTE.4697


And then meld starts up, with the original file in the middle, and two
blank files on the side, LOCAL and REMOTE respectively.
-- 
Kelvie
