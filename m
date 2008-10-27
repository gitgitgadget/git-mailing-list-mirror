From: "Robert Boone" <robo4288@gmail.com>
Subject: Some hooks turned on by default in FreeBSD 4
Date: Mon, 27 Oct 2008 14:14:54 -0500
Message-ID: <435624390810271214s16b964cbo131772ea4a760ef7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 27 20:21:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuXey-0005kX-2i
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 20:21:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308AbYJ0TUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 15:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752239AbYJ0TUW
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 15:20:22 -0400
Received: from mail-gx0-f18.google.com ([209.85.217.18]:53333 "EHLO
	mail-gx0-f18.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059AbYJ0TUU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 15:20:20 -0400
X-Greylist: delayed 324 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Oct 2008 15:20:20 EDT
Received: by gxk11 with SMTP id 11so565706gxk.13
        for <git@vger.kernel.org>; Mon, 27 Oct 2008 12:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=2TEpn4y4Wm10vZTiPI614C4mhcvs3MBefHfabnPV8nM=;
        b=HEnMPY1/CCs9/5bHoMGK8vefoZmPcukvR83b+uGFtW/9bpnahfQATgq+/AC6YfpRFV
         8+zO72Yr42wMje2iHyS6wQjzO073/ZgeA+sSgAfcgrt2+NmxUP1FJwEL5ZGm2//8n+nY
         UouM+BilM9MbchI7G/5JZ2lRrfLwT1e1RKRXs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=pYYROgKWCbWMDh5cSRB2hXHwyNkw8Pel5mMwqlkTmgNae6N/7HUTun27g49csaEQ/F
         AiYjq2s7M2GtoMML06kF+R5c4IMYhbBLD1Mu8MdjJ/fHCLea9Jx26dUUN27gMCr1JtPm
         +9Fb+NmWeqWXRFOG0t1+kqCCoAzUb1sgz9PeU=
Received: by 10.142.212.19 with SMTP id k19mr554546wfg.13.1225134894633;
        Mon, 27 Oct 2008 12:14:54 -0700 (PDT)
Received: by 10.142.187.5 with HTTP; Mon, 27 Oct 2008 12:14:54 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99252>

This was a fresh install from the git repository using the master branch
git version: 1.6.0.3.523.g304d0


Is this something that can be fixed with a recompile and different arguments?


[root@user /usr/local/cpanel.git]# git commit
fatal: exec .git/hooks/pre-commit failed.
[root@user /usr/local/cpanel.git]# ls -l .git/hooks/
total 52
-rw-r--r--  1 root  wheel   441 Oct 27 10:14 applypatch-msg
-rwxr-xr-x  1 root  wheel   452 Oct 27 10:14 applypatch-msg.sample
-rw-r--r--  1 root  wheel   887 Oct 27 10:14 commit-msg
-rwxr-xr-x  1 root  wheel   894 Oct 27 10:14 commit-msg.sample
-rw-r--r--  1 root  wheel   152 Oct 27 10:14 post-commit
-rwxr-xr-x  1 root  wheel   160 Oct 27 10:14 post-commit.sample
-rw-r--r--  1 root  wheel   510 Oct 27 10:14 post-receive
-rwxr-xr-x  1 root  wheel   553 Oct 27 10:14 post-receive.sample
-rw-r--r--  1 root  wheel   207 Oct 27 10:14 post-update
-rwxr-xr-x  1 root  wheel   189 Oct 27 10:14 post-update.sample
-rw-r--r--  1 root  wheel   387 Oct 27 10:14 pre-applypatch
-rwxr-xr-x  1 root  wheel   398 Oct 27 10:14 pre-applypatch.sample
-rw-r--r--  1 root  wheel  1706 Oct 27 10:14 pre-commit
-rwxr-xr-x  1 root  wheel   519 Oct 27 10:14 pre-commit.sample
-rw-r--r--  1 root  wheel  4262 Oct 27 10:14 pre-rebase
-rwxr-xr-x  1 root  wheel  4942 Oct 27 10:14 pre-rebase.sample
-rw-r--r--  1 root  wheel  1196 Oct 27 10:14 prepare-commit-msg
-rwxr-xr-x  1 root  wheel  1219 Oct 27 10:14 prepare-commit-msg.sample
-rw-r--r--  1 root  wheel  2910 Oct 27 10:14 update
-rwxr-xr-x  1 root  wheel  2892 Oct 27 10:14 update.sample
