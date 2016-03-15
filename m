From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 1/1] t9115: Skip pathnameencoding=cp932 under HFS
Date: Tue, 15 Mar 2016 06:23:32 +0100
Message-ID: <56E79C54.8000606@web.de>
References: <20160208225806.GA3487@dcvr.yhbt.net>
 <1456597724-26497-1-git-send-email-tboegi@web.de>
 <20160228045945.GA14289@dcvr.yhbt.net> <56D333F1.9050905@web.de>
 <20160315015954.GB25295@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, k_satoda@f2.dion.ne.jp
To: Eric Wong <normalperson@yhbt.net>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 15 06:24:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afhSd-00050G-Ih
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 06:24:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbcCOFX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 01:23:59 -0400
Received: from mout.web.de ([212.227.17.12]:55196 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753154AbcCOFX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 01:23:57 -0400
Received: from [192.168.88.158] ([194.47.243.242]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0Marpe-1aPoSi3VzW-00KQEN; Tue, 15 Mar 2016 06:23:43
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
In-Reply-To: <20160315015954.GB25295@dcvr.yhbt.net>
X-Provags-ID: V03:K0:+Q1s0OmU+miW455bYSmhE6WCmXugxjxDUg4/voH3vHhqR/uW81Y
 aWlMLAqQ/gQOspVHMsMeTDhz5hGgyfSFh/wl5EaD0PWrxFDDAWgx2YKO6/nLr/xtPC1Xiod
 duGD1c/5KP/ksqKL50iH/rFFkrEN+Y40V6PXXGxOBXWiqysRMQmHzEIF295mN0VYDboeFGb
 jozkII6GNxXF7QmxN6GQA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:j+nZ4mRIKQc=:CEw3ZmtrlKCZGOmWd1Lawp
 BS8fEvo0tXX+k2UESL5RKpu12ckZT5nx1fhsKIMKaUGZifhM1o2ERfhFU8cr+pVP5yE2xONo6
 1m4QNdgKQkB/7Mpd8dGVPoomzjLk+rEzC+mD2YrSAfAeOHWcWN4nKAQnD0L44uW2U0nyd2L4X
 os9Prb+1WbExzcsIOLh3EExvF3R1sDcj0gsqdXgHlyKK3CwSw+CSqzIb/FYeYyAaG3sHOvLRa
 iTMBejp4NyxKdrkoZaP/qt5XYaE4f+CzwDSPXDJxtHN92BrOBgkFJChCVNfFmINbzXNVEsxLA
 qgEUBWHZNkv5p3cP5/gBf1S9vLMkGZjqFHh42bTpZmt8J9vH/th+CUDRXerfrjEeyHra+pyjo
 Z1l5ZpAAVFtXhtWsa7izz8bSUR6v59WiB+8vYChudBgYTwrKEL+r2IyVOTM2H9BtfgAWcrHwE
 n2mfZ8yvb7Yt+YyPfC7jn3I/a5ROVTbV8fPIYshOUHp9IswaVmFkidTTt4T03iidMhKqmluuC
 VzFxB9r/6tkxJ8xepEBjzLb+8rRT9UZhh+isNub/TPE4FaVPupH96JbnKRgImHRn6DyPd74UC
 mhoFGDad7UdzgYPyES+9zpINdfYMeZ5tUOJkZiV+gqjJRwT8U0we9LjHv/uzo9qxTiGz36wsl
 cZmfL3hgixbMNcVjW5A+J61XQQyt+ugLdgfXuMN5I8x8PD/P65/UUKWPB59/PPDSHNxeNasOs
 sJLH4havB9ImmGjD3qwtfUHPJ1dm6XvgJZQaRa64X2+faShi9ScF3CFfDwbTM4cL8Uo52O0d 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288832>

On 03/15/2016 02:59 AM, Eric Wong wrote:
> []
> I just edited locally and pushed those out to Junio:
>
> http://mid.gmane.org/20160315015726.GA25295@dcvr.yhbt.net
>

The new TC 11/12 don't pass under cygwin.

Do we need cp932 ?

If not, we may use the paych from here:
https://github.com/tboegi/git/commit/379c01bf52464f8a50065b11af516127e9144045

Date:   Tue Mar 15 05:03:18 2016 +0100

     t9115: Use funcky file names that work under unicode FS

     Don't use funky file names, that can not be created under
     HFS or NTFS.

diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh 
b/t/t9115-git-svn-dcommit-funky-renames.sh
index 0990f8d..d022f0d 100755
--- a/t/t9115-git-svn-dcommit-funky-renames.sh
+++ b/t/t9115-git-svn-dcommit-funky-renames.sh
@@ -93,11 +93,11 @@ test_expect_success 'git svn rebase works inside a 
fresh-cloned repository' '
  # > to special UNICODE characters in the range 0xf000 to 0xf0ff (the
  # > "Private use area") when creating or accessing files.
  prepare_a_utf8_locale
-test_expect_success UTF8 'svn.pathnameencoding=cp932 new file on dcommit' '
+test_expect_success UTF8 'svn.pathnameencoding=ISO8859-1 new file on dcommit' '
         LC_ALL=$a_utf8_locale &&
         export LC_ALL &&
-       neq=$(printf "\201\202") &&
-       git config svn.pathnameencoding cp932 &&
+       neq=$(printf "\303\244") &&
+       git config svn.pathnameencoding ISO8859-1 &&
         echo neq >"$neq" &&
         git add "$neq" &&
         git commit -m "neq" &&
@@ -105,11 +105,11 @@ test_expect_success UTF8 'svn.pathnameencoding=cp932 new 
file on dcommit' '
  '

  # See the comment on the above test for setting of LC_ALL.
-test_expect_success 'svn.pathnameencoding=cp932 rename on dcommit' '
+test_expect_success 'svn.pathnameencoding=ISO8859-1 rename on dcommit' '
         LC_ALL=$a_utf8_locale &&
         export LC_ALL &&
-       inf=$(printf "\201\207") &&
-       git config svn.pathnameencoding cp932 &&
+       inf=$(printf "\303\226") &&
+       git config svn.pathnameencoding ISO8859-1 &&
         echo inf >"$inf" &&
         git add "$inf" &&
         git commit -m "inf" &&
