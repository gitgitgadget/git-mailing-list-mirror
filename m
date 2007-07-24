From: "Benjamin Sergeant" <bsergean@gmail.com>
Subject: Re: http git clone memory problem.
Date: Tue, 24 Jul 2007 10:33:04 -0700
Message-ID: <1621f9fa0707241033l7ac53b97i8c8ea068be0cba2f@mail.gmail.com>
References: <1621f9fa0707232044j7cec2bes7bc7cd268775ce48@mail.gmail.com>
	 <Pine.LNX.4.64.0707241025450.14781@racer.site>
	 <1621f9fa0707240958y7c5f1b66lbfa940d60c082067@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 19:33:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDOGL-0000vh-Kf
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 19:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756259AbXGXRdI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 13:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758223AbXGXRdH
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 13:33:07 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:22354 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754387AbXGXRdG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 13:33:06 -0400
Received: by wr-out-0506.google.com with SMTP id i30so1298361wra
        for <git@vger.kernel.org>; Tue, 24 Jul 2007 10:33:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GC9L5osOh7brWFwnqAyXlsExOyH8oXjH23th/iQTs9Af7jSzpyeBUjOQHIx3vdd4b8P1IcU8u+96dJo5tZnpvnwLvPrfVYYBVfz0LJ11jrGaRSsKAw79TxFFqaGZpF3RIrK3ubyMLac8SPyGjYPjFLo4UsuLCCy5Uod9BX95L9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jLVKThSvGo175qfIzC/iBrpYjQ6q3M/vNWJBIGAlTgfElJX+iwp/ofbnpI8er8LlyeSpEuyvAWNMuSCQIYkpaRRMj4rHK9VVA/FJrZ5LEEQOV/JDSLwuZ6hJLwzw477LyN88EBanhHsnhlGRsH3v3QrFi4oI4baLukJyfL0F30E=
Received: by 10.142.110.3 with SMTP id i3mr343594wfc.1185298384361;
        Tue, 24 Jul 2007 10:33:04 -0700 (PDT)
Received: by 10.143.19.17 with HTTP; Tue, 24 Jul 2007 10:33:04 -0700 (PDT)
In-Reply-To: <1621f9fa0707240958y7c5f1b66lbfa940d60c082067@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53617>

Sorry, the mail went all alone by itself :)

I still have the segfault with 1.5.2.4. If I try to gdb it, it abort
before I can do anything. Is there an environment variable that I can
set to disable signal handling or something in git ?

*** glibc detected *** git-http-fetch: corrupted double-linked list:
0x080a4628 ***

[bsergean@marge1 sandbox]$ git --version
git version 1.5.2.4
[bsergean@marge1 sandbox]$
[bsergean@marge1 sandbox]$
[bsergean@marge1 sandbox]$
[bsergean@marge1 sandbox]$
[bsergean@marge1 sandbox]$
[bsergean@marge1 sandbox]$
[bsergean@marge1 sandbox]$
[bsergean@marge1 sandbox]$
[bsergean@marge1 sandbox]$
[bsergean@marge1 sandbox]$
[bsergean@marge1 sandbox]$
[bsergean@marge1 sandbox]$ git clone http://www.kernel.org/pub/scm/git/git.git
Initialized empty Git repository in /home/bsergean/sandbox/git/.git/
got cc13f556fc72f6f0670e61599363f6e327736ffb
walk cc13f556fc72f6f0670e61599363f6e327736ffb
got d33dfef836519e288b1f561a608020c10d01f8da
got a196f6d93a21ebac9befc4b52a2b0586471b5fa4
Getting alternates list for http://www.kernel.org/pub/scm/git/git.git
walk a196f6d93a21ebac9befc4b52a2b0586471b5fa4
Getting pack list for http://www.kernel.org/pub/scm/git/git.git
Getting index for pack 6ce718d496eba4857e76cc9b8f7a1a82f5dfb416
got 896ff1d95a2a307fd764b66de4fbd882e64dd9c6
got dd98d95d9748cdcb4fd0926a049b4a68dad47a73
Getting index for pack ffecdbabefeb7d684650f6c920c53c384bc65b5e
*** glibc detected *** git-http-fetch: corrupted double-linked list:
0x080a4628 ***
======= Backtrace: =========
/lib/i686/libc.so.6[0xb7c8a516]
/lib/i686/libc.so.6[0xb7c8c728]
/lib/i686/libc.so.6(__libc_calloc+0x94)[0xb7c8dd74]
/usr/lib/libcurl.so.4[0xb7d98013]
git-http-fetch[0x804adbb]
git-http-fetch[0x804d9b4]
git-http-fetch[0x804a642]
git-http-fetch[0x804c150]
/lib/i686/libc.so.6(__libc_start_main+0xdc)[0xb7c3cd8c]
git-http-fetch[0x8049f81]
======= Memory map: ========
08048000-08070000 r-xp 00000000 03:06 841397
/home/bsergean/git/bin/git-http-fetch
08070000-08071000 rwxp 00028000 03:06 841397
/home/bsergean/git/bin/git-http-fetch
08071000-08494000 rwxp 08071000 00:00 0          [heap]
b7800000-b7821000 rwxp b7800000 00:00 0
b7821000-b7900000 ---p b7821000 00:00 0
b79e9000-b79f3000 r-xp 00000000 03:02 678969     /lib/libgcc_s-4.1.2.so.1
b79f3000-b79f4000 rwxp 0000a000 03:02 678969     /lib/libgcc_s-4.1.2.so.1
b7a09000-b7a29000 rwxp b7a09000 00:00 0
b7a29000-b7b6e000 r-xp 00000000 03:06 841551
/home/bsergean/sandbox/git/.git/objects/pack/pack-6ce718d496eba4857e76cc9b8f7a1a82f5dfb416.idx
b7b6e000-b7b7c000 r-xp 00000000 03:02 678959     /lib/libresolv-2.4.so
b7b7c000-b7b7e000 rwxp 0000e000 03:02 678959     /lib/libresolv-2.4.so
b7b7e000-b7b80000 rwxp b7b7e000 00:00 0
b7b80000-b7b84000 r-xp 00000000 03:02 678947     /lib/libnss_dns-2.4.so
b7b84000-b7b86000 rwxp 00003000 03:02 678947     /lib/libnss_dns-2.4.so
b7b86000-b7b96000 r-xp 00000000 03:02 678943     /lib/libnsl-2.4.so
b7b96000-b7b98000 rwxp 00010000 03:02 678943     /lib/libnsl-2.4.so
b7b98000-b7b9a000 rwxp b7b98000 00:00 0
b7b9a000-b7ba2000 r-xp 00000000 03:02 678953     /lib/libnss_nis-2.4.so
b7ba2000-b7ba4000 rwxp 00007000 03:02 678953     /lib/libnss_nis-2.4.so
b7ba4000-b7bac000 r-xp 00000000 03:02 678949     /lib/libnss_files-2.4.so
b7bac000-b7bae000 rwxp 00007000 03:02 678949     /lib/libnss_files-2.4.so
b7bae000-b7baf000 rwxp b7bae000 00:00 0
b7baf000-b7bee000 r-xp 00000000 03:02 36383      /usr/lib/libssl.so.0.9.8
b7bee000-b7bf2000 rwxp 0003e000 03:02 36383      /usr/lib/libssl.so.0.9.8
b7bf2000-b7c22000 r-xp 00000000 03:02 215594     /usr/lib/libidn.so.11.5.23
b7c22000-b7c23000 rwxp 0002f000 03:02 215594     /usr/lib/libidn.so.11.5.23
b7c23000-b7c25000 r-xp 00000000 03:02 678939     /lib/libdl-2.4.so
b7c25000-b7c27000 rwxp 00001000 03:02 678939     /lib/libdl-2.4.so
b7c27000-b7d50000 r-xp 00000000 03:02 678918     /lib/i686/libc-2.4.so
b7d50000-b7d51000 r-xp 00129000 03:02 678918     /lib/i686/libc-2.4.so
b7d51000-b7d53000 rwxp 0012a000 03:02 678918     /lib/i686/libc-2.4.so
b7d53000-b7d57000 rwxp b7d53000 00:00 0
b7d57000-b7d75000 r-xp 00000000 03:02 215102     /usr/lib/libexpat.so.0.5.0
b7d75000-b7d77000 rwxp 0001e000 03:02 215102     /usr/lib/libexpat.so.0.5.0
b7d77000-b7dc5000 r-xp 00000000 03:02 215628     /usr/lib/libcurl.so.4.0.0
b7dc5000-b7dc6000 rwxp 0004d000 03:02 215628     /usr/lib/libcurl.so.4.0.0
b7dc6000-b7f11000 r-xp 00000000 03:02 36382      /usr/lib/libcrypto.so.0.9.8
b7f11000-b7f26000 rwxp 0014b000 03:02 36382      /usr/lib/libcrypto.so.0.9.8
b7f26000-b7f29000 rwxp b7f26000 00:00 0
b7f29000-b7f3b000 r-xp 00000000 03:02 678968     /lib/libz.so.1.2.3
b7f3b000-b7f3c000 rwxp 00011000 03:02 678968     /lib/libz.so.1.2.3
b7f51000-b7f52000 rwxp b7f51000 00:00 0
b7f52000-b7f6a000 r-xp 00000000 03:02 678928     /lib/ld-2.4.so
b7f6a000-b7f6b000 r-xp 00017000 03:02 678928     /lib/ld-2.4.so
b7f6b000-b7f6c000 rwxp 00018000 03:02 678928     /lib/ld-2.4.so
bfafc000-bfb11000 rw-p bfafc000 00:00 0          [stack]
bfffe000-bffff000 r-xp bfffe000 00:00 0
/home/bsergean/git/bin/git-clone: line 40: 17529 Aborted
  git-http-fetch $v -a -w "$tname" "$sha1" "$1"



On 7/24/07, Benjamin Sergeant <bsergean@gmail.com> wrote:
> With
>
> On 7/24/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> >
> > On Mon, 23 Jul 2007, Benjamin Sergeant wrote:
> >
> > > - Sorry for the noise if this has already been reported.
> > > - It's on a Mandriva Spring machine with git 1.5.0.4
> >
> > That is really old.  Could you try with a newer version?  I do not
> > remember off-hand if we had fixed such a problem.
> >
> > Ciao,
> > Dscho
> >
> >
>
