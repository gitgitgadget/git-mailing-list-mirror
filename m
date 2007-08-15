From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: 1.5.3-rc5 regression on OS X?
Date: Wed, 15 Aug 2007 17:43:09 -0400
Message-ID: <6081AC6E-4F76-4865-82FB-5F620ECB446F@silverinsanity.com>
References: <600399.61066.qm@web52807.mail.re2.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Perrin Meyer <perrinmeyer@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 23:43:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILQe3-000240-H1
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 23:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754863AbXHOVnL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 17:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755443AbXHOVnK
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 17:43:10 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:57698 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754863AbXHOVnI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 17:43:08 -0400
Received: from [192.168.1.2] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 064191FFC230;
	Wed, 15 Aug 2007 21:43:07 +0000 (UTC)
In-Reply-To: <600399.61066.qm@web52807.mail.re2.yahoo.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55954>


On Aug 15, 2007, at 5:19 PM, Perrin Meyer wrote:

> My OS X box is a quad G5 running OS X 10.4.10, with gcc version:
>
> perrin-meyers-power-mac-g5:~/GIT/git perrin$ gcc -v
> Using built-in specs.
> Target: powerpc-apple-darwin8
> Configured with: /private/var/tmp/gcc/gcc-5026.obj~19/src/configure  
> --disable-checking --prefix=/usr --mandir=/share/man --enable- 
> languages=c,objc,c++,obj-c++ --program-transform-name=/^[cg][^+.-]* 
> $/s/$/-4.0/ --with-gxx-include-dir=/include/gcc/darwin/4.0/c++ -- 
> build=powerpc-apple-darwin8 --host=powerpc-apple-darwin8 -- 
> target=powerpc-apple-darwin8
> Thread model: posix
> gcc version 4.0.0 (Apple Computer, Inc. build 5026)
>
> I define "NO_EXPAT" when I build on OS X.
>
> Am I doing something wrong?

I believe you have an old version of the Developer Tools.  I have no  
issues with that test on my MacBook Pro (2.16 GHz Intel Core Duo).

$ gcc -v
Using built-in specs.
Target: i686-apple-darwin8
Configured with: /private/var/tmp/gcc/gcc-5367.obj~1/src/configure -- 
disable-checking -enable-werror --prefix=/usr --mandir=/share/man -- 
enable-languages=c,objc,c++,obj-c++ --program-transform-name=/^[cg] 
[^.-]*$/s/$/-4.0/ --with-gxx-include-dir=/include/c++/4.0.0 --with- 
slibdir=/usr/lib --build=powerpc-apple-darwin8 --with-arch=nocona -- 
with-tune=generic --program-prefix= --host=i686-apple-darwin8 -- 
target=i686-apple-darwin8
Thread model: posix
gcc version 4.0.1 (Apple Computer, Inc. build 5367)

I don't use NO_EXPAT, but that shouldn't affect read-tree at all.

~~ Brian
