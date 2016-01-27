From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Jan 2016, #05; Tue, 26)
Date: Wed, 27 Jan 2016 11:21:29 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601271120150.2964@virtualbox>
References: <xmqqr3h3amtk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 11:21:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aONEP-0007RF-Lx
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 11:21:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754247AbcA0KVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 05:21:41 -0500
Received: from mout.gmx.net ([212.227.17.22]:59740 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754187AbcA0KVh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 05:21:37 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M4GND-1a7Wxs0BAh-00rqQk; Wed, 27 Jan 2016 11:21:31
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqr3h3amtk.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:wBc/mgohtdn/aCL1BxqitY2JMY12dPT1C3EfFihkX9oJ751Szyk
 z2gwBsbgaS3U3voxz4CEpnH9ei0L8099dvbtp04yg10JrasW+yA2Py0EQjllTT2E1+0DJM/
 KEInGiSdT/dVmE633YNQOU+Dx0Fhvp8/0Xx9XaiX9torh2jgTIwnMxJq3w0AvvA3zGckccf
 zrIEVoueBhOgqRMjgvG/A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HOUpFW/3nKk=:7VZYZMnGsRcJS0NrSlrm3K
 SCJHjwVeEzc2+e7L7bfBSL1vHRDfHsWirPIgXg7SPy4vf6Ybc9KrLrJA2o/Qe/ZNbgr2NWjIt
 c3rDT0WtnmjrixlHuva+P8F7yfnbLg7ocfFtUzIlsDaAD8dV5RhUDzMHtBLS3kkHTiCUxbpyD
 kVG/sfM4FtQBa94gJQot9Pll2zVl2lYpYVTJavYfBBZA7TLwLNnXCYFzM8teaQcdn7XlJiJMw
 ooMvCXHLounqRomqlSugnC2ML9mPWr6oJ6gf2FY7cryZ288A5fePL8uQMIKWPX/HN5evU/3cN
 isn7Lt/ZL5V1O8goZ8s4Hp8kMF7eP5oYnVIGGwfXfgFST3LqN7DgefjI4Ei1aZMefpbbPfRQR
 wuPJt0bhyHTRPoCRaGs7pC6ITXBwrv5Qb0/J34Yuk5nnESO5ETmA6AQ0y1jHtFfyremL4AzGT
 iLDpx/6JfbdFGbmkfokwgao2238y2jclYqH3TCokoiv7P3O5L0J1aSDNkXwHsqykW2Xod1NuM
 Rb0/QE+RnCp4++CYy2NO4T/XKB11IVdS+k89rj6gRUpBxkCzFDNS2+LiQT9liqsBkre74UgbZ
 rA8a9vte2KiW9uxqjHZN60s5kJEpXWYprAWsM97TwH5ePKq4x7cf51yjeBOZyvbPw85WDxuJw
 be1bRrT4ITQaWaXVDshuL8xWRd2oiN8Zbv4r8TCctFBWiWbEoZDJBHc8orZaIdgB+FHJ6ZDOp
 eFi/MvTvnaEtsCYoWhxbfmEUT/xNhZfRJSp8aUpjVWyreEuRgKiSyAwfqqvR/QwYuniI0idH 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284907>

Hi Junio,

On Tue, 26 Jan 2016, Junio C Hamano wrote:

> * js/mingw-tests (2016-01-26) 20 commits
>  - mingw: skip a test in t9130 that cannot pass on Windows
>  - mingw: do not bother to test funny file names
>  - mingw: handle the missing POSIXPERM prereq in t9124
>  - mingw: avoid illegal filename in t9118
>  - mingw: mark t9100's test cases with appropriate prereqs
>  - Avoid absolute path in t0008
>  - mingw: work around pwd issues in the tests
>  - mingw: fix t9700's assumption about directory separators
>  - mingw: skip test in t1508 that fails due to path conversion
>  - tests: turn off git-daemon tests if FIFOs are not available
>  - mingw: disable mkfifo-based tests
>  - mingw: accomodate t0060-path-utils for MSYS2
>  - mingw: fix t5601-clone.sh
>  - mingw: let lstat() fail with errno == ENOTDIR when appropriate
>  - mingw: try to delete target directory before renaming
>  - mingw: prepare the TMPDIR environment variable for shell scripts
>  - mingw: factor out Windows specific environment setup
>  - Git.pm: stop assuming that absolute paths start with a slash
>  - mingw: do not trust MSYS2's MinGW gettext.sh
>  - mingw: let's use gettext with MSYS2
>  (this branch uses js/msys2.)
> 
>  Updates test scripts to remove assumptions that are not portable
>  between Git for POSIX and Git for Windows, or to skip ones with
>  expectations that are not satisfiable on Git for Windows.
> 
>  Looks mostly done, but I had to tweak a few things, so
>  Waiting for re-test.

Will re-submit with additional tweaks.

> * js/xmerge-maker-eol (2016-01-26) 2 commits
>  - merge-file: ensure that conflict sections match eol style
>  - merge-file: let conflict markers match end-of-line style of the context
> 
>  The low-level merge machinery has been taught to use CRLF line
>  termination when inserting conflict markers to merged contents that
>  are themselves CRLF line-terminated.
> 
>  Will merge to 'next'.

There is one more tweak I introduced, and will resubmit: the test case did
not test the intended 3 out of the 4 conflict markers.

Ciao,
Dscho
