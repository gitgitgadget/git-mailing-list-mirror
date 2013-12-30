From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: aborted 'git fetch' leaves workspace unusable
Date: Mon, 30 Dec 2013 20:54:38 +0100
Message-ID: <52C1CF7E.9000603@web.de>
References: <7adcf8024c435b9b7178b86f01e447bb@stephe-leake.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: stephen_leake@stephe-leake.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 30 20:55:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vxivj-0001Pq-4o
	for gcvg-git-2@plane.gmane.org; Mon, 30 Dec 2013 20:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121Ab3L3Tyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Dec 2013 14:54:46 -0500
Received: from mout.web.de ([212.227.17.11]:64741 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932104Ab3L3Tyq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Dec 2013 14:54:46 -0500
Received: from [192.168.2.107] ([79.223.113.246]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0Lcy1k-1VXDoC12q8-00iAiN for <git@vger.kernel.org>;
 Mon, 30 Dec 2013 20:54:44 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <7adcf8024c435b9b7178b86f01e447bb@stephe-leake.org>
X-Provags-ID: V03:K0:OwATukZdKJO9C+aUOGVBY7REN1k1bvdm18l27Rx+30/3S55QaTT
 3zcxYs43bC2HcNwHh4sNh/RZ7/m00tzXO+CK/hHOBR7kN+ndkpICxMNiFz3I/zgID6B86xU
 KLHjzIUkGJlo0/rmaMh5x9Yk985sBfiJ94dsFJxbMLjh1gqHCGcWmajqL1QvkdQrHDcdLTp
 tV/cgUXT9k4nf8rzawpDw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239819>

On 2013-12-30 18.07, stephen_leake@stephe-leake.org wrote:
> I forgot to do 'ssh-add', so a 'git fetch' running under Windows Emacs
Windows native emacs or emacs under cygwin ?
> tried to prompt for the ssh passphrase, could not find an ssh passphrase
> prompt program, and aborted.
> 
> That left the workspace unusable:
> 
> - .git/FETCH_HEAD is empty
> 
>     that causes 'git rev-parse FETCH_HEAD' to fail with a confusing
>     error message.
Would you mind to post the "confusion error message" here?
Because some people may find it useful.
> 
> - 'git fetch' just hangs after outputting:
> 
> remote: Counting objects: 15, done.
> remote: Compressing objects: 100% (8/8), done.
> remote: Total 9 (delta 5), reused 0 (delta 0)
> 
>     even with -v --progress
> 
> A fresh clone allowed me to continue working, but this will happen
> again, so I'd like a better fix.
> 
> The fetch is from stephen_leake@git.savannah.gnu.org/emacs/elpa.git
> 
> I'm running git 1.7.9 from Cygwin. 
This feels old, we have v1.8.5.2 as the latest version.

I have access to Debian, where I can
> compile git and run it under the debugger, if that helps. I have not yet
> tried to reproduce this bug on Debian.
This could be helpful:
a) compile git under cygwin (try 1.8.5.2), and see if the problem is still there.
b) Which version of cygwin do you have? 
c) If the same problem exist under Debian, debugging it could be helpfull, yes.
  If the same problem exist here, in some version of git, it would be helpful to test
  the latest version of git. (Which means compile & debug)
HTH
/Torsten
