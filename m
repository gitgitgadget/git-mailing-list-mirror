From: Ted Wood <coolfactor@mac.com>
Subject: Re: Git installation on Mac OS X - problem
Date: Mon, 02 Sep 2013 13:26:53 -0700
Message-ID: <2DA3B860-6AE0-4C2E-9B6B-BA3BA36C63B8@mac.com>
References: <4EA7B5FB-14EF-4106-B52E-3A28B85AFAF2@mac.com>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 02 22:27:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGaiS-0006OW-AY
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 22:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757288Ab3IBU06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 16:26:58 -0400
Received: from st11p01mm-asmtpout005.mac.com ([17.172.204.240]:62343 "EHLO
	st11p01mm-asmtp005.mac.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755287Ab3IBU06 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 2 Sep 2013 16:26:58 -0400
X-Greylist: delayed 626 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Sep 2013 16:26:57 EDT
Received: from [192.168.1.144]
 (S0106001217476e98.cc.shawcable.net [96.54.68.30])
 by st11p01mm-asmtp005.mac.com
 (Oracle Communications Messaging Server 7u4-27.07(7.0.4.27.6) 64bit (built Jun
 21 2013)) with ESMTPSA id <0MSI0045EM4UZE10@st11p01mm-asmtp005.mac.com> for
 git@vger.kernel.org; Mon, 02 Sep 2013 20:26:55 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure
 engine=2.50.10432:5.10.8794,1.0.431,0.0.0000
 definitions=2013-09-02_04:2013-09-02,2013-09-02,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=5 phishscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=7.0.1-1305240000 definitions=main-1309020123
In-reply-to: <4EA7B5FB-14EF-4106-B52E-3A28B85AFAF2@mac.com>
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233657>


Sorry... I misread the README... it does indeed say /usr/local/git, which is where the new binary was installed correctly. Eyes have been crossed by all of these software re-installations and terminal commands. :P

Thanks.

~Ted



On 2013-09-02, at 1:16 PM, Ted Wood <coolfactor@mac.com> wrote:

> 
> I've recently re-installed all of my MacPorts installations due to a third-party application corrupting my installation. Upon attempting to install git-core via MacPorts, it hangs on the "Building" stage, with no disk activity (clang process is active in Terminal). So, I attempted to download the .pkg install from git-scm.com. This Installer says the installation was complete, but Apple's outdated version of git (1.7.3) is still the active binary.
> 
> Two observations:
> 1) The README.txt file says that Git will be installed into /usr/local/bin
> 2) The installation actually seems to be installed into /usr/bin, according to the installation log, which I have attached. This is the same location as Apple's version of Git.
> 
> Of particular interest is the PATH variable setting at the very top of the log file, which makes no reference to /usr/local/bin... only /usr/bin.
> 
>        Installer[18576]: Env: PATH=/usr/bin:/bin:/usr/sbin:/sbin
> 
> I've rarely experienced problems with installing software in the past. Is this an oversight on the part of the package assembler, or am I missing something?
> 
> ~Ted
> 
> <Git Installer Log 2-Sep-2013.txt>
