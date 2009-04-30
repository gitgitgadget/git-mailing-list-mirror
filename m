From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git svn errors out with git-cat-file "usage" message
Date: Thu, 30 Apr 2009 12:26:46 -0400
Message-ID: <32541b130904300926x472d6d14p2896d3ade7566684@mail.gmail.com>
References: <46a038f90904290811p33332bd5h1d397734907ba9c2@mail.gmail.com>
	 <32541b130904291150k75a0433fnb29ea59f654a17f7@mail.gmail.com>
	 <49F8B7D1.2090903@drmicha.warpmail.net>
	 <46a038f90904291347i2ed158aaya7505e1bd11cd392@mail.gmail.com>
	 <49F8C127.4000400@drmicha.warpmail.net>
	 <46a038f90904300018u7101943blef084dc907a04c8d@mail.gmail.com>
	 <46a038f90904300153v22aa3e9fo407ff5084b58b5fc@mail.gmail.com>
	 <32541b130904300741p325012b7g28dabbd33576ceae@mail.gmail.com>
	 <46a038f90904300803h555f02b3n76d03c93d99f7506@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Mihai Sucan <mihai.sucan@gmail.com>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 18:27:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzZ6G-0004hz-JO
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 18:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763004AbZD3Q0r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Apr 2009 12:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756649AbZD3Q0r
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 12:26:47 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:14299 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754341AbZD3Q0q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Apr 2009 12:26:46 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1095739ywb.1
        for <git@vger.kernel.org>; Thu, 30 Apr 2009 09:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8eUACf9x6tLle3J5pFZl6ZGdunr/ny13vzuaASCP2Ys=;
        b=BmwsrUe7p0B+9Yz03GGLwsp7pyi6bcfFF/8NdKszxsZbQZKFJxGxMFeUUXzPhyJZ57
         8sQ6W5JhfzP1J3Lkj+tyEAsg2AVpwQujzGpTSYiFyrM7ApQTtSCdve9USFr06/TwNbVV
         HFRXS0fKcBya161l2ioBCxRz6ZK65jHtgCmrM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UMvb2hwGFQx+1KS4pdLRLSGY07Kez8GY2HAogr2XgO8J04gyzcp3XiMGBxlRWBRDMM
         078zOQFz2PxmLqcBue4Z7jmv+KAcfrnAKAs0ASNcmm7GDvTuC9dascAX0aBQsG3SgGXK
         2DGtcScJQ93MVsPGSPEUjtq02v/S15nFsySQ8=
Received: by 10.151.74.2 with SMTP id b2mr3824321ybl.174.1241108806193; Thu, 
	30 Apr 2009 09:26:46 -0700 (PDT)
In-Reply-To: <46a038f90904300803h555f02b3n76d03c93d99f7506@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118030>

On Thu, Apr 30, 2009 at 11:03 AM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> On Thu, Apr 30, 2009 at 4:41 PM, Avery Pennarun <apenwarr@gmail.com> =
wrote:
>> Try this:
>>
>> =A0strace -fF git svn =A0clone =A0-T trunk
>> http://paintweb.googlecode.com/svn paintweb.git 2>&1 | egrep -i
>> 'git.pm|git-svn'
>>
>> If you wade through the output, it should tell you which git.pm and
>> git-svn you're *really* getting.
>
> The output looks reasonable:
>
> $ strace -fF git svn =A0clone =A0-T trunk | http://paintweb.googlecod=
e.com/svn paintweb.git 2>&1 | egrep -i 'git.pm|git-svn'
> execve("/home/martin/libexec/git-core/git-svn", ["git-svn", "clone",
> "-T", "trunk", "http://paintweb.googlecode.com/s"..., "paintweb.git"]=
,
> [/* 44 vars */]) =3D 0
> open("/home/martin/libexec/git-core/git-svn", O_RDONLY|O_LARGEFILE) =3D=
 3
> stat64("/home/martin/share/perl/5.10.0/Git.pmc", 0xbffa451c) =3D -1
> ENOENT (No such file or directory)
> stat64("/home/martin/share/perl/5.10.0/Git.pm", {st_mode=3DS_IFREG|04=
44,
> st_size=3D35479, ...}) =3D 0
> open("/home/martin/share/perl/5.10.0/Git.pm", O_RDONLY|O_LARGEFILE) =3D=
 4
> [pid 23322] write(2, "Unexpected result returned from "...,
> 96Unexpected result returned from git cat-file at
> /home/martin/libexec/git-core/git-svn line 3252
> write(2, "Failed to read object 4b90eef952"..., 116Failed to read
> object 4b90eef95225bb9e34000e050d0cac8b84ab36f6 at
> /home/martin/libexec/git-core/git-svn line 3253.

And do the contents of these files match the ones in your git source
directory?  What are their md5sums?

/home/martin/libexec/git-core/git-svn
/home/martin/share/perl/5.10.0/Git.pm

Avery
