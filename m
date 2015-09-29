From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Announcing Git for Windows 2.6.0
Date: Tue, 29 Sep 2015 23:03:28 +0200
Organization: gmx
Message-ID: <3dba113ea1ed82a6e5e745a3d69dceaa@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git for Windows Mailing List <git-for-windows@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 29 23:03:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zh23m-0006uw-0s
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 23:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546AbbI2VDd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Sep 2015 17:03:33 -0400
Received: from mout.gmx.net ([212.227.15.18]:61221 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752302AbbI2VDc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2015 17:03:32 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LkOeR-1aDbzP1LY3-00cMlK; Tue, 29 Sep 2015 23:03:28
 +0200
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:vWMIThhSoeSydiTjd0aFZUEpfwF+ybODaNVZi7LF0GHLBfzWb5v
 48EhEB/9iAqtYiQLyx2rxnwkKf3clVPFKDpXWgv6p3EbgRgOIxQq7iz9S06LzKIM16YbFT0
 ezhi3UcrUjyL8Ox/9gRivEzaIB9jQrook5OLc/lssvBVqhKXcfiDGxeXl9tJMDNH/yrPvQQ
 oYI8T35zWvreM8oIcoY7Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3FmwUC0DzXw=:1XmP+fJQlo86eLRV6/BsdA
 BqLrfebGorxaznLNXWBbTKAyOcjlWJ/86/XY/S9n1xzpdSQfFh2oJiGCktI3rXhxy2O9oFl3p
 cAvy5gUG4bQrIzuxEy6YZ19omRjRBv7egJRQcoRY6s0GUeEMlY8iZSpx/yEs2BhQGRrV0T7MW
 +eRyZekaDxMCNollpwmoXDEQYtMztecHUUZaoYST47loysplPBy33lWI2Di9EGvxJgLtz3dLp
 /5MG8zKpeqMmOG6XNbrxKlQKzzQXbWrArP41nPbKDxteoPyJI7L+TZOVP4cJvO/IR9ZgptU96
 nsQkFPxsk+M2rr1pm9HMjXw8mxU7BqyxADa0AQQJcVMgA8/oJ3jzRgDLztviNl5UHHD+f7Eax
 Nz29dMjz6ENGcH+gL6psusnyoWGLugZbjOMoV91sOs5Mvv5EKh9FXpIgpqAgwCI3oSt2ksVn5
 Y7LMvpDRpXKIaE161EYcFcZgW3E4clmHdw3aAhzyUX0/oF8kFaKdx0de9sxDxfdvI5Vsop7b1
 1de9bV0kHhXaZWwnUpLN41tWEnSzXPUckv3JijlSPmpq5xYmZHoIp3iVkbooIULrN7rLLMDXL
 tJ9R2Bea5cyxvAQfdSt18B1NpFSIL+ybr0biOzg39J106Yv/JbSQEY1Ds9NNuEWo9pMcDTkfD
 Rm6anpmf+ofpDFpg/Qyg3oPLOmL4Br4n1wsrdhbPz26jy38bBL5Ndv6YMp3aCjmQXvoxpLngT
 Vi0okiEoSZFAXte0ftBigc3yB7D1O595Irqa2ZbyKO1GNh0LbstQx/zIREkN9nZtdpKft2Fh 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278835>

Dear Git users,

it is my pleasure to announce that Git for Windows 2.6.0 is available (=
see https://git-for-windows.github.io/ for details and download links).

Thank you, contributors!

Changes since Git for Windows 2.5.3 (September 18th 2015)

New Features

  =E2=80=A2 Comes with Git 2.6.0
  =E2=80=A2 The WhoUses.exe tool to determine which process holds a loc=
k on a
    given file (which was shipped with Git for Windows 1.x) gets
    installed alongside Git for Windows again.
  =E2=80=A2 The values CurrentVersion, InstallPath and LibexecPath are =
added to
    the HKEY_LOCAL_MACHINE\Software\GitForWindows registry key to help
    third-party add-ons to find us.
  =E2=80=A2 When fetching or pushing with Git without a console, we now=
 fall
    back to Git GUI's askpass helper to ask for pass phrases.
  =E2=80=A2 When run through <INSTALL_PATH>\cmd\git.exe, Git will find =
tools in
    $HOME/bin now.

Bug Fixes

  =E2=80=A2 The portable version avoids DLL search path problems even w=
hen
    installed into a FAT filesystem.
  =E2=80=A2 Configuring notepad as editor without configuring a width f=
or
    commit messages no longer triggers an error message.
  =E2=80=A2 When using Windows' default console for Git Bash, the .sh f=
ile
    associations work again.
  =E2=80=A2 Portable Git's README is now clearer about the need to run
    post-install.bat when unpacking manually.
  =E2=80=A2 We use the winpty trick now to run ipython interactively, t=
oo.
  =E2=80=A2 When the environment variable HOME is not set, we now fall =
back
    correctly to use HOMEDRIVE and HOMEPATH.
  =E2=80=A2 The home directory is now set correctly when running as the=
 SYSTEM
    user.
  =E2=80=A2 The environment variable GIT_WORK_TREE may now differ in lo=
wer/
    upper case with the Git's idea of the current working directory.
  =E2=80=A2 Running git clone --dissociate ... no longer locks the pack=
 files
    during the repacking phase.
  =E2=80=A2 Upstream cURL fixes for NTLM proxy issues ("Unknown SSL err=
or")
    were backported.

Ciao,
Johannes
