From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: git add -i failed in 2.0.3
Date: Tue, 29 Jul 2014 08:37:37 +0200
Message-ID: <53D74131.40005@web.de>
References: <DB19F40E-912E-42F0-AB63-838BADAF77FB@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Guang Chen <cgcgbcbc@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 08:37:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC12i-0002zD-El
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 08:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015AbaG2Gho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 02:37:44 -0400
Received: from mout.web.de ([212.227.17.11]:52468 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751281AbaG2Ghn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 02:37:43 -0400
Received: from [192.168.1.87] ([77.119.129.132]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MAvCS-1XJkna0kh2-00A0hZ; Tue, 29 Jul 2014 08:37:42
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Icedove/24.6.0
In-Reply-To: <DB19F40E-912E-42F0-AB63-838BADAF77FB@gmail.com>
X-Provags-ID: V03:K0:AtDSJjjqvVALTFhN4rQhjofWNRqJQkcm6tAMocxM7UIIC3QHN0r
 k+6DcpfsVBJhuqL++6iAGui0DcQ78EI58sivYEerd6KDpcQzThV0Pc7RoRM/yADcRj1+vcx
 GNRYTeLCSNQVDdjV70BIOnsIgULjmdgR7hzKETO7HpB9kZxp3sp1t5jD34AJh3Bp1Xtc1Hy
 B0fvjIwapTWNaNtxlDDAg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254395>

On 07/27/2014 05:26 PM, Guang Chen wrote:
> I use brew upgrade git to this version on OSX. And when I use git add -i, it says:
Which version did you use before?
Was it installed with brew as well ?
>
> Can't locate Git.pm in @INC (@INC contains: @@@/git/2.0.3/lib/perl5/site_perl /Applications/Xcode.app/Contents/Developer/Library/Perl/5.16/darwin-thread-multi-2level /Library/Developer/CommandLineTools/Library/Perl/5.16/darwin-thread-multi-2level /Users/guangchen/.opam/system/lib/perl5/darwin-thread-multi-2level /Users/guangchen/.opam/system/lib/perl5 /Library/Perl/5.16/darwin-thread-multi-2level /Library/Perl/5.16 /Network/Library/Perl/5.16/darwin-thread-multi-2level /Network/Library/Perl/5.16 /Library/Perl/Updates/5.16.2 /System/Library/Perl/5.16/darwin-thread-multi-2level /System/Library/Perl/5.16 /System/Library/Perl/Extras/5.16/darwin-thread-multi-2level /System/Library/Perl/Extras/5.16 .) at /usr/local/Cellar/git/2.0.3/libexec/git-core/git-add--interactive line 7.
> BEGIN failed--compilation aborted at /usr/local/Cellar/git/2.0.3/libexec/git-core/git-add--interactive line 7.
Do you have Git.pm on your disc, somewhere under /usr/local/Cellar/git ?

Which perl do you have, (may be more than 1?)
I tend to have different perl installations under Mac OS, whch needs
tweeking in the PATH, to have the "right one" in the PATH before e.g. the
one that comes with Mac OS.
(Or write a wrapper script that sets up the PATH and then calls git)

What does "type perl" in a command window say?
