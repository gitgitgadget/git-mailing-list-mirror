From: Ted Wood <coolfactor@mac.com>
Subject: Git installation on Mac OS X - problem
Date: Mon, 02 Sep 2013 13:16:19 -0700
Message-ID: <4EA7B5FB-14EF-4106-B52E-3A28B85AFAF2@mac.com>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: multipart/mixed;
 boundary="Apple-Mail=_4627D046-509D-4B13-B181-81EE48732D5E"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 02 23:16:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGbUE-0004A9-25
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 23:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756261Ab3IBVQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 17:16:34 -0400
Received: from st11p01mm-asmtp003.mac.com ([17.172.204.238]:44632 "EHLO
	st11p01mm-asmtp003.mac.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755829Ab3IBVQd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Sep 2013 17:16:33 -0400
Received: from [192.168.1.144]
 (S0106001217476e98.cc.shawcable.net [96.54.68.30])
 by st11p01mm-asmtp003.mac.com
 (Oracle Communications Messaging Server 7u4-27.07(7.0.4.27.6) 64bit (built Jun
 21 2013)) with ESMTPSA id <0MSI006WDLN8X580@st11p01mm-asmtp003.mac.com> for
 git@vger.kernel.org; Mon, 02 Sep 2013 20:16:22 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure
 engine=2.50.10432:5.10.8794,1.0.431,0.0.0000
 definitions=2013-09-02_04:2013-09-02,2013-09-02,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=18 phishscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=7.0.1-1305240000 definitions=main-1309020122
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233659>


--Apple-Mail=_4627D046-509D-4B13-B181-81EE48732D5E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


I've recently re-installed all of my MacPorts installations due to a =
third-party application corrupting my installation. Upon attempting to =
install git-core via MacPorts, it hangs on the "Building" stage, with no =
disk activity (clang process is active in Terminal). So, I attempted to =
download the .pkg install from git-scm.com. This Installer says the =
installation was complete, but Apple's outdated version of git (1.7.3) =
is still the active binary.

Two observations:
1) The README.txt file says that Git will be installed into =
/usr/local/bin
2) The installation actually seems to be installed into /usr/bin, =
according to the installation log, which I have attached. This is the =
same location as Apple's version of Git.

Of particular interest is the PATH variable setting at the very top of =
the log file, which makes no reference to /usr/local/bin... only =
/usr/bin.

        Installer[18576]: Env: PATH=3D/usr/bin:/bin:/usr/sbin:/sbin

I've rarely experienced problems with installing software in the past. =
Is this an oversight on the part of the package assembler, or am I =
missing something?

~Ted


--Apple-Mail=_4627D046-509D-4B13-B181-81EE48732D5E
Content-Disposition: attachment;
	filename="Git Installer Log 2-Sep-2013.txt"
Content-Type: text/plain;
	name="Git Installer Log 2-Sep-2013.txt"
Content-Transfer-Encoding: quoted-printable

Sep  2 13:04:36 topdog Installer[18576]: @(#)PROGRAM:Install  =
PROJECT:Install-735
Sep  2 13:04:36 topdog Installer[18576]: @(#)PROGRAM:Installer  =
PROJECT:Installer-617
Sep  2 13:04:36 topdog Installer[18576]: Hardware: MacBookPro3,1 @ 2.20 =
GHz (x 2), 4096 MB RAM
Sep  2 13:04:36 topdog Installer[18576]: Running OS Build: Mac OS X =
10.8.4 (12E55)
Sep  2 13:04:36 topdog Installer[18576]: Env: =
PATH=3D/usr/bin:/bin:/usr/sbin:/sbin
Sep  2 13:04:36 topdog Installer[18576]: Env: =
TMPDIR=3D/var/folders/h9/d7vc3w7j7jg0lsxsf7bvx6hh0000gn/T/
Sep  2 13:04:36 topdog Installer[18576]: Env: SHELL=3D/bin/bash
Sep  2 13:04:36 topdog Installer[18576]: Env: HOME=3D/Users/tedwood
Sep  2 13:04:36 topdog Installer[18576]: Env: USER=3Dtedwood
Sep  2 13:04:36 topdog Installer[18576]: Env: LOGNAME=3Dtedwood
Sep  2 13:04:36 topdog Installer[18576]: Env: =
SSH_AUTH_SOCK=3D/tmp/launch-dVtpfg/Listeners
Sep  2 13:04:36 topdog Installer[18576]: Env: =
Apple_Ubiquity_Message=3D/tmp/launch-O5o1Ms/Apple_Ubiquity_Message
Sep  2 13:04:36 topdog Installer[18576]: Env: =
Apple_PubSub_Socket_Render=3D/tmp/launch-2hUrBG/Render
Sep  2 13:04:36 topdog Installer[18576]: Env: =
DISPLAY=3D/tmp/launch-AKzVzY/org.macosforge.xquartz:0
Sep  2 13:04:36 topdog Installer[18576]: Env: COMMAND_MODE=3Dunix2003
Sep  2 13:04:36 topdog Installer[18576]: Env: =
__CF_USER_TEXT_ENCODING=3D0x1F5:0:0
Sep  2 13:04:37 topdog Installer[18576]: Git 1.8.3.2  Installation Log
Sep  2 13:04:37 topdog Installer[18576]: Opened from: /Volumes/Git =
1.8.3.2 Snow Leopard Intel =
Universal/git-1.8.3.2-intel-universal-snow-leopard.pkg
Sep  2 13:04:37 topdog Installer[18576]: Product archive /Volumes/Git =
1.8.3.2 Snow Leopard Intel =
Universal/git-1.8.3.2-intel-universal-snow-leopard.pkg trustLevel=3D100
Sep  2 13:06:23 topdog Installer[18576]: InstallerStatusNotifications =
plugin loaded
Sep  2 13:06:29 topdog runner[18604]: Administrator authorization =
granted.
Sep  2 13:06:29 topdog Installer[18576]: =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
Sep  2 13:06:29 topdog Installer[18576]: User picked Standard Install
Sep  2 13:06:29 topdog Installer[18576]: Choices selected for =
installation:
Sep  2 13:06:29 topdog Installer[18576]: 	Upgrade: "Git 1.8.3.2"
Sep  2 13:06:29 topdog Installer[18576]: 	Upgrade: "Git"
Sep  2 13:06:29 topdog Installer[18576]: 		=
git-1.8.3.2-intel-universal-snow-leopard.pkg#git.pkg : =
GitOSX.Installer.git1832.git.pkg : 1
Sep  2 13:06:29 topdog Installer[18576]: 	Upgrade: "etc"
Sep  2 13:06:29 topdog Installer[18576]: 		=
git-1.8.3.2-intel-universal-snow-leopard.pkg#etc.pkg : =
GitOSX.Installer.git1832.etc.pkg : 1
Sep  2 13:06:29 topdog Installer[18576]: =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
Sep  2 13:06:29 topdog Installer[18576]: It took 0.00 seconds to =
summarize the package selections.
Sep  2 13:06:29 topdog Installer[18576]: -[IFDInstallController(Private) =
_buildInstallPlan]: location =3D file://localhost
Sep  2 13:06:29 topdog Installer[18576]: -[IFDInstallController(Private) =
_buildInstallPlan]: =
file://localhost/Volumes/Git%201.8.3.2%20Snow%20Leopard%20Intel%20Universa=
l/git-1.8.3.2-intel-universal-snow-leopard.pkg#git.pkg
Sep  2 13:06:29 topdog Installer[18576]: -[IFDInstallController(Private) =
_buildInstallPlan]: =
file://localhost/Volumes/Git%201.8.3.2%20Snow%20Leopard%20Intel%20Universa=
l/git-1.8.3.2-intel-universal-snow-leopard.pkg#etc.pkg
Sep  2 13:06:29 topdog Installer[18576]: Set authorization level to root =
for session
Sep  2 13:06:29 topdog Installer[18576]: Will use PK session
Sep  2 13:06:29 topdog Installer[18576]: Starting installation:
Sep  2 13:06:29 topdog Installer[18576]: Configuring volume "TopDogHD"
Sep  2 13:06:29 topdog Installer[18576]: Preparing disk for local booted =
install.
Sep  2 13:06:29 topdog Installer[18576]: Free space on "TopDogHD": 13.19 =
GB (13192531968 bytes).
Sep  2 13:06:29 topdog Installer[18576]: Create temporary directory =
"/var/folders/h9/d7vc3w7j7jg0lsxsf7bvx6hh0000gn/T//Install.18576CqNPZq"
Sep  2 13:06:29 topdog Installer[18576]: IFPKInstallElement (2 packages)
Sep  2 13:06:29 topdog Installer[18576]: Using authorization level of =
root for IFPKInstallElement
Sep  2 13:06:29 topdog installd[18607]: installd: Starting
Sep  2 13:06:29 topdog installd[18607]: installd: uid=3D0, euid=3D0
Sep  2 13:06:29 topdog installd[18607]: PackageKit: ----- Begin install =
-----
Sep  2 13:06:29 topdog installd[18607]: PackageKit: =
request=3DPKInstallRequest <2 packages, destination=3D/>
Sep  2 13:06:29 topdog installd[18607]: PackageKit: packages=3D(
	    "PKLeopardPackage =
<file://localhost/Volumes/Git%201.8.3.2%20Snow%20Leopard%20Intel%20Univers=
al/git-1.8.3.2-intel-universal-snow-leopard.pkg#git.pkg>",
	    "PKLeopardPackage =
<file://localhost/Volumes/Git%201.8.3.2%20Snow%20Leopard%20Intel%20Univers=
al/git-1.8.3.2-intel-universal-snow-leopard.pkg#etc.pkg>"
	)
Sep  2 13:06:29 topdog installd[18607]: PackageKit: Will do =
receipt-based obsoleting for package identifier =
GitOSX.Installer.git1832.git.pkg (prefix path=3Dusr/local/git)
Sep  2 13:06:29 topdog installd[18607]: PackageKit: Will do =
receipt-based obsoleting for package identifier =
GitOSX.Installer.git1832.etc.pkg (prefix path=3Detc)
Sep  2 13:06:29 topdog installd[18607]: PackageKit: Extracting =
file://localhost/Volumes/Git%201.8.3.2%20Snow%20Leopard%20Intel%20Universa=
l/git-1.8.3.2-intel-universal-snow-leopard.pkg#git.pkg =
(destination=3D/var/folders/zz/zyxvpxvq6csfxvn_n0000000000000/Cleanup At =
Startup/PKInstallSandboxManager/1.sandbox/Root/usr/local/git, uid=3D0)
Sep  2 13:06:31 topdog installd[18607]: PackageKit: Extracting =
file://localhost/Volumes/Git%201.8.3.2%20Snow%20Leopard%20Intel%20Universa=
l/git-1.8.3.2-intel-universal-snow-leopard.pkg#etc.pkg =
(destination=3D/var/folders/zz/zyxvpxvq6csfxvn_n0000000000000/Cleanup At =
Startup/PKInstallSandboxManager/1.sandbox/Root/etc, uid=3D0)
Sep  2 13:06:31 topdog installd[18607]: PackageKit: prevent user idle =
system sleep
Sep  2 13:06:31 topdog installd[18607]: PackageKit: suspending backupd
Sep  2 13:06:31 topdog installd[18607]: PackageKit: Shoving =
/var/folders/zz/zyxvpxvq6csfxvn_n0000000000000/Cleanup At =
Startup/PKInstallSandboxManager/1.sandbox/Root (2 items) to /
Sep  2 13:06:31 topdog install_monitor[18614]: Temporarily excluding: =
/Applications, /Library, /System, /bin, /private, /sbin, /usr
Sep  2 13:06:31 topdog installd[18607]: PackageKit: Writing receipt for =
GitOSX.Installer.git1832.git.pkg to /private/var/db/receipts
Sep  2 13:06:31 topdog installd[18607]: PackageKit: Writing receipt for =
GitOSX.Installer.git1832.etc.pkg to /private/var/db/receipts
Sep  2 13:06:31 topdog installd[18607]: PackageKit: Touched bundle =
usr/local/git/share/git-gui/lib/Git Gui.app
Sep  2 13:06:31 topdog installd[18607]: Installed "Git 1.8.3.2" ()
Sep  2 13:06:31 topdog install_monitor[18614]: Re-included: =
/Applications, /Library, /System, /bin, /private, /sbin, /usr
Sep  2 13:06:32 topdog installd[18607]: PackageKit: releasing backupd
Sep  2 13:06:32 topdog installd[18607]: PackageKit: allow user idle =
system sleep
Sep  2 13:06:32 topdog installd[18607]: PackageKit: ----- End install =
-----
Sep  2 13:06:32 topdog Installer[18576]: PackageKit: Registered bundle =
file://localhost/usr/local/git/share/git-gui/lib/Git%20Gui.app/ for uid =
501
Sep  2 13:06:32 topdog Installer[18576]: Running install actions
Sep  2 13:06:32 topdog Installer[18576]: Removing temporary directory =
"/var/folders/h9/d7vc3w7j7jg0lsxsf7bvx6hh0000gn/T//Install.18576CqNPZq"
Sep  2 13:06:32 topdog Installer[18576]: Finalize disk "TopDogHD"
Sep  2 13:06:32 topdog Installer[18576]: Notifying system of updated =
components
Sep  2 13:06:32 topdog Installer[18576]:=20
Sep  2 13:06:32 topdog Installer[18576]: **** Summary Information ****
Sep  2 13:06:32 topdog Installer[18576]:   Operation      Elapsed time
Sep  2 13:06:32 topdog Installer[18576]: -----------------------------
Sep  2 13:06:32 topdog Installer[18576]:        disk      0.02 seconds
Sep  2 13:06:32 topdog Installer[18576]:      script      0.01 seconds
Sep  2 13:06:32 topdog Installer[18576]:        zero      0.03 seconds
Sep  2 13:06:32 topdog Installer[18576]:     install      3.15 seconds
Sep  2 13:06:32 topdog Installer[18576]:     -total-      3.22 seconds
Sep  2 13:06:32 topdog Installer[18576]:=20
Sep  2 13:06:32 topdog Installer[18576]: IFDInstallController 2C038770 =
state =3D 5
Sep  2 13:06:32 topdog Installer[18576]: Displaying 'Install Succeeded' =
UI.

--Apple-Mail=_4627D046-509D-4B13-B181-81EE48732D5E--
