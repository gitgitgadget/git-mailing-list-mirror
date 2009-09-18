From: Toan Pham <tpham3783@gmail.com>
Subject: Big project, slow access!
Date: Fri, 18 Sep 2009 14:38:03 -0400
Message-ID: <ffb2c0280909181138r7fde8722n80be4bdf95864c37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 18 20:43:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoiQq-0004SL-C3
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 20:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757688AbZIRSnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2009 14:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757558AbZIRSne
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Sep 2009 14:43:34 -0400
Received: from mail-qy0-f171.google.com ([209.85.221.171]:32954 "EHLO
	mail-qy0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757592AbZIRSne (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2009 14:43:34 -0400
X-Greylist: delayed 332 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2009 14:43:32 EDT
Received: by qyk1 with SMTP id 1so1091371qyk.22
        for <git@vger.kernel.org>; Fri, 18 Sep 2009 11:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=gkULe6wIN8dnUzQ3tGXYiQtIgepx8j1beD1YbFRRed8=;
        b=BzcrJVjRShhZGIotBGpMhfPfTPJJzgQ2YShV01MLH1U8MZjE/MfY5KGAse2i+sXO+8
         vtNacuq7EmF/KWjp1KYZIZ46t3dzAfc6vOKgmpekubDycLxqtNWD/1mrnqlhaOtK1ynK
         ccI0RPH6z90ubD/zqpVm4SK5dkcqNO2ixzChg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=K1JNZNFgpYirFizLepYH2aUuToyY6CHqb5A6+Ie0FxIOc+NBruT5Kil3RYBZnDMxrH
         Xv8Ue5kuLXNSrjaf0OHorKii/cXGM2o5lr0KpxLxqJjpuTQC5OevKJ0pnJtHs89BAPQ6
         X3Q5l2odklZkEBpPevSEcygMH5R1q5vOND6GY=
Received: by 10.229.31.147 with SMTP id y19mr600850qcc.5.1253299083259; Fri, 
	18 Sep 2009 11:38:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128803>

Hi,

I use git to maintain a project that is at least 8 gigs in size.
The project is a Linux from Scratch repository that includes source
codes to approximately 2000 open source projects,
gcc tool-chain, 1000+ configurations for different software packages,
source code for different kernel versions,
and many linux distributions/flavors resulted from this LFS build environment.

The git's object repository is now 4.6 gigs and consists of approx.
610,000 files and folders.
The speed of git is now terribly slow.  Each time I use basic commands
like 'git status' or 'git diff',
it would take at least 5 minutes for git to give me back a result.
Again, the machine that i run git on is a P4 3.2 gig-hertz with HT.

would  someone please recommend on how i can optimize git's performance?
Git is so slow, are there better ways to manage a project like this?


Thank you.


Toan
