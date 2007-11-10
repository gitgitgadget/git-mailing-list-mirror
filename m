From: bob <kranki@mac.com>
Subject: Re: git packs
Date: Sat, 10 Nov 2007 12:40:16 -0500
Message-ID: <00593593-E943-4DA0-AA9B-FDBB866E7EFB@mac.com>
References: <F6DD8DCD-416B-4DDF-B384-7213C9ED5565@mac.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 10 18:41:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IquK4-0001rK-I6
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 18:40:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbXKJRk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 12:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbXKJRk1
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 12:40:27 -0500
Received: from smtpoutm.mac.com ([17.148.16.75]:51151 "EHLO smtpoutm.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750695AbXKJRk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 12:40:26 -0500
Received: from mac.com (asmtp008-s [10.150.69.71])
	by smtpoutm.mac.com (Xserve/smtpout012/MantshX 4.0) with ESMTP id lAAHeQ2Y017775
	for <git@vger.kernel.org>; Sat, 10 Nov 2007 09:40:26 -0800 (PST)
Received: from [192.168.2.23] (c-66-176-54-4.hsd1.fl.comcast.net [66.176.54.4])
	(authenticated bits=0)
	by mac.com (Xserve/asmtp008/MantshX 4.0) with ESMTP id lAAHeOGj020265
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Sat, 10 Nov 2007 09:40:25 -0800 (PST)
In-Reply-To: <F6DD8DCD-416B-4DDF-B384-7213C9ED5565@mac.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64360>

I compiled git under MacOSX 10.4.10 withr:

A) -m64 -arch ppc64 on a dual G5
B) -m64 -arch x86_64 on the dual quad-core

In both case, the link phase failed because there
was no 64-bit version of libz, libssl, libiconv and
libcrypto to link with.

I then installed MacOSX 10.5 (Leopard) which
was just released last month on the dual
quad-core machine with -m64 -arch x86_64.
git compiled and linked successfully.  However,
it failed in the "git add ." which was the
second command after "git init".  The message
was fairly cryptic, "Bus error".

I am guessing that the "Bus error" is an Apple
problem and it did produce a crashreport.  So,
I am going to submit it to Apple since it is easily
reproducible.

Anyway, those are the results.

I am now going to split out the jpg(s), pdf(s)
and (.mov) files from the repository  and just
manage them external to the git repository
which will fix my git problem.

I will report again when I get git running on
Leopard.
