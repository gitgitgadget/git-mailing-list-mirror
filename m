From: Matthias Moeller <matthias.moeller@math.tu-dortmund.de>
Subject: Git, Mac OS X and German special characters
Date: Thu, 20 May 2010 09:26:03 +0200
Message-ID: <4BF4E40B.30205@math.tu-dortmund.de>
Reply-To: matthias.moeller@math.tu-dortmund.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 20 09:46:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF0St-0007JA-8d
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 09:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754615Ab0ETHqi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 May 2010 03:46:38 -0400
Received: from nx5.HRZ.Uni-Dortmund.DE ([129.217.131.21]:25636 "EHLO
	nx5.hrz.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599Ab0ETHqf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 03:46:35 -0400
X-Greylist: delayed 1224 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 May 2010 03:46:35 EDT
Received: from mathematik.uni-dortmund.de (Hermes.mathematik.uni-dortmund.de [129.217.151.250])
	by nx5.hrz.uni-dortmund.de (Postfix) with ESMTP id 8378E12D4B
	for <git@vger.kernel.org>; Thu, 20 May 2010 09:26:09 +0200 (MET DST)
Received: from [129.217.151.146] (starbuck [129.217.151.146])
	by mathematik.uni-dortmund.de (8.13.8+Sun/8.13.8) with ESMTP id o4K7Q97G012273
	for <git@vger.kernel.org>; Thu, 20 May 2010 09:26:09 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100317 SUSE/3.0.4-2.3 Lightning/1.0b1 Thunderbird/3.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147358>

Hi,

I have been using git (version 1.7.1) for quite some time to
backup/synchronize folders between my two linux workstations at home an=
d
at work and my Apple laptop. Synchronization works well except for some
strange behavior under Mac OS X (10.6).

I have commited some files with German special characters, say,
"=DCbersicht.xls" under linux and pulled them on the Macbook. However, =
on
the laptop git status says:

# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       "U\314\210bersicht.xls"
nothing added to commit but untracked files present (use "git add" to t=
rack)

I have been searching the web for help and found lengthy discussions
which state that this is a common problem of the HFS+ filesystem.
What I did not find was a solution to this problem. Is there a solution
to this problem?

Thanks,
Matthias
